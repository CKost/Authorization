// Read in input and send it to /dev/null
// should see no output and not blow up

#include "types.h"
#include "user.h"
#include "fcntl.h"

char buf[512];

int
main(void)
{
  int n, fd;

  fd = open("null", O_WRONLY);

  while((n = read(0, buf, sizeof(buf))) > 0){
    write(fd, buf, n);
  }
  if(n < 0){
    printf(1, "testnull: read error\n");
  }
  exit();
}
