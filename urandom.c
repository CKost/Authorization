// urandom.c

// linear congruential random number generator in python
/*a = 3
c = 9
m = 16
xi = 0

def seed(x):
    global xi
    xi = x

def rng():
    global xi
    xi = (a*xi + c)%m
    return xi

for i in range(10):
    print rng()
*/

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
urandomread(struct inode *ip, char *dst, int n)
{
  int i = 0;
  for (; i < n; ++i)
  {
    dst[i] = 'i';
  }
  return i;
}

int
urandomwrite(struct inode *ip, char *buf, int n)
{
    return 0;
}

void
urandominit(void)
{
    devsw[DEV_URANDOM].write = urandomwrite;
    devsw[DEV_URANDOM].read = urandomread;
}
