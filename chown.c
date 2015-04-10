#include "types.h"
#include "stat.h"
#include "user.h"

int STDOUT = 1;

int uchown(char* file_name, uint new_UIDNumb){
	printf(1, "%s\n", file_name);
	int x = chown(file_name, new_UIDNumb);
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
	if(new_UIDNumb == (int)'?'){
		printf(1, "%s UID is %d\n",file_name, x);
	}else{
		printf(STDOUT,"%s%s%s%d\n", "You changed ", file_name, " to ", x);
	}
	return 0;
}


int
main(int argc, char **argv)
{
	if(argc != 3){
		printf(STDOUT, "Please give a file, and a User ID\nNo files Changed\n$ chown FILE USER_Number\n");
		exit();
	}
	uchown(argv[1], atoi(argv[2]));
  exit();
}
