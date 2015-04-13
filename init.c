
// init: The initial user-level program

#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h" 
 
char *argv[] = { "login", 0 };

int
main(void)
{
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
    mknod("console", 1, 1);
    open("console", O_RDWR);
  }
  dup(0);  // stdout
  dup(0);  // stderr

  for(;;){
    printf(1, "init: starting sh\n");
    printf(1,"Greetings Masters.\n");// Mr. Recker AKA Team Get It Done.\n");

    printf(1, "init: starting login prompt\n");
    printf(1, "UID: %d\n", getuid());
      
    pid = fork();
    if(pid < 0){
      printf(1, "init: fork failed\n");
      exit();
    }
    if(pid == 0){

      // fork  & execute a login, which forks & executes a shell
      exec("login", argv);
      printf(1, "login: exec sh failed\n");
        
      exit();
        
    }
    while((wpid=wait()) >= 0 && wpid != pid)
      printf(1, "zombie!\n");
  }
}
