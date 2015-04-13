// mknod.c
// Trivial user program that wraps the already-existing mknod system call
// Basically you have to be incompetent to not be able to write this program

// syscall usage
// mknod("console", 1, 1);

#include "types.h"
#include "user.h"
#include "fs.h"
#include "fcntl.h"

char buf[512];

int
main(int argc, char *argv[])
{
	int majornum, minornum;
	char * name;

	// make sure the args are there
	if (argc >= 4) {

		if(strlen(argv[1]) > 0){
			name = argv[1];
		}

		majornum = (int)argv[2];
		minornum = (int)argv[3];

		// note, this syscall will succeed as long as [name] and [majornum] are valid/unclaimed
		// nothing ever checks the minor number
		// who cares about the minor number 
		if (mknod(name,majornum,minornum) == -1) {
			printf(1,"mknod failed\n");
			exit();
		}

	} else {
		printf(1,"usage: mknod [filename] [major_number] [minor_number]\n");
		exit();
	}

	printf(1,"mknod success\n");
 	exit();

}