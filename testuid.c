// Returns UID

#include "types.h"
#include "stat.h"
#include "user.h"

int
main(void)
{
  printf(1, "Getting UID...\nUID: %d\n", getuid());
  exit();
}
