// Simple dd. Supports if, of, and sz.
// sz is bytes       (default: MAXUINT)
// of is output file (default: STDOUT)
// if is input file  (default: STDIN)

#include "types.h"
#include "user.h"
#include "fs.h"
#include "fcntl.h"

char buf[512];

int
main(int argc, char *argv[])
{
  char * inf, *outf;
  int inFile, outFile, i;
  uint sz ,tot;

  // defaults
  inFile = 0;     // stdin
  outFile = 1;    // stdout
  sz = -1;        // infinite bytes
  inf = "STDIN";  // input descriptor
  outf = "STDOUT";// output descriptor
  
  // Iterate over arguments
  for(i = 1; i < argc; ++i){
    if(strlen(argv[i]) > 3){
      // Set inFile
      if(argv[i][0] == 'i' && argv[i][1] == 'f' && argv[i][2] == '='){
        if((inFile = open(argv[i] + 3, O_RDONLY)) == -1){
          printf(1, "inFile is an invalid file!\n");
          exit();
        }else{
          printf(1, "infile: %s\n", argv[i] + 3);
          inf = argv[i] + 3;
        }
      }
      // Set outFile
      else if(argv[i][0] == 'o' && argv[i][1] == 'f' && argv[i][2] == '='){
        if((outFile = open(argv[i] + 3, O_WRONLY | O_CREATE)) == -1){
          printf(1, "outFile is an invalid file!\n");
          exit();
        }else{
          printf(1, "outfile: %s\n", argv[i] + 3);
          outf = argv[i] + 3;
        }
      }
      // Set size
      else if(argv[i][0] == 's' && argv[i][1] == 'z' && argv[i][2] == '='){
        sz = atoi(argv[i] + 3);
        if(sz == 0){
          printf(1, "Invalid size!\n");
        }else{
          printf(1, "size: %d\n", sz);
        }
      }
    }
  }

  // Read/Write
  tot = 0; // total bytes written
  i = sizeof(buf);
  while(i == sizeof(buf) && tot < sz){
    i = read(inFile, buf, sizeof(buf) + tot < sz ? sizeof(buf) : sz - tot);
    write(outFile, buf, i);
    tot += i;
  }

  // Close out of any open files and exit
  if(inFile != 0)  close(inFile);
  if(outFile != 1) close(outFile);

  // ooooo! fancy message output... shiny!
  printf(1, "%d bytes written to <%s> from <%s>\n", tot, outf, inf);
  exit();
}

