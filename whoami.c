//user program to test getuid syscall

#include "types.h"
#include "stat.h"
#include "user.h"

int MAX_LEN = 200; // buffer lenght for username, password, and user id lengths

// represents each user
typedef struct user {
    char username[200];
    char userId[200];
} USER;

int
main(void)
{
   // supports
   USER users[MAX_LEN];
   int numberOfUsers = 0;
   int currProcUID = 0;
   int currUser = 0;

   // Read all usernames, passwords and userIds into "users" array
   static const char filename[] = "etc-passwd";
   FILE *file = fopen(filename, "r");
   if ( file != NULL )
   {
        char word[MAX_LEN]; // word read

       // assumes that there 3 words in each line in the file (username, password, userId)
       int counter = 0;
       while(fscanf(file, "%s", word) != EOF){

            // create a user struct and added to the array of "users"
            USER user;

            // add username
            strncpy(user.username , word, MAX_LEN );

            // add the userId
            fscanf(file, "%s", word);
            strncpy(user.userId , word, MAX_LEN );

            users[counter] = user;
            counter++;
            numberOfUsers++;
        }

      fclose(file);
      
      currProcUID = getuid();
      counter = 0;
      while(counter < numberOfUsers){
        if(users[counter].userID == atoi(currProcUID)){
          currUser = counter;
        }
      }
      printf(1, "Current process User: %s\n",users[currUser].username );
      
}
