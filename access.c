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
int uaccess(uint varX , char* filename ){   
    int x = access( varX, filename);
	printf(STDOUT,"access sys call\n");
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
	if(argc != 3)
	{   
		printf(1,"Requires 2 Args: User X, File Y\n");
		exit();
	}

   	uaccess(atoi(argv[1]),argv[2]);
  	exit();
  	return 0; // shouldn't ever reach here but ya never know... it is C...
}