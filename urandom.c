// urandom.c

// linear congruential random number generator in python
/*a = 3
c = 9
m = 16
xi = 0

def seed(x):
    global xi
    xi = x

def rng():
    global xi
    xi = (a*xi + c)%m
    return xi % 256

for i in range(10):
    print rng()
*/

#include "types.h"
#include "defs.h"
#include "param.h"
#include "traps.h"
#include "spinlock.h"
#include "fs.h"
#include "file.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
#include "x86.h"

////////////////////////////////////////////////////////////////
  static void zconsputc(int);

static int panicked = 0;

static struct {
  struct spinlock lock;
  int locking;
} cons;

static void
zprintint(int xx, int base, int sign)
{
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
    x = -xx;
  else
    x = xx;

  i = 0;
  do{
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);

  if(sign)
    buf[i++] = '-';

  while(--i >= 0)
    zconsputc(buf[i]);
}
//PAGEBREAK: 50

// Print to the console. only understands %d, %x, %p, %s.
void
zcprintf(char *fmt, ...)
{
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
  if(locking)
    acquire(&cons.lock);

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    if(c != '%'){
      zconsputc(c);
      continue;
    }
    c = fmt[++i] & 0xff;
    if(c == 0)
      break;
    switch(c){
    case 'd':
      zprintint(*argp++, 10, 1);
      break;
    case 'x':
    case 'p':
      zprintint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
        s = "(null)";
      for(; *s; s++)
        zconsputc(*s);
      break;
    case '%':
      zconsputc('%');
      break;
    default:
      // Print unknown % sequence to draw attention.
      zconsputc('%');
      zconsputc(c);
      break;
    }
  }

  if(locking)
    release(&cons.lock);
}

void
zpanic(char *s)
{
  int i;
  uint pcs[10];
  
  cli();
  cons.locking = 0;
  zcprintf("cpu%d: panic: ", cpu->id);
  zcprintf(s);
  zcprintf("\n");
  getcallerpcs(&s, pcs);
  for(i=0; i<10; i++)
    zcprintf(" %p", pcs[i]);
  panicked = 1; // freeze other CPU
  for(;;)
    ;
}

//PAGEBREAK: 50
#define BACKSPACE 0x100
#define CRTPORT 0x3d4
static ushort *crt = (ushort*)P2V(0xb8000);  // CGA memory

static void
cgaputc(int c)
{
  int pos;
  
  // Cursor position: col + 80*row.
  outb(CRTPORT, 14);
  pos = inb(CRTPORT+1) << 8;
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);

  if(c == '\n')
    pos += 80 - pos%80;
  else if(c == BACKSPACE){
    if(pos > 0) --pos;
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
  
  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
    pos -= 80;
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
  }
  
  outb(CRTPORT, 14);
  outb(CRTPORT+1, pos>>8);
  outb(CRTPORT, 15);
  outb(CRTPORT+1, pos);
  crt[pos] = ' ' | 0x0700;
}

void
zconsputc(int c)
{
  if(panicked){
    cli();
    for(;;)
      ;
  }

  if(c == BACKSPACE){
    uartputc('\b'); uartputc(' '); uartputc('\b');
  } else
    uartputc(c);
  cgaputc(c);
}

#define INPUT_BUF 128
struct {
  struct spinlock lock;
  char buf[INPUT_BUF];
  uint r;  // Read index
  uint w;  // Write index
  uint e;  // Edit index
} input;
////////////////////////////////////////////////////////////////

uint a = 114071485;
uint c = 128201163;
uint m = 16777216;
uint xi;
struct spinlock lock;

uint rng(void) {
  uint tempxi;

  acquire(&lock);

  tempxi = xi = (a*xi + c)%m;

  release(&lock);
  return tempxi;
}

int
urandomread(struct inode *ip, char *dst, int n)
{  
  int i = 0;
  uint localxi;
  for (; i < n; ++i)
  {
    localxi = rng();
    //zcprintf("Original: %d Mod: %d", localxi, localxi % 256);
    dst[i] =  localxi % 256;   
  }

  return i;
}

int
urandomwrite(struct inode *ip, char *buf, int n)
{
    return 0;
}

void
urandominit(void)
{
  // seed here?
  xi = 3;
  initlock(&lock, "urandom");
  devsw[DEV_URANDOM].write = urandomwrite;
  devsw[DEV_URANDOM].read = urandomread;
}
