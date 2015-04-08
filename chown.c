#include "types.h"
#include "stat.h"
#include "user.h"

int STDOUT = 1;

int uchown(char* file_name, uint new_UIDNumb){

	printf(STDOUT,"%s%s%s%d\n", "You changed ", file_name, " to ", new_UIDNumb);

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
