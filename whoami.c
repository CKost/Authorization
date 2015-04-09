//user program to test getuid syscall

#include "types.h"
#include "stat.h"
#include "user.h"


int
main(void)
{

  printf(1, "Current process UID: %d\n", getuid());
      

}
