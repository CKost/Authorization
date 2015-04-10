#include "types.h"
#include "stat.h"
#include "user.h"

int STDOUT = 1;

int uaccess(uint varX , char* filename , short varZ){
   
    int x = access( varX, filename, varZ);
	printf(STDOUT,"access sys call\n");
	

	
	return x;
}


int
main(int argc, char **argv)
{
	//Takes:
        //User X (UID)
        // File Y
       //  Purpose Z
        if(argc != 4){ //4 Because call style is: access x y z 
		printf(1,"Requires 3 Args: User X, File Y, Purpoze Z\n");
        
        exit();
        }
    
	uaccess(atoi(argv[1]),argv[2],atoi(argv[3]));
  exit();
}
