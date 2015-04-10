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
sys_getuid(void)
{
  return proc->uid;
}

int
sys_setuid(void)
{
  uint uargv;
  argint(0, (int*)&uargv);
  proc->uid = uargv;
  return 0;
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

// Quit system call
// Sends I/O command to kernel to shutdown system.
// Code found through lots of Google digging and 
// much Stack Overlowing.
int
sys_quit(void)
{
  cprintf("XV6 Shutting Down. Goodbye!\n");
  outw( 0xB004, 0x0 | 0x2000 );
  return 0;
}
// return the current process' working directory
int
sys_getcwd(void)
{
  char *addr;
  int n;

  if(argint(1, &n) < 0)
    return -1;
  if(argstr(0, &addr) < 0)
    return -1;
  strncpy(addr,proc->wdpath,n);
  return (int)addr;
}
