// // Create a zombie process that 
// // must be reparented at exit.

// #include "types.h"
// #include "stat.h"
// #include "user.h"

// char buf[512];

// int
// main(void)
// {
//   int n, fd;

//   fd = open("null", O_WRONLY)

//   while((n = read(1, buf, sizeof(buf))) > 0)
//     write(1, buf, n);
//   if(n < 0){
//     printf(1, "cat: read error\n");
//     exit();
//   }
// }
