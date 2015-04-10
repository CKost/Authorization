#include "types.h"
#include "stat.h"
#include "user.h"

int STDOUT = 1;

int uaccess(uint varX , char* filename ){
   
    int x = access( varX, filename);
	printf(STDOUT,"access sys call\n");
	if(x ==0){
		//CAN Access
		printf(1,"File Can Be Accessed\n");
		return x;
	}
	if(x==1){
		//CANNOT ACCESS
		printf(1,"File Cannot Be Accessed\n");
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
        if(argc != 3){ //4 Because call style is: access x y  
		printf(1,"Requires 2 Args: User X, File Y\n");
        
        exit();
        }
    
   uaccess(atoi(argv[1]),argv[2]);
  exit();
}
