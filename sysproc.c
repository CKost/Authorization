#include "types.h"
#include "x86.h"
#include "defs.h"
#include "date.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
  return fork();
}

int
sys_exit(void)
{
  exit();
  return 0;  // not reached
}

int
sys_wait(void)
{
  return wait();
}

int
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
  return kill(pid);
}

int
sys_getpid(void)
{
  return proc->pid;
}

int
sys_getppid(void)
{

  if(proc->pid < 2){
    return -1;

  }
  int parent_pid;
  parent_pid = proc->parent->pid;


  return parent_pid;
}

int
sys_sbrk(void)
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = proc->sz;
  if(growproc(n) < 0)
    return -1;
  return addr;
}

int
sys_sleep(void)
{
  int n;
  uint ticks0;
  
  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
    if(proc->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
  uint xticks;
  
  acquire(&tickslock);
  xticks = ticks;
  release(&tickslock);
  return xticks;
}


//GROUP PROJECT TO ADD SYS CALLS
int
sys_chown(void)
{
  //changes the file to be owned by someone else.
  char* file_name = 0;
  int ip = 0;
  if(argint(1, &ip) < 0)
    return -1;
  int x = fetchstr(0,&file_name);
  if(argptr(0, &file_name, x) < 0)
    return -1;
  //kprintf(file_name[0]);//(1,"%s\n", file_name);
  return file_name[0];
  return ip;
}


int 
sys_chmod(void)
{
  //will eventually check the user's id to make sure they are the owner of the file.
    //printf(1, "%s\n%d\n",file_name,new_UIDNumb );

    return -1;
}

int 
sys_access(void) // added by Curtis
{
    int x  =0;
    return x;
}
