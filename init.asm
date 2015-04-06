
_init:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:

char *argv[] = { "sh", 0 };

int
main(void)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
   6:	83 ec 20             	sub    $0x20,%esp
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
   9:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
  10:	00 
  11:	c7 04 24 e3 08 00 00 	movl   $0x8e3,(%esp)
  18:	e8 ae 03 00 00       	call   3cb <open>
  1d:	85 c0                	test   %eax,%eax
  1f:	79 30                	jns    51 <main+0x51>
    mknod("console", 1, 1);
  21:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
  28:	00 
  29:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  30:	00 
  31:	c7 04 24 e3 08 00 00 	movl   $0x8e3,(%esp)
  38:	e8 96 03 00 00       	call   3d3 <mknod>
    open("console", O_RDWR);
  3d:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
  44:	00 
  45:	c7 04 24 e3 08 00 00 	movl   $0x8e3,(%esp)
  4c:	e8 7a 03 00 00       	call   3cb <open>
  }
  dup(0);  // stdout
  51:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  58:	e8 a6 03 00 00       	call   403 <dup>
  dup(0);  // stderr
  5d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  64:	e8 9a 03 00 00       	call   403 <dup>

  for(;;){
    printf(1, "init: starting sh\n");
  69:	c7 44 24 04 eb 08 00 	movl   $0x8eb,0x4(%esp)
  70:	00 
  71:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  78:	e8 96 04 00 00       	call   513 <printf>
    printf(1,"Greetings Master Daniel Recker, dreck410\n");
  7d:	c7 44 24 04 00 09 00 	movl   $0x900,0x4(%esp)
  84:	00 
  85:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  8c:	e8 82 04 00 00       	call   513 <printf>
    pid = fork();
  91:	e8 ed 02 00 00       	call   383 <fork>
  96:	89 44 24 1c          	mov    %eax,0x1c(%esp)
    if(pid < 0){
  9a:	83 7c 24 1c 00       	cmpl   $0x0,0x1c(%esp)
  9f:	79 19                	jns    ba <main+0xba>
      printf(1, "init: fork failed\n");
  a1:	c7 44 24 04 2a 09 00 	movl   $0x92a,0x4(%esp)
  a8:	00 
  a9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  b0:	e8 5e 04 00 00       	call   513 <printf>
      exit();
  b5:	e8 d1 02 00 00       	call   38b <exit>
    }
    if(pid == 0){
  ba:	83 7c 24 1c 00       	cmpl   $0x0,0x1c(%esp)
  bf:	75 2d                	jne    ee <main+0xee>
      exec("sh", argv);
  c1:	c7 44 24 04 a8 0b 00 	movl   $0xba8,0x4(%esp)
  c8:	00 
  c9:	c7 04 24 e0 08 00 00 	movl   $0x8e0,(%esp)
  d0:	e8 ee 02 00 00       	call   3c3 <exec>
      printf(1, "init: exec sh failed\n");
  d5:	c7 44 24 04 3d 09 00 	movl   $0x93d,0x4(%esp)
  dc:	00 
  dd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  e4:	e8 2a 04 00 00       	call   513 <printf>
      exit();
  e9:	e8 9d 02 00 00       	call   38b <exit>
    }
    while((wpid=wait()) >= 0 && wpid != pid)
  ee:	eb 14                	jmp    104 <main+0x104>
      printf(1, "zombie!\n");
  f0:	c7 44 24 04 53 09 00 	movl   $0x953,0x4(%esp)
  f7:	00 
  f8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  ff:	e8 0f 04 00 00       	call   513 <printf>
    if(pid == 0){
      exec("sh", argv);
      printf(1, "init: exec sh failed\n");
      exit();
    }
    while((wpid=wait()) >= 0 && wpid != pid)
 104:	e8 8a 02 00 00       	call   393 <wait>
 109:	89 44 24 18          	mov    %eax,0x18(%esp)
 10d:	83 7c 24 18 00       	cmpl   $0x0,0x18(%esp)
 112:	78 0a                	js     11e <main+0x11e>
 114:	8b 44 24 18          	mov    0x18(%esp),%eax
 118:	3b 44 24 1c          	cmp    0x1c(%esp),%eax
 11c:	75 d2                	jne    f0 <main+0xf0>
      printf(1, "zombie!\n");
  }
 11e:	e9 46 ff ff ff       	jmp    69 <main+0x69>

00000123 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 123:	55                   	push   %ebp
 124:	89 e5                	mov    %esp,%ebp
 126:	57                   	push   %edi
 127:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 128:	8b 4d 08             	mov    0x8(%ebp),%ecx
 12b:	8b 55 10             	mov    0x10(%ebp),%edx
 12e:	8b 45 0c             	mov    0xc(%ebp),%eax
 131:	89 cb                	mov    %ecx,%ebx
 133:	89 df                	mov    %ebx,%edi
 135:	89 d1                	mov    %edx,%ecx
 137:	fc                   	cld    
 138:	f3 aa                	rep stos %al,%es:(%edi)
 13a:	89 ca                	mov    %ecx,%edx
 13c:	89 fb                	mov    %edi,%ebx
 13e:	89 5d 08             	mov    %ebx,0x8(%ebp)
 141:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 144:	5b                   	pop    %ebx
 145:	5f                   	pop    %edi
 146:	5d                   	pop    %ebp
 147:	c3                   	ret    

00000148 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 148:	55                   	push   %ebp
 149:	89 e5                	mov    %esp,%ebp
 14b:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 14e:	8b 45 08             	mov    0x8(%ebp),%eax
 151:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 154:	90                   	nop
 155:	8b 45 08             	mov    0x8(%ebp),%eax
 158:	8d 50 01             	lea    0x1(%eax),%edx
 15b:	89 55 08             	mov    %edx,0x8(%ebp)
 15e:	8b 55 0c             	mov    0xc(%ebp),%edx
 161:	8d 4a 01             	lea    0x1(%edx),%ecx
 164:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 167:	0f b6 12             	movzbl (%edx),%edx
 16a:	88 10                	mov    %dl,(%eax)
 16c:	0f b6 00             	movzbl (%eax),%eax
 16f:	84 c0                	test   %al,%al
 171:	75 e2                	jne    155 <strcpy+0xd>
    ;
  return os;
 173:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 176:	c9                   	leave  
 177:	c3                   	ret    

00000178 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 178:	55                   	push   %ebp
 179:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 17b:	eb 08                	jmp    185 <strcmp+0xd>
    p++, q++;
 17d:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 181:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 185:	8b 45 08             	mov    0x8(%ebp),%eax
 188:	0f b6 00             	movzbl (%eax),%eax
 18b:	84 c0                	test   %al,%al
 18d:	74 10                	je     19f <strcmp+0x27>
 18f:	8b 45 08             	mov    0x8(%ebp),%eax
 192:	0f b6 10             	movzbl (%eax),%edx
 195:	8b 45 0c             	mov    0xc(%ebp),%eax
 198:	0f b6 00             	movzbl (%eax),%eax
 19b:	38 c2                	cmp    %al,%dl
 19d:	74 de                	je     17d <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 19f:	8b 45 08             	mov    0x8(%ebp),%eax
 1a2:	0f b6 00             	movzbl (%eax),%eax
 1a5:	0f b6 d0             	movzbl %al,%edx
 1a8:	8b 45 0c             	mov    0xc(%ebp),%eax
 1ab:	0f b6 00             	movzbl (%eax),%eax
 1ae:	0f b6 c0             	movzbl %al,%eax
 1b1:	29 c2                	sub    %eax,%edx
 1b3:	89 d0                	mov    %edx,%eax
}
 1b5:	5d                   	pop    %ebp
 1b6:	c3                   	ret    

000001b7 <strlen>:

uint
strlen(char *s)
{
 1b7:	55                   	push   %ebp
 1b8:	89 e5                	mov    %esp,%ebp
 1ba:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 1bd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 1c4:	eb 04                	jmp    1ca <strlen+0x13>
 1c6:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 1ca:	8b 55 fc             	mov    -0x4(%ebp),%edx
 1cd:	8b 45 08             	mov    0x8(%ebp),%eax
 1d0:	01 d0                	add    %edx,%eax
 1d2:	0f b6 00             	movzbl (%eax),%eax
 1d5:	84 c0                	test   %al,%al
 1d7:	75 ed                	jne    1c6 <strlen+0xf>
    ;
  return n;
 1d9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 1dc:	c9                   	leave  
 1dd:	c3                   	ret    

000001de <memset>:

void*
memset(void *dst, int c, uint n)
{
 1de:	55                   	push   %ebp
 1df:	89 e5                	mov    %esp,%ebp
 1e1:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 1e4:	8b 45 10             	mov    0x10(%ebp),%eax
 1e7:	89 44 24 08          	mov    %eax,0x8(%esp)
 1eb:	8b 45 0c             	mov    0xc(%ebp),%eax
 1ee:	89 44 24 04          	mov    %eax,0x4(%esp)
 1f2:	8b 45 08             	mov    0x8(%ebp),%eax
 1f5:	89 04 24             	mov    %eax,(%esp)
 1f8:	e8 26 ff ff ff       	call   123 <stosb>
  return dst;
 1fd:	8b 45 08             	mov    0x8(%ebp),%eax
}
 200:	c9                   	leave  
 201:	c3                   	ret    

00000202 <strchr>:

char*
strchr(const char *s, char c)
{
 202:	55                   	push   %ebp
 203:	89 e5                	mov    %esp,%ebp
 205:	83 ec 04             	sub    $0x4,%esp
 208:	8b 45 0c             	mov    0xc(%ebp),%eax
 20b:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 20e:	eb 14                	jmp    224 <strchr+0x22>
    if(*s == c)
 210:	8b 45 08             	mov    0x8(%ebp),%eax
 213:	0f b6 00             	movzbl (%eax),%eax
 216:	3a 45 fc             	cmp    -0x4(%ebp),%al
 219:	75 05                	jne    220 <strchr+0x1e>
      return (char*)s;
 21b:	8b 45 08             	mov    0x8(%ebp),%eax
 21e:	eb 13                	jmp    233 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 220:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 224:	8b 45 08             	mov    0x8(%ebp),%eax
 227:	0f b6 00             	movzbl (%eax),%eax
 22a:	84 c0                	test   %al,%al
 22c:	75 e2                	jne    210 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 22e:	b8 00 00 00 00       	mov    $0x0,%eax
}
 233:	c9                   	leave  
 234:	c3                   	ret    

00000235 <gets>:

char*
gets(char *buf, int max)
{
 235:	55                   	push   %ebp
 236:	89 e5                	mov    %esp,%ebp
 238:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 23b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 242:	eb 4c                	jmp    290 <gets+0x5b>
    cc = read(0, &c, 1);
 244:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 24b:	00 
 24c:	8d 45 ef             	lea    -0x11(%ebp),%eax
 24f:	89 44 24 04          	mov    %eax,0x4(%esp)
 253:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 25a:	e8 44 01 00 00       	call   3a3 <read>
 25f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 262:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 266:	7f 02                	jg     26a <gets+0x35>
      break;
 268:	eb 31                	jmp    29b <gets+0x66>
    buf[i++] = c;
 26a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 26d:	8d 50 01             	lea    0x1(%eax),%edx
 270:	89 55 f4             	mov    %edx,-0xc(%ebp)
 273:	89 c2                	mov    %eax,%edx
 275:	8b 45 08             	mov    0x8(%ebp),%eax
 278:	01 c2                	add    %eax,%edx
 27a:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 27e:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 280:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 284:	3c 0a                	cmp    $0xa,%al
 286:	74 13                	je     29b <gets+0x66>
 288:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 28c:	3c 0d                	cmp    $0xd,%al
 28e:	74 0b                	je     29b <gets+0x66>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 290:	8b 45 f4             	mov    -0xc(%ebp),%eax
 293:	83 c0 01             	add    $0x1,%eax
 296:	3b 45 0c             	cmp    0xc(%ebp),%eax
 299:	7c a9                	jl     244 <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 29b:	8b 55 f4             	mov    -0xc(%ebp),%edx
 29e:	8b 45 08             	mov    0x8(%ebp),%eax
 2a1:	01 d0                	add    %edx,%eax
 2a3:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 2a6:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2a9:	c9                   	leave  
 2aa:	c3                   	ret    

000002ab <stat>:

int
stat(char *n, struct stat *st)
{
 2ab:	55                   	push   %ebp
 2ac:	89 e5                	mov    %esp,%ebp
 2ae:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2b1:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 2b8:	00 
 2b9:	8b 45 08             	mov    0x8(%ebp),%eax
 2bc:	89 04 24             	mov    %eax,(%esp)
 2bf:	e8 07 01 00 00       	call   3cb <open>
 2c4:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 2c7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 2cb:	79 07                	jns    2d4 <stat+0x29>
    return -1;
 2cd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2d2:	eb 23                	jmp    2f7 <stat+0x4c>
  r = fstat(fd, st);
 2d4:	8b 45 0c             	mov    0xc(%ebp),%eax
 2d7:	89 44 24 04          	mov    %eax,0x4(%esp)
 2db:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2de:	89 04 24             	mov    %eax,(%esp)
 2e1:	e8 fd 00 00 00       	call   3e3 <fstat>
 2e6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 2e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2ec:	89 04 24             	mov    %eax,(%esp)
 2ef:	e8 bf 00 00 00       	call   3b3 <close>
  return r;
 2f4:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 2f7:	c9                   	leave  
 2f8:	c3                   	ret    

000002f9 <atoi>:

int
atoi(const char *s)
{
 2f9:	55                   	push   %ebp
 2fa:	89 e5                	mov    %esp,%ebp
 2fc:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 2ff:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 306:	eb 25                	jmp    32d <atoi+0x34>
    n = n*10 + *s++ - '0';
 308:	8b 55 fc             	mov    -0x4(%ebp),%edx
 30b:	89 d0                	mov    %edx,%eax
 30d:	c1 e0 02             	shl    $0x2,%eax
 310:	01 d0                	add    %edx,%eax
 312:	01 c0                	add    %eax,%eax
 314:	89 c1                	mov    %eax,%ecx
 316:	8b 45 08             	mov    0x8(%ebp),%eax
 319:	8d 50 01             	lea    0x1(%eax),%edx
 31c:	89 55 08             	mov    %edx,0x8(%ebp)
 31f:	0f b6 00             	movzbl (%eax),%eax
 322:	0f be c0             	movsbl %al,%eax
 325:	01 c8                	add    %ecx,%eax
 327:	83 e8 30             	sub    $0x30,%eax
 32a:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 32d:	8b 45 08             	mov    0x8(%ebp),%eax
 330:	0f b6 00             	movzbl (%eax),%eax
 333:	3c 2f                	cmp    $0x2f,%al
 335:	7e 0a                	jle    341 <atoi+0x48>
 337:	8b 45 08             	mov    0x8(%ebp),%eax
 33a:	0f b6 00             	movzbl (%eax),%eax
 33d:	3c 39                	cmp    $0x39,%al
 33f:	7e c7                	jle    308 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 341:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 344:	c9                   	leave  
 345:	c3                   	ret    

00000346 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 346:	55                   	push   %ebp
 347:	89 e5                	mov    %esp,%ebp
 349:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 34c:	8b 45 08             	mov    0x8(%ebp),%eax
 34f:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 352:	8b 45 0c             	mov    0xc(%ebp),%eax
 355:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 358:	eb 17                	jmp    371 <memmove+0x2b>
    *dst++ = *src++;
 35a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 35d:	8d 50 01             	lea    0x1(%eax),%edx
 360:	89 55 fc             	mov    %edx,-0x4(%ebp)
 363:	8b 55 f8             	mov    -0x8(%ebp),%edx
 366:	8d 4a 01             	lea    0x1(%edx),%ecx
 369:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 36c:	0f b6 12             	movzbl (%edx),%edx
 36f:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 371:	8b 45 10             	mov    0x10(%ebp),%eax
 374:	8d 50 ff             	lea    -0x1(%eax),%edx
 377:	89 55 10             	mov    %edx,0x10(%ebp)
 37a:	85 c0                	test   %eax,%eax
 37c:	7f dc                	jg     35a <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 37e:	8b 45 08             	mov    0x8(%ebp),%eax
}
 381:	c9                   	leave  
 382:	c3                   	ret    

00000383 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 383:	b8 01 00 00 00       	mov    $0x1,%eax
 388:	cd 40                	int    $0x40
 38a:	c3                   	ret    

0000038b <exit>:
SYSCALL(exit)
 38b:	b8 02 00 00 00       	mov    $0x2,%eax
 390:	cd 40                	int    $0x40
 392:	c3                   	ret    

00000393 <wait>:
SYSCALL(wait)
 393:	b8 03 00 00 00       	mov    $0x3,%eax
 398:	cd 40                	int    $0x40
 39a:	c3                   	ret    

0000039b <pipe>:
SYSCALL(pipe)
 39b:	b8 04 00 00 00       	mov    $0x4,%eax
 3a0:	cd 40                	int    $0x40
 3a2:	c3                   	ret    

000003a3 <read>:
SYSCALL(read)
 3a3:	b8 05 00 00 00       	mov    $0x5,%eax
 3a8:	cd 40                	int    $0x40
 3aa:	c3                   	ret    

000003ab <write>:
SYSCALL(write)
 3ab:	b8 10 00 00 00       	mov    $0x10,%eax
 3b0:	cd 40                	int    $0x40
 3b2:	c3                   	ret    

000003b3 <close>:
SYSCALL(close)
 3b3:	b8 15 00 00 00       	mov    $0x15,%eax
 3b8:	cd 40                	int    $0x40
 3ba:	c3                   	ret    

000003bb <kill>:
SYSCALL(kill)
 3bb:	b8 06 00 00 00       	mov    $0x6,%eax
 3c0:	cd 40                	int    $0x40
 3c2:	c3                   	ret    

000003c3 <exec>:
SYSCALL(exec)
 3c3:	b8 07 00 00 00       	mov    $0x7,%eax
 3c8:	cd 40                	int    $0x40
 3ca:	c3                   	ret    

000003cb <open>:
SYSCALL(open)
 3cb:	b8 0f 00 00 00       	mov    $0xf,%eax
 3d0:	cd 40                	int    $0x40
 3d2:	c3                   	ret    

000003d3 <mknod>:
SYSCALL(mknod)
 3d3:	b8 11 00 00 00       	mov    $0x11,%eax
 3d8:	cd 40                	int    $0x40
 3da:	c3                   	ret    

000003db <unlink>:
SYSCALL(unlink)
 3db:	b8 12 00 00 00       	mov    $0x12,%eax
 3e0:	cd 40                	int    $0x40
 3e2:	c3                   	ret    

000003e3 <fstat>:
SYSCALL(fstat)
 3e3:	b8 08 00 00 00       	mov    $0x8,%eax
 3e8:	cd 40                	int    $0x40
 3ea:	c3                   	ret    

000003eb <link>:
SYSCALL(link)
 3eb:	b8 13 00 00 00       	mov    $0x13,%eax
 3f0:	cd 40                	int    $0x40
 3f2:	c3                   	ret    

000003f3 <mkdir>:
SYSCALL(mkdir)
 3f3:	b8 14 00 00 00       	mov    $0x14,%eax
 3f8:	cd 40                	int    $0x40
 3fa:	c3                   	ret    

000003fb <chdir>:
SYSCALL(chdir)
 3fb:	b8 09 00 00 00       	mov    $0x9,%eax
 400:	cd 40                	int    $0x40
 402:	c3                   	ret    

00000403 <dup>:
SYSCALL(dup)
 403:	b8 0a 00 00 00       	mov    $0xa,%eax
 408:	cd 40                	int    $0x40
 40a:	c3                   	ret    

0000040b <getpid>:
SYSCALL(getpid)
 40b:	b8 0b 00 00 00       	mov    $0xb,%eax
 410:	cd 40                	int    $0x40
 412:	c3                   	ret    

00000413 <getppid>:
SYSCALL(getppid)
 413:	b8 16 00 00 00       	mov    $0x16,%eax
 418:	cd 40                	int    $0x40
 41a:	c3                   	ret    

0000041b <sbrk>:
SYSCALL(sbrk)
 41b:	b8 0c 00 00 00       	mov    $0xc,%eax
 420:	cd 40                	int    $0x40
 422:	c3                   	ret    

00000423 <sleep>:
SYSCALL(sleep)
 423:	b8 0d 00 00 00       	mov    $0xd,%eax
 428:	cd 40                	int    $0x40
 42a:	c3                   	ret    

0000042b <uptime>:
SYSCALL(uptime)
 42b:	b8 0e 00 00 00       	mov    $0xe,%eax
 430:	cd 40                	int    $0x40
 432:	c3                   	ret    

00000433 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 433:	55                   	push   %ebp
 434:	89 e5                	mov    %esp,%ebp
 436:	83 ec 18             	sub    $0x18,%esp
 439:	8b 45 0c             	mov    0xc(%ebp),%eax
 43c:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 43f:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 446:	00 
 447:	8d 45 f4             	lea    -0xc(%ebp),%eax
 44a:	89 44 24 04          	mov    %eax,0x4(%esp)
 44e:	8b 45 08             	mov    0x8(%ebp),%eax
 451:	89 04 24             	mov    %eax,(%esp)
 454:	e8 52 ff ff ff       	call   3ab <write>
}
 459:	c9                   	leave  
 45a:	c3                   	ret    

0000045b <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 45b:	55                   	push   %ebp
 45c:	89 e5                	mov    %esp,%ebp
 45e:	56                   	push   %esi
 45f:	53                   	push   %ebx
 460:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 463:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 46a:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 46e:	74 17                	je     487 <printint+0x2c>
 470:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 474:	79 11                	jns    487 <printint+0x2c>
    neg = 1;
 476:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 47d:	8b 45 0c             	mov    0xc(%ebp),%eax
 480:	f7 d8                	neg    %eax
 482:	89 45 ec             	mov    %eax,-0x14(%ebp)
 485:	eb 06                	jmp    48d <printint+0x32>
  } else {
    x = xx;
 487:	8b 45 0c             	mov    0xc(%ebp),%eax
 48a:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 48d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 494:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 497:	8d 41 01             	lea    0x1(%ecx),%eax
 49a:	89 45 f4             	mov    %eax,-0xc(%ebp)
 49d:	8b 5d 10             	mov    0x10(%ebp),%ebx
 4a0:	8b 45 ec             	mov    -0x14(%ebp),%eax
 4a3:	ba 00 00 00 00       	mov    $0x0,%edx
 4a8:	f7 f3                	div    %ebx
 4aa:	89 d0                	mov    %edx,%eax
 4ac:	0f b6 80 b0 0b 00 00 	movzbl 0xbb0(%eax),%eax
 4b3:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 4b7:	8b 75 10             	mov    0x10(%ebp),%esi
 4ba:	8b 45 ec             	mov    -0x14(%ebp),%eax
 4bd:	ba 00 00 00 00       	mov    $0x0,%edx
 4c2:	f7 f6                	div    %esi
 4c4:	89 45 ec             	mov    %eax,-0x14(%ebp)
 4c7:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4cb:	75 c7                	jne    494 <printint+0x39>
  if(neg)
 4cd:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 4d1:	74 10                	je     4e3 <printint+0x88>
    buf[i++] = '-';
 4d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4d6:	8d 50 01             	lea    0x1(%eax),%edx
 4d9:	89 55 f4             	mov    %edx,-0xc(%ebp)
 4dc:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 4e1:	eb 1f                	jmp    502 <printint+0xa7>
 4e3:	eb 1d                	jmp    502 <printint+0xa7>
    putc(fd, buf[i]);
 4e5:	8d 55 dc             	lea    -0x24(%ebp),%edx
 4e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4eb:	01 d0                	add    %edx,%eax
 4ed:	0f b6 00             	movzbl (%eax),%eax
 4f0:	0f be c0             	movsbl %al,%eax
 4f3:	89 44 24 04          	mov    %eax,0x4(%esp)
 4f7:	8b 45 08             	mov    0x8(%ebp),%eax
 4fa:	89 04 24             	mov    %eax,(%esp)
 4fd:	e8 31 ff ff ff       	call   433 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 502:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 506:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 50a:	79 d9                	jns    4e5 <printint+0x8a>
    putc(fd, buf[i]);
}
 50c:	83 c4 30             	add    $0x30,%esp
 50f:	5b                   	pop    %ebx
 510:	5e                   	pop    %esi
 511:	5d                   	pop    %ebp
 512:	c3                   	ret    

00000513 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 513:	55                   	push   %ebp
 514:	89 e5                	mov    %esp,%ebp
 516:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 519:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 520:	8d 45 0c             	lea    0xc(%ebp),%eax
 523:	83 c0 04             	add    $0x4,%eax
 526:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 529:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 530:	e9 7c 01 00 00       	jmp    6b1 <printf+0x19e>
    c = fmt[i] & 0xff;
 535:	8b 55 0c             	mov    0xc(%ebp),%edx
 538:	8b 45 f0             	mov    -0x10(%ebp),%eax
 53b:	01 d0                	add    %edx,%eax
 53d:	0f b6 00             	movzbl (%eax),%eax
 540:	0f be c0             	movsbl %al,%eax
 543:	25 ff 00 00 00       	and    $0xff,%eax
 548:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 54b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 54f:	75 2c                	jne    57d <printf+0x6a>
      if(c == '%'){
 551:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 555:	75 0c                	jne    563 <printf+0x50>
        state = '%';
 557:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 55e:	e9 4a 01 00 00       	jmp    6ad <printf+0x19a>
      } else {
        putc(fd, c);
 563:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 566:	0f be c0             	movsbl %al,%eax
 569:	89 44 24 04          	mov    %eax,0x4(%esp)
 56d:	8b 45 08             	mov    0x8(%ebp),%eax
 570:	89 04 24             	mov    %eax,(%esp)
 573:	e8 bb fe ff ff       	call   433 <putc>
 578:	e9 30 01 00 00       	jmp    6ad <printf+0x19a>
      }
    } else if(state == '%'){
 57d:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 581:	0f 85 26 01 00 00    	jne    6ad <printf+0x19a>
      if(c == 'd'){
 587:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 58b:	75 2d                	jne    5ba <printf+0xa7>
        printint(fd, *ap, 10, 1);
 58d:	8b 45 e8             	mov    -0x18(%ebp),%eax
 590:	8b 00                	mov    (%eax),%eax
 592:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 599:	00 
 59a:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 5a1:	00 
 5a2:	89 44 24 04          	mov    %eax,0x4(%esp)
 5a6:	8b 45 08             	mov    0x8(%ebp),%eax
 5a9:	89 04 24             	mov    %eax,(%esp)
 5ac:	e8 aa fe ff ff       	call   45b <printint>
        ap++;
 5b1:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5b5:	e9 ec 00 00 00       	jmp    6a6 <printf+0x193>
      } else if(c == 'x' || c == 'p'){
 5ba:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 5be:	74 06                	je     5c6 <printf+0xb3>
 5c0:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 5c4:	75 2d                	jne    5f3 <printf+0xe0>
        printint(fd, *ap, 16, 0);
 5c6:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5c9:	8b 00                	mov    (%eax),%eax
 5cb:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 5d2:	00 
 5d3:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 5da:	00 
 5db:	89 44 24 04          	mov    %eax,0x4(%esp)
 5df:	8b 45 08             	mov    0x8(%ebp),%eax
 5e2:	89 04 24             	mov    %eax,(%esp)
 5e5:	e8 71 fe ff ff       	call   45b <printint>
        ap++;
 5ea:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5ee:	e9 b3 00 00 00       	jmp    6a6 <printf+0x193>
      } else if(c == 's'){
 5f3:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 5f7:	75 45                	jne    63e <printf+0x12b>
        s = (char*)*ap;
 5f9:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5fc:	8b 00                	mov    (%eax),%eax
 5fe:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 601:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 605:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 609:	75 09                	jne    614 <printf+0x101>
          s = "(null)";
 60b:	c7 45 f4 5c 09 00 00 	movl   $0x95c,-0xc(%ebp)
        while(*s != 0){
 612:	eb 1e                	jmp    632 <printf+0x11f>
 614:	eb 1c                	jmp    632 <printf+0x11f>
          putc(fd, *s);
 616:	8b 45 f4             	mov    -0xc(%ebp),%eax
 619:	0f b6 00             	movzbl (%eax),%eax
 61c:	0f be c0             	movsbl %al,%eax
 61f:	89 44 24 04          	mov    %eax,0x4(%esp)
 623:	8b 45 08             	mov    0x8(%ebp),%eax
 626:	89 04 24             	mov    %eax,(%esp)
 629:	e8 05 fe ff ff       	call   433 <putc>
          s++;
 62e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 632:	8b 45 f4             	mov    -0xc(%ebp),%eax
 635:	0f b6 00             	movzbl (%eax),%eax
 638:	84 c0                	test   %al,%al
 63a:	75 da                	jne    616 <printf+0x103>
 63c:	eb 68                	jmp    6a6 <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 63e:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 642:	75 1d                	jne    661 <printf+0x14e>
        putc(fd, *ap);
 644:	8b 45 e8             	mov    -0x18(%ebp),%eax
 647:	8b 00                	mov    (%eax),%eax
 649:	0f be c0             	movsbl %al,%eax
 64c:	89 44 24 04          	mov    %eax,0x4(%esp)
 650:	8b 45 08             	mov    0x8(%ebp),%eax
 653:	89 04 24             	mov    %eax,(%esp)
 656:	e8 d8 fd ff ff       	call   433 <putc>
        ap++;
 65b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 65f:	eb 45                	jmp    6a6 <printf+0x193>
      } else if(c == '%'){
 661:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 665:	75 17                	jne    67e <printf+0x16b>
        putc(fd, c);
 667:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 66a:	0f be c0             	movsbl %al,%eax
 66d:	89 44 24 04          	mov    %eax,0x4(%esp)
 671:	8b 45 08             	mov    0x8(%ebp),%eax
 674:	89 04 24             	mov    %eax,(%esp)
 677:	e8 b7 fd ff ff       	call   433 <putc>
 67c:	eb 28                	jmp    6a6 <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 67e:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 685:	00 
 686:	8b 45 08             	mov    0x8(%ebp),%eax
 689:	89 04 24             	mov    %eax,(%esp)
 68c:	e8 a2 fd ff ff       	call   433 <putc>
        putc(fd, c);
 691:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 694:	0f be c0             	movsbl %al,%eax
 697:	89 44 24 04          	mov    %eax,0x4(%esp)
 69b:	8b 45 08             	mov    0x8(%ebp),%eax
 69e:	89 04 24             	mov    %eax,(%esp)
 6a1:	e8 8d fd ff ff       	call   433 <putc>
      }
      state = 0;
 6a6:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6ad:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 6b1:	8b 55 0c             	mov    0xc(%ebp),%edx
 6b4:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6b7:	01 d0                	add    %edx,%eax
 6b9:	0f b6 00             	movzbl (%eax),%eax
 6bc:	84 c0                	test   %al,%al
 6be:	0f 85 71 fe ff ff    	jne    535 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 6c4:	c9                   	leave  
 6c5:	c3                   	ret    

000006c6 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6c6:	55                   	push   %ebp
 6c7:	89 e5                	mov    %esp,%ebp
 6c9:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 6cc:	8b 45 08             	mov    0x8(%ebp),%eax
 6cf:	83 e8 08             	sub    $0x8,%eax
 6d2:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6d5:	a1 cc 0b 00 00       	mov    0xbcc,%eax
 6da:	89 45 fc             	mov    %eax,-0x4(%ebp)
 6dd:	eb 24                	jmp    703 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6df:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6e2:	8b 00                	mov    (%eax),%eax
 6e4:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6e7:	77 12                	ja     6fb <free+0x35>
 6e9:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6ec:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6ef:	77 24                	ja     715 <free+0x4f>
 6f1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6f4:	8b 00                	mov    (%eax),%eax
 6f6:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6f9:	77 1a                	ja     715 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6fb:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6fe:	8b 00                	mov    (%eax),%eax
 700:	89 45 fc             	mov    %eax,-0x4(%ebp)
 703:	8b 45 f8             	mov    -0x8(%ebp),%eax
 706:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 709:	76 d4                	jbe    6df <free+0x19>
 70b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 70e:	8b 00                	mov    (%eax),%eax
 710:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 713:	76 ca                	jbe    6df <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 715:	8b 45 f8             	mov    -0x8(%ebp),%eax
 718:	8b 40 04             	mov    0x4(%eax),%eax
 71b:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 722:	8b 45 f8             	mov    -0x8(%ebp),%eax
 725:	01 c2                	add    %eax,%edx
 727:	8b 45 fc             	mov    -0x4(%ebp),%eax
 72a:	8b 00                	mov    (%eax),%eax
 72c:	39 c2                	cmp    %eax,%edx
 72e:	75 24                	jne    754 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 730:	8b 45 f8             	mov    -0x8(%ebp),%eax
 733:	8b 50 04             	mov    0x4(%eax),%edx
 736:	8b 45 fc             	mov    -0x4(%ebp),%eax
 739:	8b 00                	mov    (%eax),%eax
 73b:	8b 40 04             	mov    0x4(%eax),%eax
 73e:	01 c2                	add    %eax,%edx
 740:	8b 45 f8             	mov    -0x8(%ebp),%eax
 743:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 746:	8b 45 fc             	mov    -0x4(%ebp),%eax
 749:	8b 00                	mov    (%eax),%eax
 74b:	8b 10                	mov    (%eax),%edx
 74d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 750:	89 10                	mov    %edx,(%eax)
 752:	eb 0a                	jmp    75e <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 754:	8b 45 fc             	mov    -0x4(%ebp),%eax
 757:	8b 10                	mov    (%eax),%edx
 759:	8b 45 f8             	mov    -0x8(%ebp),%eax
 75c:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 75e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 761:	8b 40 04             	mov    0x4(%eax),%eax
 764:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 76b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 76e:	01 d0                	add    %edx,%eax
 770:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 773:	75 20                	jne    795 <free+0xcf>
    p->s.size += bp->s.size;
 775:	8b 45 fc             	mov    -0x4(%ebp),%eax
 778:	8b 50 04             	mov    0x4(%eax),%edx
 77b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 77e:	8b 40 04             	mov    0x4(%eax),%eax
 781:	01 c2                	add    %eax,%edx
 783:	8b 45 fc             	mov    -0x4(%ebp),%eax
 786:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 789:	8b 45 f8             	mov    -0x8(%ebp),%eax
 78c:	8b 10                	mov    (%eax),%edx
 78e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 791:	89 10                	mov    %edx,(%eax)
 793:	eb 08                	jmp    79d <free+0xd7>
  } else
    p->s.ptr = bp;
 795:	8b 45 fc             	mov    -0x4(%ebp),%eax
 798:	8b 55 f8             	mov    -0x8(%ebp),%edx
 79b:	89 10                	mov    %edx,(%eax)
  freep = p;
 79d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7a0:	a3 cc 0b 00 00       	mov    %eax,0xbcc
}
 7a5:	c9                   	leave  
 7a6:	c3                   	ret    

000007a7 <morecore>:

static Header*
morecore(uint nu)
{
 7a7:	55                   	push   %ebp
 7a8:	89 e5                	mov    %esp,%ebp
 7aa:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 7ad:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 7b4:	77 07                	ja     7bd <morecore+0x16>
    nu = 4096;
 7b6:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 7bd:	8b 45 08             	mov    0x8(%ebp),%eax
 7c0:	c1 e0 03             	shl    $0x3,%eax
 7c3:	89 04 24             	mov    %eax,(%esp)
 7c6:	e8 50 fc ff ff       	call   41b <sbrk>
 7cb:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 7ce:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 7d2:	75 07                	jne    7db <morecore+0x34>
    return 0;
 7d4:	b8 00 00 00 00       	mov    $0x0,%eax
 7d9:	eb 22                	jmp    7fd <morecore+0x56>
  hp = (Header*)p;
 7db:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7de:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 7e1:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7e4:	8b 55 08             	mov    0x8(%ebp),%edx
 7e7:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 7ea:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7ed:	83 c0 08             	add    $0x8,%eax
 7f0:	89 04 24             	mov    %eax,(%esp)
 7f3:	e8 ce fe ff ff       	call   6c6 <free>
  return freep;
 7f8:	a1 cc 0b 00 00       	mov    0xbcc,%eax
}
 7fd:	c9                   	leave  
 7fe:	c3                   	ret    

000007ff <malloc>:

void*
malloc(uint nbytes)
{
 7ff:	55                   	push   %ebp
 800:	89 e5                	mov    %esp,%ebp
 802:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 805:	8b 45 08             	mov    0x8(%ebp),%eax
 808:	83 c0 07             	add    $0x7,%eax
 80b:	c1 e8 03             	shr    $0x3,%eax
 80e:	83 c0 01             	add    $0x1,%eax
 811:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 814:	a1 cc 0b 00 00       	mov    0xbcc,%eax
 819:	89 45 f0             	mov    %eax,-0x10(%ebp)
 81c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 820:	75 23                	jne    845 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 822:	c7 45 f0 c4 0b 00 00 	movl   $0xbc4,-0x10(%ebp)
 829:	8b 45 f0             	mov    -0x10(%ebp),%eax
 82c:	a3 cc 0b 00 00       	mov    %eax,0xbcc
 831:	a1 cc 0b 00 00       	mov    0xbcc,%eax
 836:	a3 c4 0b 00 00       	mov    %eax,0xbc4
    base.s.size = 0;
 83b:	c7 05 c8 0b 00 00 00 	movl   $0x0,0xbc8
 842:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 845:	8b 45 f0             	mov    -0x10(%ebp),%eax
 848:	8b 00                	mov    (%eax),%eax
 84a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 84d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 850:	8b 40 04             	mov    0x4(%eax),%eax
 853:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 856:	72 4d                	jb     8a5 <malloc+0xa6>
      if(p->s.size == nunits)
 858:	8b 45 f4             	mov    -0xc(%ebp),%eax
 85b:	8b 40 04             	mov    0x4(%eax),%eax
 85e:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 861:	75 0c                	jne    86f <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 863:	8b 45 f4             	mov    -0xc(%ebp),%eax
 866:	8b 10                	mov    (%eax),%edx
 868:	8b 45 f0             	mov    -0x10(%ebp),%eax
 86b:	89 10                	mov    %edx,(%eax)
 86d:	eb 26                	jmp    895 <malloc+0x96>
      else {
        p->s.size -= nunits;
 86f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 872:	8b 40 04             	mov    0x4(%eax),%eax
 875:	2b 45 ec             	sub    -0x14(%ebp),%eax
 878:	89 c2                	mov    %eax,%edx
 87a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 87d:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 880:	8b 45 f4             	mov    -0xc(%ebp),%eax
 883:	8b 40 04             	mov    0x4(%eax),%eax
 886:	c1 e0 03             	shl    $0x3,%eax
 889:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 88c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 88f:	8b 55 ec             	mov    -0x14(%ebp),%edx
 892:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 895:	8b 45 f0             	mov    -0x10(%ebp),%eax
 898:	a3 cc 0b 00 00       	mov    %eax,0xbcc
      return (void*)(p + 1);
 89d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8a0:	83 c0 08             	add    $0x8,%eax
 8a3:	eb 38                	jmp    8dd <malloc+0xde>
    }
    if(p == freep)
 8a5:	a1 cc 0b 00 00       	mov    0xbcc,%eax
 8aa:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 8ad:	75 1b                	jne    8ca <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 8af:	8b 45 ec             	mov    -0x14(%ebp),%eax
 8b2:	89 04 24             	mov    %eax,(%esp)
 8b5:	e8 ed fe ff ff       	call   7a7 <morecore>
 8ba:	89 45 f4             	mov    %eax,-0xc(%ebp)
 8bd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 8c1:	75 07                	jne    8ca <malloc+0xcb>
        return 0;
 8c3:	b8 00 00 00 00       	mov    $0x0,%eax
 8c8:	eb 13                	jmp    8dd <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8cd:	89 45 f0             	mov    %eax,-0x10(%ebp)
 8d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8d3:	8b 00                	mov    (%eax),%eax
 8d5:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 8d8:	e9 70 ff ff ff       	jmp    84d <malloc+0x4e>
}
 8dd:	c9                   	leave  
 8de:	c3                   	ret    
