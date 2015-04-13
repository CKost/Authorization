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

  fd = open("zero", O_RDONLY);

  n = read(fd, buf, sizeof(buf));

  if (n < sizeof(buf)) {
  	//wrongo
  	printf(1, "testzero: size of n is less than size of buf\n");
  }

  if(n < 0){
    printf(1, "testzero: read error (maybe, we think so...)\n");
  }

  // loop de buf
  i = 0;
  for (; i < 512; ++i) {
  	if (buf[i] == 1) { 
  		//fail
  		printf(1, "testzero: we left a 1 somewhere (fail)\n");
  		exit();
  	}
  }
  printf(1, "success, maybe, we think so....\n");
  exit();
}
