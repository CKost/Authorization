#include "types.h"
#include "stat.h"
#include "user.h"

int STDOUT = 1;

int uchmod(char* file_name, short new_permBit){

	int x = chown(file_name, new_permBit);
	if(-1 == x){
		printf(1, "Error: File Name Invalid\n");
		return 0;
	}
	if(-2 == x){
		printf(1, "Error: Not a valid UID\n");
		return 0;
	}

	if(-3 == x){

		printf(1, "Error: Could not obtain i-node\n");
		return 0;
	}

	if(new_permBit == -1){
		printf(1, "%s Permissions are %d\n",file_name, x);
	}else{
		printf(STDOUT,"%s%s%s%d\n", "You changed ", file_name, " to ", x);
	}
	return 0;
}
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
