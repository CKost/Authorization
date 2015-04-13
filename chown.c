#include "types.h"
#include "stat.h"
#include "user.h"

int STDOUT = 1;

int 
uchown(char* file_name, uint new_UIDNumb){

	if(new_UIDNumb == -1){
		printf(1, "%s UID is %d\n",file_name, chown(file_name, -1));
	}else{
		if(getuid() == 0){
			return chown(file_name, new_UIDNumb);
			
		}else{
			printf(1, "Invalid Permissions must be root\n");
			return -3;
		}
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
	if((int)*argv[2] == 63){
		uchown(argv[1],-1);
	}else{
		int x = uchown(argv[1], atoi(argv[2]));


		if(-1 == x){
			printf(1, "Error: File Name Invalid\n");
		}
		if(-2 == x){
			printf(1, "Error: Not a valid UID\n");
		}
		if (0 == x)
		{
			printf(STDOUT,"%s%s%s%s\n", "You changed ", argv[1], " to ", argv[2]);
		}
	}
	
 	 exit();

}