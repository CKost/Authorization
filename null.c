// null.c
// Device

#include "types.h"
#include "defs.h"
#include "param.h"
#include "traps.h"
#include "spinlock.h"
#include "fs.h"
#include "file.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
#include "x86.h"

int
nullread(struct inode *ip, char *dst, int n)
{
  return 0;
}

int
nullwrite(struct inode *ip, char *buf, int n)
{
  return n;
}

void
nullinit(void)
{
  devsw[DEV_NULL].write = nullwrite;
  devsw[DEV_NULL].read = nullread;
}
