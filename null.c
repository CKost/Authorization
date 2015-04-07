// null.c
// Device

#include "fs.h"
#include "file.h"

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
