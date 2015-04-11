#include "types.h"
#include "stat.h"
#include "user.h"

int STDOUT = 1;

int uchmod(char* file_name, int OBit, int WBit){
	uint new_OBit = 0;
	uint new_WBit = 0;
	if (WBit == -1)
	{
		new_OBit = -1;
		new_WBit = 0;
	}else{
		new_OBit = OBit;
		new_WBit = WBit;
	}
	int x = chmod(file_name, new_OBit, new_WBit);
	if(-1 == x){
		printf(1, "Error: File Name Invalid\n");
		return 0;
	}
	if(-2 == x){
		printf(1, "Error: Not a valid permission\n");
		return 0;
	}

	if(-3 == x){

		printf(1, "Error: Could not obtain i-node\n");
		return 0;
	}	
	if(-4 == x){

		printf(1, "Error: You do not have permission to change this\n");
		return 0;
	}

	if(WBit == -1){
		printf(1, "%s Permissions are %d\n",file_name, x);
	}else{
		printf(STDOUT,"%s%s%s%d\n", "You changed ", file_name, " to ", x);
	}
	return 0;
}


int
main(int argc, char **argv)
{
	if(argc < 3){
		printf(STDOUT, "Please give a file, and a Permission Bit\nNo files Changed\n$ chmod FILE Perm_Bit\
			\nWhere permission bit is defined as follows:\
			\n7 - Owner Read blah blah blah\
			\n");
		exit();
	}
	if(argc == 4){
		// they gave us stuff!!

		if(access(getuid(), argv[1], 4) == 0 && access(getuid(), argv[1], 2) == 0){
			uchmod(argv[1], atoi(argv[2]), atoi(argv[3]));
		}
		else{
			printf(1, "You do not have permission to change this\n");
		}
		exit();
	}
	if(argc == 3){
		// it was probably a question mark
		uchmod(argv[1], atoi(argv[2]), -1);
	}




  exit();
}
