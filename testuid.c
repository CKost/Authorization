// Returns UID

#include "types.h"
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
  printf(1, "Getting UID...\nUID: %d\n", getuid());
  if (argc > 1){
	setuid(atoi(argv[1]));
	printf(1, "Setting UID to %d\n", atoi(argv[1]));
  }
  exit();
}
