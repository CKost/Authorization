// login.c: The second user-level program
//           login forks and execs the shell
//           init and login programs  have user IDs = 0
// note: For now there are only 3 defaul users. If you want to add more users, you will have to add the user to
//          the 'etc-passwd' file and change loginc.c global NUM_OF_USERS to the # of users in the 'etc-passwd' file

#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h" // O_RDONLY

char *argv[] = { "sh", 0 };
int MAX_LEN = 200; // buffer lenght for username, password, and user id lengths
int NUM_OF_USERS = 4;
int STDIN    = 0;
int STDOUT = 1;
int STDERR = 2;


// removes all newlines (\n) from buffer
void removeNewlinesFromBuffer(char buf[], int size ) {

    char *src, *dst;
    
    for (src = dst = buf; *src != '\0'; src++) {
        *dst = *src;
        if (*dst != '\n') dst++;
    }
    *dst = '\0';
}

//  asumes a buffer initialized all slots to null values
//  reads a word from a file, appends \n to the word, and puts it into <buf>
//  retuns a pointer to <buf>
//  if EOF, return NULL ( aka '\0') in <buf[0]>
char*
readWord(int fd, char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(fd, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r'  || c == ' ')
      break;
  }
  
  buf[i] = '\0';
  
  // if only one character long word, append \n
  if(i == 1)
      buf[i] = '\n';
  
  // if more than one character long word, append \n
  if(i > 1)
      buf[i-1] = '\n';
  
  return buf;
}

// return 1 if user is found
// return 0 if user is not found
int userAndPassFound(char username[], char password[], char etcUser[], char etcPass[] ){
    
    if (strcmp(username, etcUser) == 0 && strcmp(password, etcPass) == 0)
        return 1;
    
    return 0;
    
}

void zeroOutBuffer(char buf[], int size ){
    memset(buf, '\0', size);
}

// receives a filename to count the newlines from
// counts the number for newlines and returns that number
int getNumberOfNewlines(char filename[]) {

    int i = 0;
    int fd;
    int retFromRead;
    int counter = 0;
    char *ch;
    char buf[MAX_LEN];
    int bufSize = sizeof(buf);
    zeroOutBuffer(buf, bufSize);
    
    // open file
    if((fd = open(filename,  O_RDONLY)) < 0){
      printf(1, "login.c:getNumberOfNewlines: Error cannot open file '%s'\n", filename);
      exit();
    }
    
    retFromRead = read(fd, buf, sizeof(buf));
    if(retFromRead < 1){
        printf(1, "login.c:getNumberOfNewlines: Error cannot open file '%s'\n", filename);
    }
    
    // close file
    close(fd);
    
    for (ch = buf; i < bufSize; ch++, i++) {
        if (*ch == '\n') 
            counter++;
    }

    return counter;
}

// receives a username and and passwrod to validate against the passwords file
// returns the user id who logged if username and password are valid
// returns -1 if invalid credentials or any other errors
int successfulLogin(char username[], char password[]){
        
   char    etcUser[MAX_LEN] ;
   char    etcPass[MAX_LEN] ;
   char etcUserId[MAX_LEN] ;
   int userFound = 0;
   char filename[] = "etc-passwd";
   int fd, i;
   
    if((fd = open(filename,  O_RDONLY)) < 0){
      printf(1, "login.c:successfulLogin: Error cannot open file '%s'\n", filename);
      exit();
    }
    
    // compare the username and password given against each user and password in the file
    for(i  = 0; i < NUM_OF_USERS ; i++){
        
        // zero out buffers
        zeroOutBuffer(etcUser, sizeof(etcUser));
        zeroOutBuffer(etcPass, sizeof(etcPass));
        zeroOutBuffer(etcUserId, sizeof(etcUserId));
        
        // read one user info from file
       readWord(fd, etcUser, sizeof(etcUser));
       readWord(fd, etcPass, sizeof(etcPass));
       readWord(fd, etcUserId, sizeof(etcUserId));

        userFound = userAndPassFound(username, password, etcUser, etcPass);
        if(userFound){
            close(fd);
            removeNewlinesFromBuffer(etcUserId, sizeof(etcUserId));
            int n = atoi(etcUserId);
            return n;
        }

    }
    close(fd);
    
    // error loging in or invalid credentials
    return -1;
}

// ask for credentials and saves then in buffers <username> and <password>
void promptForUsernamePassword(char username[], char password[], int bufSize){
        
        printf(STDOUT, "Enter your username: ");
        gets(username, bufSize);
    
        printf(STDOUT, "Enter your password: ");
        gets(password, bufSize);

}

int
main(void)
{
    
   int pid;
   char username[MAX_LEN];
   char password[MAX_LEN];
   int loggedInUserId = -1; // -1 = no one logged in yet
   int secondAndOnIteration = 0;
   
    // ask  for and validate credentials
    do {
        
        
        if(secondAndOnIteration)
            printf(1, "Invalid credentials. Try again.\n");
        
        secondAndOnIteration = 1;

        // zero out buffers
        zeroOutBuffer(username, sizeof(username));
        zeroOutBuffer(password, sizeof(password));
        
        promptForUsernamePassword(username, password, sizeof(username));
        
    } while (  (loggedInUserId = successfulLogin(username, password)) == -1); // keep prompting while invalid credentials

    
    pid = fork();
    if(pid < 0){
      printf(1, "login: fork failed\n");
      exit();
    }
    
    // in child fork and exec shell
    // in parent wait until child finishes
    if(pid == 0){

     // make a separate buffer to print username to avoid corrupting the old buffer
    char usernameCopy[MAX_LEN];
    zeroOutBuffer(usernameCopy, sizeof(usernameCopy));
    strcpy(usernameCopy, username);
    
    // set user id to the logged in user so all processes start that user id
    setuid(loggedInUserId);

    // greet user
    removeNewlinesFromBuffer(usernameCopy, sizeof(usernameCopy));
    printf(STDOUT, "Welcome %s (UID: %d)!\n", usernameCopy, getuid());
    
        
      exec("sh", argv);
      printf(1, "login: exec sh failed\n");
        
      exit();
        
    }
    
    // parent waits for child exit
    // maybe add a loop here so user can log off
    // and generate a new shell for the new user in the future
    wait(); 


    exit();
        
}