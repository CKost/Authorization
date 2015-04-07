// testzero

// Read in input and send it to /dev/null
// should see no output and not blow up

#include "types.h"
#include "user.h"
#include "fcntl.h"

char buf[512];

int
main(void)
{
  int n, fd, i;

  i = 0;

  for (;i < 512; ++i) {
  	buf[i] = '1';
  }

  fd = open("zero", O_WRONLY);

  n = read(fd, buf, sizeof(buf));

  if (n < sizeof(buf)) {
  	//wrongo
  	printf(1, "testzero: size of n is less than size of buf\n");
  }

  if(n < 0){
    printf(1, "testzero: read error\n");
  }
  exit();
}
