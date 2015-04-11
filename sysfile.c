//
// File-system system calls.
// Mostly argument checking, since we don't trust
// user code, and calls into file.c and fs.c.
//

#include "types.h"
#include "defs.h"
#include "param.h"
#include "stat.h"
#include "mmu.h"
#include "proc.h"
#include "fs.h"
#include "file.h"
#include "fcntl.h"
#include "syscall.h"



// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=proc->ofile[fd]) == 0)
    return -1;
  if(pfd)
    *pfd = fd;
  if(pf)
    *pf = f;
  return 0;
}

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd] == 0){
      proc->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
}



int
sys_dup(void)
{
  struct file *f;
  int fd;
  
  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
}

int
sys_read(void)
{
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
  return fileread(f, p, n);
}

int
sys_write(void)
{
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
  return filewrite(f, p, n);
}

int
sys_close(void)
{
  int fd;
  struct file *f;
  
  if(argfd(0, &fd, &f) < 0)
    return -1;
  proc->ofile[fd] = 0;
  fileclose(f);
  return 0;
}

int
sys_fstat(void)
{
  struct file *f;
  struct stat *st;
  
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
    return -1;
  return filestat(f, st);
}

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
    return -1;

  begin_op();
  if((ip = namei(old)) == 0){
    end_op();
    return -1;
  }

  ilock(ip);
  if(ip->type == T_DIR){
    iunlockput(ip);
    end_op();
    return -1;
  }

  ip->nlink++;
  iupdate(ip);
  iunlock(ip);

  if((dp = nameiparent(new, name)) == 0)
    goto bad;
  ilock(dp);
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    iunlockput(dp);
    goto bad;
  }
  iunlockput(dp);
  iput(ip);

  end_op();

  return 0;

bad:
  ilock(ip);
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
}

// Is the directory dp empty except for "." and ".." ?
static int
isdirempty(struct inode *dp)
{
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("isdirempty: readi");
    if(de.inum != 0)
      return 0;
  }
  return 1;
}

//PAGEBREAK!
int
sys_unlink(void)
{
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
    return -1;

  begin_op();
  if((dp = nameiparent(path, name)) == 0){
    end_op();
    return -1;
  }

  ilock(dp);

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
    goto bad;
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
    iunlockput(ip);
    goto bad;
  }

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  if(ip->type == T_DIR){
    dp->nlink--;
    iupdate(dp);
  }
  iunlockput(dp);

  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);

  end_op();

  return 0;

bad:
  iunlockput(dp);
  end_op();
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    return 0;
  ilock(dp);

  if((ip = dirlookup(dp, name, &off)) != 0){
    iunlockput(dp);
    ilock(ip);
    if(type == T_FILE && ip->type == T_FILE)
      return ip;
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
    panic("create: ialloc");

  ilock(ip);
  ip->major = major;
  ip->minor = minor;
  ip->nlink = 1;
  ip->UID   = proc->uid; // defaults to current user
  ip->permBit = 0x74; // defaults to owner all rights and world Read
  iupdate(ip);

  if(type == T_DIR){  // Create . and .. entries.
    dp->nlink++;  // for ".."
    iupdate(dp);
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
      panic("create dots");
  }

  if(dirlink(dp, name, ip->inum) < 0)
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}

int
sys_open(void)
{
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
    return -1;

  begin_op();

  if(omode & O_CREATE){
    ip = create(path, T_FILE, 0, 0);
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    // file doesn't exist
    if((ip = namei(path)) == 0){
      end_op();
      return -1;
    }
    ilock(ip);
    if(ip->type == T_DIR && omode != O_RDONLY){
      iunlockput(ip);
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
  end_op();
  

  //ADDING SYS ACCESS CALL HERE. Copied/Pasted ACCESS Sys Call Contents Here
//
//  begin_op();
//  ilock(ip);
//  int UID = proc->uid;
//  int permBit = ip->permBit;
//  int ownerOfFile = ip->UID;
//  int checkBits = 0;
//  iunlock(ip);
//  end_op();
//  if(omode == O_RDONLY){
//    checkBits = 4;
//  }else{
//    if(omode == O_WRONLY){
//      checkBits = 2;
//    }else{
//      if(omode == O_RDWR){
//        checkBits = 6;
//      }
//    }
//  }
//
//  // if they're the ownerOfFile of the file or ROOT
//  if (ownerOfFile == UID || 0 == UID)
//  {
//    if((permBit & (checkBits << 4)) != (checkBits << 4)){
//      end_op();
//      return -1;
//    }
//  }else{
//    // check the planet
//    if((permBit & (checkBits)) != checkBits){
//      // no you don't have permission
//      end_op();
//      return -1;
//    }
//  }
//
  	 
  //END ADDING NEW CODE TO THIS CALL
  
  f->type = FD_INODE;
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  return fd;
  
}

int
sys_mkdir(void)
{
  char *path;
  struct inode *ip;

  begin_op();
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0)
  {
    end_op();
    return -1;
  }

  iunlockput(ip);
  end_op();
  return 0;
}

int
sys_mknod(void)
{
  struct inode *ip;
  char *path;
  int len;
  int major, minor;
  
  begin_op();
  if((len=argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0)
  {
    end_op();
    return -1;
  }

  iunlockput(ip);
  end_op();
  return 0;
}

int
sys_chdir(void)
{
  char *path;
  struct inode *ip;

  begin_op();
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0)
  {
    end_op();
    return -1;
  }

  ilock(ip);

  if(ip->type != T_DIR)
  {
    iunlockput(ip);
    end_op();
    return -1;
  }

  iunlock(ip);
  iput(proc->cwd);
  path = processpath(proc->wdpath,path);
  strncpy(proc->wdpath,path,256);
  end_op();
  proc->cwd = ip;
  return 0;
}

int
sys_exec(void)
{
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
  }
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
}

int
sys_pipe(void)
{
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
    return -1;
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      proc->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
}

//----- BEGIN AUTHZ SYSTEM CALLS -----
//----------------------------------------
//Method Name: sys_chown
//Method Description: Checks permission bits
//to provide information about user
//Method Return: 0 if successful, 
//varying values if failed
//----------------------------------------
int
sys_chown(void)
{
  char* path;
  int UID;
  struct inode *ip;
  // get arguments from userland
  if(argstr(0, &path) < 0 || argint(1, &UID) < 0){
    return -1;
  }

  begin_op();
  if((ip = namei(path)) == 0){
    end_op();
    return -2;
  }

  ilock(ip);

  if(UID == -1){
    int y = ip->UID;
    iunlock(ip);
    end_op();
    return y;    
  }

  ip->UID = UID;
  iupdate(ip);
  iunlock(ip);
  end_op();
  return 0;


}

//----------------------------------------
//Method Name: sys_chmod
//Method Description: Changes permission bits
//Method Return: 0 if successful, 
//varying values if failed
//----------------------------------------
int 
sys_chmod(void)
{
  //will eventually check the user's id to make sure they are the owner of the file.
  //changes the file to be owned by someone else.
  char* path;
  int OpermBit;
  int WpermBit;
  struct inode *ip;

  if(argstr(0, &path) < 0){
    return -1;
  }
  if(argint(1, &OpermBit) < 0 || argint(2, &WpermBit) < 0){
    return -2;
  }

  begin_op();
  if((ip = namei(path)) == 0){
    end_op();
    return -3;
  }
  ilock(ip);
  if(OpermBit == -1){
    int y = ip->permBit;
    iunlock(ip);
    end_op();
    return y;   
  }
  int x = OpermBit;
  x = x << 4;
  x = x + WpermBit;
  ip->permBit = x;
  
  
  iupdate(ip);
  iunlock(ip);
  end_op();
  return x;

}

//----------------------------------------
//Method Name: sys_access
//Method Description: Checks to see if 
//user X can access file Y
//Method Return: 0 if successful, 1 if failure
//----------------------------------------
int 
sys_access(void) // added by Curtis
{
  int UID = -1;  //Arg1
  char* file_name = 0; //Arg2
  int checkBit = 0; // Arg3
  struct inode *ip;

  if(argint(0, &UID) < 0)
    return 1;
  
  if(argstr(1, &file_name) < 0)
    return 1;

  if(argint(2, &checkBit) < 0)
    return 1;

  begin_op();

  if((ip = namei(file_name)) == 0)
  {
    end_op();
    return 1;
  }

  ilock(ip);
  int permBit = ip->permBit;
  int ownerOfFile   = ip->UID;
  iunlock(ip);
  // if they're the ownerOfFile of the file or ROOT
  if (ownerOfFile == UID || 0 == UID)
  {
    /* code */
  if((permBit & (checkBit << 4)) != (checkBit << 4)){
    // no you don't have permission
    // go check world
  }else{
    // yes you do.
    end_op();
    return 0;
  }
  }
  // check the planet
  if((permBit & (checkBit)) != (checkBit)){
    // no you don't have permission
    end_op();
    return 2;
  }else{
    // yes you do.
    end_op();
    return 0;
  }


  end_op();
  return 1;
}//End Access
