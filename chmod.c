#include "types.h"
#include "stat.h"
#include "user.h"

int STDOUT = 1;

int uchmod(char* file_name, short new_permBit){

	printf(STDOUT,"%s%s%s%d\n", "You changed ", file_name, " to ", new_permBit);
	//calls sys_chmod here.  needs to give it a file (Check the file is in the path) and the short.

	//TODO verify file
	//todo pass args to chmod
	int x = chmod(file_name, new_permBit);
	printf(1,"%d\n",x );
	return 0;
}


int
main(int argc, char **argv)
{
	if(argc != 3){
		printf(STDOUT, "Please give a file, and a Permission Bit\nNo files Changed\n$ chmod FILE Perm_Bit\
			\nWhere permission bit is defined as follows:\
			\n7 - Owner Read blah blah blah\
			\n");
		exit();
	}
	uchmod(argv[1], atoi(argv[2]));
  exit();
}
