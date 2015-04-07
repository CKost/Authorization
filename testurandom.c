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

  fd = open("urandom", O_RDONLY);

  n = read(fd, buf, sizeof(buf));

  if (n < sizeof(buf)) {
  	//wrongo
  	printf(1, "urandom: size of n is less than size of buf\n");
  }

  if(n < 0){
    printf(1, "urandom: read error (maybe, we think so...)\n");
  }

  // loop de buf
  i = 0;
  for (; i < 512; ++i) {
  	printf(1, "%c",buf[i]);
  }
  printf(1, "\nsuccess, maybe, we think so....\n");
  exit();
}
