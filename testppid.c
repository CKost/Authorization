#include "types.h"
#include "stat.h"
#include "user.h"

int STDOUT = 1;

int
main(void)
{
  printf(STDOUT, "Daniel Recker/dreck410\n\
\tProcess PID = %d\n\
\tParent PID  = %d\n",getpid(), getppid() );

  exit();
}
