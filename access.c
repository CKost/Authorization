#include "types.h"
#include "stat.h"
#include "user.h"

int STDOUT = 1;

int uaccess(c){

	printf(STDOUT,"access sys call");
	//calls sys_chmod here.  needs to give it a file (Check the file is in the path) and the short.

	//TODO verify file
	//todo pass args to chmod
	
	return 0;
}


int
main(int argc, char **argv)
{
	
	uaccess();
  exit();
}
