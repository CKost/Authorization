// zero.c
// Device

#include "fs.h"
#include "file.h"

int
zeroread(struct inode *ip, char *dst, int n)
{
	int i = 0;
	for (; i < n; ++i)
	{
		dst[i] = '\0';
	}
  	return dst;
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