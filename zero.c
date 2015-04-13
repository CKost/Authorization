// zero.c
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
zeroread(struct inode *ip, char *dst, int n)
{
	int i = 0;
	for (; i < n; ++i)
	{
		dst[i] = '\0';
	}
  	return i;
}

int
zerowrite(struct inode *ip, char *buf, int n)
{
  	return 0;
}

void
zeroinit(void)
{
  	devsw[DEV_ZERO].write = zerowrite;
  	devsw[DEV_ZERO].read = zeroread;
}