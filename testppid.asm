
_testppid:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:

int STDOUT = 1;

int
main(void)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	53                   	push   %ebx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	83 ec 10             	sub    $0x10,%esp
  printf(STDOUT, "Daniel Recker/dreck410\n\
   a:	e8 1a 03 00 00       	call   329 <getppid>
   f:	89 c3                	mov    %eax,%ebx
  11:	e8 0b 03 00 00       	call   321 <getpid>
  16:	8b 15 80 0a 00 00    	mov    0xa80,%edx
  1c:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
  20:	89 44 24 08          	mov    %eax,0x8(%esp)
  24:	c7 44 24 04 f8 07 00 	movl   $0x7f8,0x4(%esp)
  2b:	00 
  2c:	89 14 24             	mov    %edx,(%esp)
  2f:	e8 f5 03 00 00       	call   429 <printf>
\tProcess PID = %d\n\
\tParent PID  = %d\n",getpid(), getppid() );

  exit();
  34:	e8 68 02 00 00       	call   2a1 <exit>

00000039 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  39:	55                   	push   %ebp
  3a:	89 e5                	mov    %esp,%ebp
  3c:	57                   	push   %edi
  3d:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  3e:	8b 4d 08             	mov    0x8(%ebp),%ecx
  41:	8b 55 10             	mov    0x10(%ebp),%edx
  44:	8b 45 0c             	mov    0xc(%ebp),%eax
  47:	89 cb                	mov    %ecx,%ebx
  49:	89 df                	mov    %ebx,%edi
  4b:	89 d1                	mov    %edx,%ecx
  4d:	fc                   	cld    
  4e:	f3 aa                	rep stos %al,%es:(%edi)
  50:	89 ca                	mov    %ecx,%edx
  52:	89 fb                	mov    %edi,%ebx
  54:	89 5d 08             	mov    %ebx,0x8(%ebp)
  57:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  5a:	5b                   	pop    %ebx
  5b:	5f                   	pop    %edi
  5c:	5d                   	pop    %ebp
  5d:	c3                   	ret    

0000005e <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  5e:	55                   	push   %ebp
  5f:	89 e5                	mov    %esp,%ebp
  61:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  64:	8b 45 08             	mov    0x8(%ebp),%eax
  67:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  6a:	90                   	nop
  6b:	8b 45 08             	mov    0x8(%ebp),%eax
  6e:	8d 50 01             	lea    0x1(%eax),%edx
  71:	89 55 08             	mov    %edx,0x8(%ebp)
  74:	8b 55 0c             	mov    0xc(%ebp),%edx
  77:	8d 4a 01             	lea    0x1(%edx),%ecx
  7a:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  7d:	0f b6 12             	movzbl (%edx),%edx
  80:	88 10                	mov    %dl,(%eax)
  82:	0f b6 00             	movzbl (%eax),%eax
  85:	84 c0                	test   %al,%al
  87:	75 e2                	jne    6b <strcpy+0xd>
    ;
  return os;
  89:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8c:	c9                   	leave  
  8d:	c3                   	ret    

0000008e <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8e:	55                   	push   %ebp
  8f:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  91:	eb 08                	jmp    9b <strcmp+0xd>
    p++, q++;
  93:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  97:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  9b:	8b 45 08             	mov    0x8(%ebp),%eax
  9e:	0f b6 00             	movzbl (%eax),%eax
  a1:	84 c0                	test   %al,%al
  a3:	74 10                	je     b5 <strcmp+0x27>
  a5:	8b 45 08             	mov    0x8(%ebp),%eax
  a8:	0f b6 10             	movzbl (%eax),%edx
  ab:	8b 45 0c             	mov    0xc(%ebp),%eax
  ae:	0f b6 00             	movzbl (%eax),%eax
  b1:	38 c2                	cmp    %al,%dl
  b3:	74 de                	je     93 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  b5:	8b 45 08             	mov    0x8(%ebp),%eax
  b8:	0f b6 00             	movzbl (%eax),%eax
  bb:	0f b6 d0             	movzbl %al,%edx
  be:	8b 45 0c             	mov    0xc(%ebp),%eax
  c1:	0f b6 00             	movzbl (%eax),%eax
  c4:	0f b6 c0             	movzbl %al,%eax
  c7:	29 c2                	sub    %eax,%edx
  c9:	89 d0                	mov    %edx,%eax
}
  cb:	5d                   	pop    %ebp
  cc:	c3                   	ret    

000000cd <strlen>:

uint
strlen(char *s)
{
  cd:	55                   	push   %ebp
  ce:	89 e5                	mov    %esp,%ebp
  d0:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
  d3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  da:	eb 04                	jmp    e0 <strlen+0x13>
  dc:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  e0:	8b 55 fc             	mov    -0x4(%ebp),%edx
  e3:	8b 45 08             	mov    0x8(%ebp),%eax
  e6:	01 d0                	add    %edx,%eax
  e8:	0f b6 00             	movzbl (%eax),%eax
  eb:	84 c0                	test   %al,%al
  ed:	75 ed                	jne    dc <strlen+0xf>
    ;
  return n;
  ef:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  f2:	c9                   	leave  
  f3:	c3                   	ret    

000000f4 <memset>:

void*
memset(void *dst, int c, uint n)
{
  f4:	55                   	push   %ebp
  f5:	89 e5                	mov    %esp,%ebp
  f7:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
  fa:	8b 45 10             	mov    0x10(%ebp),%eax
  fd:	89 44 24 08          	mov    %eax,0x8(%esp)
 101:	8b 45 0c             	mov    0xc(%ebp),%eax
 104:	89 44 24 04          	mov    %eax,0x4(%esp)
 108:	8b 45 08             	mov    0x8(%ebp),%eax
 10b:	89 04 24             	mov    %eax,(%esp)
 10e:	e8 26 ff ff ff       	call   39 <stosb>
  return dst;
 113:	8b 45 08             	mov    0x8(%ebp),%eax
}
 116:	c9                   	leave  
 117:	c3                   	ret    

00000118 <strchr>:

char*
strchr(const char *s, char c)
{
 118:	55                   	push   %ebp
 119:	89 e5                	mov    %esp,%ebp
 11b:	83 ec 04             	sub    $0x4,%esp
 11e:	8b 45 0c             	mov    0xc(%ebp),%eax
 121:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 124:	eb 14                	jmp    13a <strchr+0x22>
    if(*s == c)
 126:	8b 45 08             	mov    0x8(%ebp),%eax
 129:	0f b6 00             	movzbl (%eax),%eax
 12c:	3a 45 fc             	cmp    -0x4(%ebp),%al
 12f:	75 05                	jne    136 <strchr+0x1e>
      return (char*)s;
 131:	8b 45 08             	mov    0x8(%ebp),%eax
 134:	eb 13                	jmp    149 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 136:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 13a:	8b 45 08             	mov    0x8(%ebp),%eax
 13d:	0f b6 00             	movzbl (%eax),%eax
 140:	84 c0                	test   %al,%al
 142:	75 e2                	jne    126 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 144:	b8 00 00 00 00       	mov    $0x0,%eax
}
 149:	c9                   	leave  
 14a:	c3                   	ret    

0000014b <gets>:

char*
gets(char *buf, int max)
{
 14b:	55                   	push   %ebp
 14c:	89 e5                	mov    %esp,%ebp
 14e:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 151:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 158:	eb 4c                	jmp    1a6 <gets+0x5b>
    cc = read(0, &c, 1);
 15a:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 161:	00 
 162:	8d 45 ef             	lea    -0x11(%ebp),%eax
 165:	89 44 24 04          	mov    %eax,0x4(%esp)
 169:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 170:	e8 44 01 00 00       	call   2b9 <read>
 175:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 178:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 17c:	7f 02                	jg     180 <gets+0x35>
      break;
 17e:	eb 31                	jmp    1b1 <gets+0x66>
    buf[i++] = c;
 180:	8b 45 f4             	mov    -0xc(%ebp),%eax
 183:	8d 50 01             	lea    0x1(%eax),%edx
 186:	89 55 f4             	mov    %edx,-0xc(%ebp)
 189:	89 c2                	mov    %eax,%edx
 18b:	8b 45 08             	mov    0x8(%ebp),%eax
 18e:	01 c2                	add    %eax,%edx
 190:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 194:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 196:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 19a:	3c 0a                	cmp    $0xa,%al
 19c:	74 13                	je     1b1 <gets+0x66>
 19e:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1a2:	3c 0d                	cmp    $0xd,%al
 1a4:	74 0b                	je     1b1 <gets+0x66>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1a9:	83 c0 01             	add    $0x1,%eax
 1ac:	3b 45 0c             	cmp    0xc(%ebp),%eax
 1af:	7c a9                	jl     15a <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1b1:	8b 55 f4             	mov    -0xc(%ebp),%edx
 1b4:	8b 45 08             	mov    0x8(%ebp),%eax
 1b7:	01 d0                	add    %edx,%eax
 1b9:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 1bc:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1bf:	c9                   	leave  
 1c0:	c3                   	ret    

000001c1 <stat>:

int
stat(char *n, struct stat *st)
{
 1c1:	55                   	push   %ebp
 1c2:	89 e5                	mov    %esp,%ebp
 1c4:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1c7:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 1ce:	00 
 1cf:	8b 45 08             	mov    0x8(%ebp),%eax
 1d2:	89 04 24             	mov    %eax,(%esp)
 1d5:	e8 07 01 00 00       	call   2e1 <open>
 1da:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 1dd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 1e1:	79 07                	jns    1ea <stat+0x29>
    return -1;
 1e3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 1e8:	eb 23                	jmp    20d <stat+0x4c>
  r = fstat(fd, st);
 1ea:	8b 45 0c             	mov    0xc(%ebp),%eax
 1ed:	89 44 24 04          	mov    %eax,0x4(%esp)
 1f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1f4:	89 04 24             	mov    %eax,(%esp)
 1f7:	e8 fd 00 00 00       	call   2f9 <fstat>
 1fc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 1ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
 202:	89 04 24             	mov    %eax,(%esp)
 205:	e8 bf 00 00 00       	call   2c9 <close>
  return r;
 20a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 20d:	c9                   	leave  
 20e:	c3                   	ret    

0000020f <atoi>:

int
atoi(const char *s)
{
 20f:	55                   	push   %ebp
 210:	89 e5                	mov    %esp,%ebp
 212:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 215:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 21c:	eb 25                	jmp    243 <atoi+0x34>
    n = n*10 + *s++ - '0';
 21e:	8b 55 fc             	mov    -0x4(%ebp),%edx
 221:	89 d0                	mov    %edx,%eax
 223:	c1 e0 02             	shl    $0x2,%eax
 226:	01 d0                	add    %edx,%eax
 228:	01 c0                	add    %eax,%eax
 22a:	89 c1                	mov    %eax,%ecx
 22c:	8b 45 08             	mov    0x8(%ebp),%eax
 22f:	8d 50 01             	lea    0x1(%eax),%edx
 232:	89 55 08             	mov    %edx,0x8(%ebp)
 235:	0f b6 00             	movzbl (%eax),%eax
 238:	0f be c0             	movsbl %al,%eax
 23b:	01 c8                	add    %ecx,%eax
 23d:	83 e8 30             	sub    $0x30,%eax
 240:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 243:	8b 45 08             	mov    0x8(%ebp),%eax
 246:	0f b6 00             	movzbl (%eax),%eax
 249:	3c 2f                	cmp    $0x2f,%al
 24b:	7e 0a                	jle    257 <atoi+0x48>
 24d:	8b 45 08             	mov    0x8(%ebp),%eax
 250:	0f b6 00             	movzbl (%eax),%eax
 253:	3c 39                	cmp    $0x39,%al
 255:	7e c7                	jle    21e <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 257:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 25a:	c9                   	leave  
 25b:	c3                   	ret    

0000025c <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 25c:	55                   	push   %ebp
 25d:	89 e5                	mov    %esp,%ebp
 25f:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 262:	8b 45 08             	mov    0x8(%ebp),%eax
 265:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 268:	8b 45 0c             	mov    0xc(%ebp),%eax
 26b:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 26e:	eb 17                	jmp    287 <memmove+0x2b>
    *dst++ = *src++;
 270:	8b 45 fc             	mov    -0x4(%ebp),%eax
 273:	8d 50 01             	lea    0x1(%eax),%edx
 276:	89 55 fc             	mov    %edx,-0x4(%ebp)
 279:	8b 55 f8             	mov    -0x8(%ebp),%edx
 27c:	8d 4a 01             	lea    0x1(%edx),%ecx
 27f:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 282:	0f b6 12             	movzbl (%edx),%edx
 285:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 287:	8b 45 10             	mov    0x10(%ebp),%eax
 28a:	8d 50 ff             	lea    -0x1(%eax),%edx
 28d:	89 55 10             	mov    %edx,0x10(%ebp)
 290:	85 c0                	test   %eax,%eax
 292:	7f dc                	jg     270 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 294:	8b 45 08             	mov    0x8(%ebp),%eax
}
 297:	c9                   	leave  
 298:	c3                   	ret    

00000299 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 299:	b8 01 00 00 00       	mov    $0x1,%eax
 29e:	cd 40                	int    $0x40
 2a0:	c3                   	ret    

000002a1 <exit>:
SYSCALL(exit)
 2a1:	b8 02 00 00 00       	mov    $0x2,%eax
 2a6:	cd 40                	int    $0x40
 2a8:	c3                   	ret    

000002a9 <wait>:
SYSCALL(wait)
 2a9:	b8 03 00 00 00       	mov    $0x3,%eax
 2ae:	cd 40                	int    $0x40
 2b0:	c3                   	ret    

000002b1 <pipe>:
SYSCALL(pipe)
 2b1:	b8 04 00 00 00       	mov    $0x4,%eax
 2b6:	cd 40                	int    $0x40
 2b8:	c3                   	ret    

000002b9 <read>:
SYSCALL(read)
 2b9:	b8 05 00 00 00       	mov    $0x5,%eax
 2be:	cd 40                	int    $0x40
 2c0:	c3                   	ret    

000002c1 <write>:
SYSCALL(write)
 2c1:	b8 10 00 00 00       	mov    $0x10,%eax
 2c6:	cd 40                	int    $0x40
 2c8:	c3                   	ret    

000002c9 <close>:
SYSCALL(close)
 2c9:	b8 15 00 00 00       	mov    $0x15,%eax
 2ce:	cd 40                	int    $0x40
 2d0:	c3                   	ret    

000002d1 <kill>:
SYSCALL(kill)
 2d1:	b8 06 00 00 00       	mov    $0x6,%eax
 2d6:	cd 40                	int    $0x40
 2d8:	c3                   	ret    

000002d9 <exec>:
SYSCALL(exec)
 2d9:	b8 07 00 00 00       	mov    $0x7,%eax
 2de:	cd 40                	int    $0x40
 2e0:	c3                   	ret    

000002e1 <open>:
SYSCALL(open)
 2e1:	b8 0f 00 00 00       	mov    $0xf,%eax
 2e6:	cd 40                	int    $0x40
 2e8:	c3                   	ret    

000002e9 <mknod>:
SYSCALL(mknod)
 2e9:	b8 11 00 00 00       	mov    $0x11,%eax
 2ee:	cd 40                	int    $0x40
 2f0:	c3                   	ret    

000002f1 <unlink>:
SYSCALL(unlink)
 2f1:	b8 12 00 00 00       	mov    $0x12,%eax
 2f6:	cd 40                	int    $0x40
 2f8:	c3                   	ret    

000002f9 <fstat>:
SYSCALL(fstat)
 2f9:	b8 08 00 00 00       	mov    $0x8,%eax
 2fe:	cd 40                	int    $0x40
 300:	c3                   	ret    

00000301 <link>:
SYSCALL(link)
 301:	b8 13 00 00 00       	mov    $0x13,%eax
 306:	cd 40                	int    $0x40
 308:	c3                   	ret    

00000309 <mkdir>:
SYSCALL(mkdir)
 309:	b8 14 00 00 00       	mov    $0x14,%eax
 30e:	cd 40                	int    $0x40
 310:	c3                   	ret    

00000311 <chdir>:
SYSCALL(chdir)
 311:	b8 09 00 00 00       	mov    $0x9,%eax
 316:	cd 40                	int    $0x40
 318:	c3                   	ret    

00000319 <dup>:
SYSCALL(dup)
 319:	b8 0a 00 00 00       	mov    $0xa,%eax
 31e:	cd 40                	int    $0x40
 320:	c3                   	ret    

00000321 <getpid>:
SYSCALL(getpid)
 321:	b8 0b 00 00 00       	mov    $0xb,%eax
 326:	cd 40                	int    $0x40
 328:	c3                   	ret    

00000329 <getppid>:
SYSCALL(getppid)
 329:	b8 16 00 00 00       	mov    $0x16,%eax
 32e:	cd 40                	int    $0x40
 330:	c3                   	ret    

00000331 <sbrk>:
SYSCALL(sbrk)
 331:	b8 0c 00 00 00       	mov    $0xc,%eax
 336:	cd 40                	int    $0x40
 338:	c3                   	ret    

00000339 <sleep>:
SYSCALL(sleep)
 339:	b8 0d 00 00 00       	mov    $0xd,%eax
 33e:	cd 40                	int    $0x40
 340:	c3                   	ret    

00000341 <uptime>:
SYSCALL(uptime)
 341:	b8 0e 00 00 00       	mov    $0xe,%eax
 346:	cd 40                	int    $0x40
 348:	c3                   	ret    

00000349 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 349:	55                   	push   %ebp
 34a:	89 e5                	mov    %esp,%ebp
 34c:	83 ec 18             	sub    $0x18,%esp
 34f:	8b 45 0c             	mov    0xc(%ebp),%eax
 352:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 355:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 35c:	00 
 35d:	8d 45 f4             	lea    -0xc(%ebp),%eax
 360:	89 44 24 04          	mov    %eax,0x4(%esp)
 364:	8b 45 08             	mov    0x8(%ebp),%eax
 367:	89 04 24             	mov    %eax,(%esp)
 36a:	e8 52 ff ff ff       	call   2c1 <write>
}
 36f:	c9                   	leave  
 370:	c3                   	ret    

00000371 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 371:	55                   	push   %ebp
 372:	89 e5                	mov    %esp,%ebp
 374:	56                   	push   %esi
 375:	53                   	push   %ebx
 376:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 379:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 380:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 384:	74 17                	je     39d <printint+0x2c>
 386:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 38a:	79 11                	jns    39d <printint+0x2c>
    neg = 1;
 38c:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 393:	8b 45 0c             	mov    0xc(%ebp),%eax
 396:	f7 d8                	neg    %eax
 398:	89 45 ec             	mov    %eax,-0x14(%ebp)
 39b:	eb 06                	jmp    3a3 <printint+0x32>
  } else {
    x = xx;
 39d:	8b 45 0c             	mov    0xc(%ebp),%eax
 3a0:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 3a3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 3aa:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 3ad:	8d 41 01             	lea    0x1(%ecx),%eax
 3b0:	89 45 f4             	mov    %eax,-0xc(%ebp)
 3b3:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3b6:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3b9:	ba 00 00 00 00       	mov    $0x0,%edx
 3be:	f7 f3                	div    %ebx
 3c0:	89 d0                	mov    %edx,%eax
 3c2:	0f b6 80 84 0a 00 00 	movzbl 0xa84(%eax),%eax
 3c9:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 3cd:	8b 75 10             	mov    0x10(%ebp),%esi
 3d0:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3d3:	ba 00 00 00 00       	mov    $0x0,%edx
 3d8:	f7 f6                	div    %esi
 3da:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3dd:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 3e1:	75 c7                	jne    3aa <printint+0x39>
  if(neg)
 3e3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 3e7:	74 10                	je     3f9 <printint+0x88>
    buf[i++] = '-';
 3e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 3ec:	8d 50 01             	lea    0x1(%eax),%edx
 3ef:	89 55 f4             	mov    %edx,-0xc(%ebp)
 3f2:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 3f7:	eb 1f                	jmp    418 <printint+0xa7>
 3f9:	eb 1d                	jmp    418 <printint+0xa7>
    putc(fd, buf[i]);
 3fb:	8d 55 dc             	lea    -0x24(%ebp),%edx
 3fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
 401:	01 d0                	add    %edx,%eax
 403:	0f b6 00             	movzbl (%eax),%eax
 406:	0f be c0             	movsbl %al,%eax
 409:	89 44 24 04          	mov    %eax,0x4(%esp)
 40d:	8b 45 08             	mov    0x8(%ebp),%eax
 410:	89 04 24             	mov    %eax,(%esp)
 413:	e8 31 ff ff ff       	call   349 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 418:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 41c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 420:	79 d9                	jns    3fb <printint+0x8a>
    putc(fd, buf[i]);
}
 422:	83 c4 30             	add    $0x30,%esp
 425:	5b                   	pop    %ebx
 426:	5e                   	pop    %esi
 427:	5d                   	pop    %ebp
 428:	c3                   	ret    

00000429 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 429:	55                   	push   %ebp
 42a:	89 e5                	mov    %esp,%ebp
 42c:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 42f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 436:	8d 45 0c             	lea    0xc(%ebp),%eax
 439:	83 c0 04             	add    $0x4,%eax
 43c:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 43f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 446:	e9 7c 01 00 00       	jmp    5c7 <printf+0x19e>
    c = fmt[i] & 0xff;
 44b:	8b 55 0c             	mov    0xc(%ebp),%edx
 44e:	8b 45 f0             	mov    -0x10(%ebp),%eax
 451:	01 d0                	add    %edx,%eax
 453:	0f b6 00             	movzbl (%eax),%eax
 456:	0f be c0             	movsbl %al,%eax
 459:	25 ff 00 00 00       	and    $0xff,%eax
 45e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 461:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 465:	75 2c                	jne    493 <printf+0x6a>
      if(c == '%'){
 467:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 46b:	75 0c                	jne    479 <printf+0x50>
        state = '%';
 46d:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 474:	e9 4a 01 00 00       	jmp    5c3 <printf+0x19a>
      } else {
        putc(fd, c);
 479:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 47c:	0f be c0             	movsbl %al,%eax
 47f:	89 44 24 04          	mov    %eax,0x4(%esp)
 483:	8b 45 08             	mov    0x8(%ebp),%eax
 486:	89 04 24             	mov    %eax,(%esp)
 489:	e8 bb fe ff ff       	call   349 <putc>
 48e:	e9 30 01 00 00       	jmp    5c3 <printf+0x19a>
      }
    } else if(state == '%'){
 493:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 497:	0f 85 26 01 00 00    	jne    5c3 <printf+0x19a>
      if(c == 'd'){
 49d:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 4a1:	75 2d                	jne    4d0 <printf+0xa7>
        printint(fd, *ap, 10, 1);
 4a3:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4a6:	8b 00                	mov    (%eax),%eax
 4a8:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 4af:	00 
 4b0:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 4b7:	00 
 4b8:	89 44 24 04          	mov    %eax,0x4(%esp)
 4bc:	8b 45 08             	mov    0x8(%ebp),%eax
 4bf:	89 04 24             	mov    %eax,(%esp)
 4c2:	e8 aa fe ff ff       	call   371 <printint>
        ap++;
 4c7:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4cb:	e9 ec 00 00 00       	jmp    5bc <printf+0x193>
      } else if(c == 'x' || c == 'p'){
 4d0:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 4d4:	74 06                	je     4dc <printf+0xb3>
 4d6:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 4da:	75 2d                	jne    509 <printf+0xe0>
        printint(fd, *ap, 16, 0);
 4dc:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4df:	8b 00                	mov    (%eax),%eax
 4e1:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 4e8:	00 
 4e9:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 4f0:	00 
 4f1:	89 44 24 04          	mov    %eax,0x4(%esp)
 4f5:	8b 45 08             	mov    0x8(%ebp),%eax
 4f8:	89 04 24             	mov    %eax,(%esp)
 4fb:	e8 71 fe ff ff       	call   371 <printint>
        ap++;
 500:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 504:	e9 b3 00 00 00       	jmp    5bc <printf+0x193>
      } else if(c == 's'){
 509:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 50d:	75 45                	jne    554 <printf+0x12b>
        s = (char*)*ap;
 50f:	8b 45 e8             	mov    -0x18(%ebp),%eax
 512:	8b 00                	mov    (%eax),%eax
 514:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 517:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 51b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 51f:	75 09                	jne    52a <printf+0x101>
          s = "(null)";
 521:	c7 45 f4 34 08 00 00 	movl   $0x834,-0xc(%ebp)
        while(*s != 0){
 528:	eb 1e                	jmp    548 <printf+0x11f>
 52a:	eb 1c                	jmp    548 <printf+0x11f>
          putc(fd, *s);
 52c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 52f:	0f b6 00             	movzbl (%eax),%eax
 532:	0f be c0             	movsbl %al,%eax
 535:	89 44 24 04          	mov    %eax,0x4(%esp)
 539:	8b 45 08             	mov    0x8(%ebp),%eax
 53c:	89 04 24             	mov    %eax,(%esp)
 53f:	e8 05 fe ff ff       	call   349 <putc>
          s++;
 544:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 548:	8b 45 f4             	mov    -0xc(%ebp),%eax
 54b:	0f b6 00             	movzbl (%eax),%eax
 54e:	84 c0                	test   %al,%al
 550:	75 da                	jne    52c <printf+0x103>
 552:	eb 68                	jmp    5bc <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 554:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 558:	75 1d                	jne    577 <printf+0x14e>
        putc(fd, *ap);
 55a:	8b 45 e8             	mov    -0x18(%ebp),%eax
 55d:	8b 00                	mov    (%eax),%eax
 55f:	0f be c0             	movsbl %al,%eax
 562:	89 44 24 04          	mov    %eax,0x4(%esp)
 566:	8b 45 08             	mov    0x8(%ebp),%eax
 569:	89 04 24             	mov    %eax,(%esp)
 56c:	e8 d8 fd ff ff       	call   349 <putc>
        ap++;
 571:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 575:	eb 45                	jmp    5bc <printf+0x193>
      } else if(c == '%'){
 577:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 57b:	75 17                	jne    594 <printf+0x16b>
        putc(fd, c);
 57d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 580:	0f be c0             	movsbl %al,%eax
 583:	89 44 24 04          	mov    %eax,0x4(%esp)
 587:	8b 45 08             	mov    0x8(%ebp),%eax
 58a:	89 04 24             	mov    %eax,(%esp)
 58d:	e8 b7 fd ff ff       	call   349 <putc>
 592:	eb 28                	jmp    5bc <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 594:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 59b:	00 
 59c:	8b 45 08             	mov    0x8(%ebp),%eax
 59f:	89 04 24             	mov    %eax,(%esp)
 5a2:	e8 a2 fd ff ff       	call   349 <putc>
        putc(fd, c);
 5a7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5aa:	0f be c0             	movsbl %al,%eax
 5ad:	89 44 24 04          	mov    %eax,0x4(%esp)
 5b1:	8b 45 08             	mov    0x8(%ebp),%eax
 5b4:	89 04 24             	mov    %eax,(%esp)
 5b7:	e8 8d fd ff ff       	call   349 <putc>
      }
      state = 0;
 5bc:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5c3:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 5c7:	8b 55 0c             	mov    0xc(%ebp),%edx
 5ca:	8b 45 f0             	mov    -0x10(%ebp),%eax
 5cd:	01 d0                	add    %edx,%eax
 5cf:	0f b6 00             	movzbl (%eax),%eax
 5d2:	84 c0                	test   %al,%al
 5d4:	0f 85 71 fe ff ff    	jne    44b <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 5da:	c9                   	leave  
 5db:	c3                   	ret    

000005dc <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5dc:	55                   	push   %ebp
 5dd:	89 e5                	mov    %esp,%ebp
 5df:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 5e2:	8b 45 08             	mov    0x8(%ebp),%eax
 5e5:	83 e8 08             	sub    $0x8,%eax
 5e8:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5eb:	a1 a0 0a 00 00       	mov    0xaa0,%eax
 5f0:	89 45 fc             	mov    %eax,-0x4(%ebp)
 5f3:	eb 24                	jmp    619 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5f5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5f8:	8b 00                	mov    (%eax),%eax
 5fa:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5fd:	77 12                	ja     611 <free+0x35>
 5ff:	8b 45 f8             	mov    -0x8(%ebp),%eax
 602:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 605:	77 24                	ja     62b <free+0x4f>
 607:	8b 45 fc             	mov    -0x4(%ebp),%eax
 60a:	8b 00                	mov    (%eax),%eax
 60c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 60f:	77 1a                	ja     62b <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 611:	8b 45 fc             	mov    -0x4(%ebp),%eax
 614:	8b 00                	mov    (%eax),%eax
 616:	89 45 fc             	mov    %eax,-0x4(%ebp)
 619:	8b 45 f8             	mov    -0x8(%ebp),%eax
 61c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 61f:	76 d4                	jbe    5f5 <free+0x19>
 621:	8b 45 fc             	mov    -0x4(%ebp),%eax
 624:	8b 00                	mov    (%eax),%eax
 626:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 629:	76 ca                	jbe    5f5 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 62b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 62e:	8b 40 04             	mov    0x4(%eax),%eax
 631:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 638:	8b 45 f8             	mov    -0x8(%ebp),%eax
 63b:	01 c2                	add    %eax,%edx
 63d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 640:	8b 00                	mov    (%eax),%eax
 642:	39 c2                	cmp    %eax,%edx
 644:	75 24                	jne    66a <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 646:	8b 45 f8             	mov    -0x8(%ebp),%eax
 649:	8b 50 04             	mov    0x4(%eax),%edx
 64c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 64f:	8b 00                	mov    (%eax),%eax
 651:	8b 40 04             	mov    0x4(%eax),%eax
 654:	01 c2                	add    %eax,%edx
 656:	8b 45 f8             	mov    -0x8(%ebp),%eax
 659:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 65c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 65f:	8b 00                	mov    (%eax),%eax
 661:	8b 10                	mov    (%eax),%edx
 663:	8b 45 f8             	mov    -0x8(%ebp),%eax
 666:	89 10                	mov    %edx,(%eax)
 668:	eb 0a                	jmp    674 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 66a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 66d:	8b 10                	mov    (%eax),%edx
 66f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 672:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 674:	8b 45 fc             	mov    -0x4(%ebp),%eax
 677:	8b 40 04             	mov    0x4(%eax),%eax
 67a:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 681:	8b 45 fc             	mov    -0x4(%ebp),%eax
 684:	01 d0                	add    %edx,%eax
 686:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 689:	75 20                	jne    6ab <free+0xcf>
    p->s.size += bp->s.size;
 68b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 68e:	8b 50 04             	mov    0x4(%eax),%edx
 691:	8b 45 f8             	mov    -0x8(%ebp),%eax
 694:	8b 40 04             	mov    0x4(%eax),%eax
 697:	01 c2                	add    %eax,%edx
 699:	8b 45 fc             	mov    -0x4(%ebp),%eax
 69c:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 69f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6a2:	8b 10                	mov    (%eax),%edx
 6a4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6a7:	89 10                	mov    %edx,(%eax)
 6a9:	eb 08                	jmp    6b3 <free+0xd7>
  } else
    p->s.ptr = bp;
 6ab:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ae:	8b 55 f8             	mov    -0x8(%ebp),%edx
 6b1:	89 10                	mov    %edx,(%eax)
  freep = p;
 6b3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6b6:	a3 a0 0a 00 00       	mov    %eax,0xaa0
}
 6bb:	c9                   	leave  
 6bc:	c3                   	ret    

000006bd <morecore>:

static Header*
morecore(uint nu)
{
 6bd:	55                   	push   %ebp
 6be:	89 e5                	mov    %esp,%ebp
 6c0:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 6c3:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 6ca:	77 07                	ja     6d3 <morecore+0x16>
    nu = 4096;
 6cc:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 6d3:	8b 45 08             	mov    0x8(%ebp),%eax
 6d6:	c1 e0 03             	shl    $0x3,%eax
 6d9:	89 04 24             	mov    %eax,(%esp)
 6dc:	e8 50 fc ff ff       	call   331 <sbrk>
 6e1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 6e4:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 6e8:	75 07                	jne    6f1 <morecore+0x34>
    return 0;
 6ea:	b8 00 00 00 00       	mov    $0x0,%eax
 6ef:	eb 22                	jmp    713 <morecore+0x56>
  hp = (Header*)p;
 6f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6f4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 6f7:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6fa:	8b 55 08             	mov    0x8(%ebp),%edx
 6fd:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 700:	8b 45 f0             	mov    -0x10(%ebp),%eax
 703:	83 c0 08             	add    $0x8,%eax
 706:	89 04 24             	mov    %eax,(%esp)
 709:	e8 ce fe ff ff       	call   5dc <free>
  return freep;
 70e:	a1 a0 0a 00 00       	mov    0xaa0,%eax
}
 713:	c9                   	leave  
 714:	c3                   	ret    

00000715 <malloc>:

void*
malloc(uint nbytes)
{
 715:	55                   	push   %ebp
 716:	89 e5                	mov    %esp,%ebp
 718:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 71b:	8b 45 08             	mov    0x8(%ebp),%eax
 71e:	83 c0 07             	add    $0x7,%eax
 721:	c1 e8 03             	shr    $0x3,%eax
 724:	83 c0 01             	add    $0x1,%eax
 727:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 72a:	a1 a0 0a 00 00       	mov    0xaa0,%eax
 72f:	89 45 f0             	mov    %eax,-0x10(%ebp)
 732:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 736:	75 23                	jne    75b <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 738:	c7 45 f0 98 0a 00 00 	movl   $0xa98,-0x10(%ebp)
 73f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 742:	a3 a0 0a 00 00       	mov    %eax,0xaa0
 747:	a1 a0 0a 00 00       	mov    0xaa0,%eax
 74c:	a3 98 0a 00 00       	mov    %eax,0xa98
    base.s.size = 0;
 751:	c7 05 9c 0a 00 00 00 	movl   $0x0,0xa9c
 758:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 75b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 75e:	8b 00                	mov    (%eax),%eax
 760:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 763:	8b 45 f4             	mov    -0xc(%ebp),%eax
 766:	8b 40 04             	mov    0x4(%eax),%eax
 769:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 76c:	72 4d                	jb     7bb <malloc+0xa6>
      if(p->s.size == nunits)
 76e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 771:	8b 40 04             	mov    0x4(%eax),%eax
 774:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 777:	75 0c                	jne    785 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 779:	8b 45 f4             	mov    -0xc(%ebp),%eax
 77c:	8b 10                	mov    (%eax),%edx
 77e:	8b 45 f0             	mov    -0x10(%ebp),%eax
 781:	89 10                	mov    %edx,(%eax)
 783:	eb 26                	jmp    7ab <malloc+0x96>
      else {
        p->s.size -= nunits;
 785:	8b 45 f4             	mov    -0xc(%ebp),%eax
 788:	8b 40 04             	mov    0x4(%eax),%eax
 78b:	2b 45 ec             	sub    -0x14(%ebp),%eax
 78e:	89 c2                	mov    %eax,%edx
 790:	8b 45 f4             	mov    -0xc(%ebp),%eax
 793:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 796:	8b 45 f4             	mov    -0xc(%ebp),%eax
 799:	8b 40 04             	mov    0x4(%eax),%eax
 79c:	c1 e0 03             	shl    $0x3,%eax
 79f:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 7a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7a5:	8b 55 ec             	mov    -0x14(%ebp),%edx
 7a8:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 7ab:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7ae:	a3 a0 0a 00 00       	mov    %eax,0xaa0
      return (void*)(p + 1);
 7b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7b6:	83 c0 08             	add    $0x8,%eax
 7b9:	eb 38                	jmp    7f3 <malloc+0xde>
    }
    if(p == freep)
 7bb:	a1 a0 0a 00 00       	mov    0xaa0,%eax
 7c0:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 7c3:	75 1b                	jne    7e0 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 7c5:	8b 45 ec             	mov    -0x14(%ebp),%eax
 7c8:	89 04 24             	mov    %eax,(%esp)
 7cb:	e8 ed fe ff ff       	call   6bd <morecore>
 7d0:	89 45 f4             	mov    %eax,-0xc(%ebp)
 7d3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 7d7:	75 07                	jne    7e0 <malloc+0xcb>
        return 0;
 7d9:	b8 00 00 00 00       	mov    $0x0,%eax
 7de:	eb 13                	jmp    7f3 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7e3:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7e9:	8b 00                	mov    (%eax),%eax
 7eb:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 7ee:	e9 70 ff ff ff       	jmp    763 <malloc+0x4e>
}
 7f3:	c9                   	leave  
 7f4:	c3                   	ret    
