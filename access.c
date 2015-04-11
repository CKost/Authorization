#include "types.h"
#include "stat.h"
#include "user.h"

int STDOUT = 1;

/*----------------------------------------
Method Name: uaccess
Method Description: Backbone of the access
system call
Method Return: 0 if successful, 1 if failed
----------------------------------------*/
int uaccess(uint varX , char* filename, char perm ){   
	int permInt = -1;
	if ('X' == perm || 'x' == perm)
		permInt = 4;
	if ('W' == perm || 'w' == perm)
		permInt = 2;
	if ('R' == perm || 'r' == perm)
		permInt = 1;
	if(permInt == -1){
		printf(1, "Please check R, W, X\n");
		return 0;
	}

    int x = access( varX, filename, permInt);
	//printf(STDOUT,"access sys call\n");
	if(x ==0){
		//CAN Access
		printf(1,"File Can Be Accessed\n");
		return x; // should be 0
	}
	
	if(x==1){
		//CANNOT ACCESS
		printf(1,"File Cannot Be Accessed\n");
		return x; // should be 1
	}

	if (x==2)
	{
		printf(1,"%s\n", "File Can't be Accessed");
		return x;
	}

	printf(1,"There was an error trying to get the neccessary file data\n");	
	return 1;
}


int
main(int argc, char **argv)
{
	//Takes:
    //User X (UID)
    // File Y
   	//  Purpose Z
   	// Ensure that proper number of variables are present
	if(argc != 4)
	{   
		printf(1,"Requires 3 Args: User X, File Y, Perm Z\n");
		exit();
	}

   	uaccess(atoi(argv[1]),argv[2], argv[3][0]);
  	exit();
  	return 0; // shouldn't ever reach here but ya never know... it is C...
}