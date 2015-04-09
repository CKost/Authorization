#include "types.h"
#include "stat.h"
#include "user.h"

int STDOUT = 1;

int uaccess(c){

	printf(STDOUT,"access sys call");
	

	
	return 0;
}


int
main(int argc, char **argv)
{
	
	uaccess();
  exit();
}
