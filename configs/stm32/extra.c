void
main_setup(void) {
    configure_clock();
    SysTick_Config(110000);
    __enable_irq();
    enable_lpuart1();
    initialise_led(red_led);
    initialise_led(blue_led);
    initialise_led(green_led);
}

_Noreturn
void myexit(int n) {
    while(1)
      ;                         /* spin forever */
}

int
ffs(int x)
{
  if (!x)
    return 0;
  x &= -x;                      /* keep lowest bit */
  int i = __CLZ(x);             /* count leading 0s */
  return 32 - i;                /* 31 leading zeros should return 1 */
}
#define FFS ffs

static void
outstr(const char *s)
{
  while (*s)
    lpuart1_write(*s++);
}

void
outdec(uint64_t i)
{
  if (i >= 10)
    outdec(i / 10);
  lpuart1_write(i%10 + '0');
}

_Noreturn void
myerr(const char *msg, const char *a)
{
  /* keep repeating message */
  for(;;) {
    outstr("ERR: ");
    outstr(msg);
    outstr(a);
    outstr("\r\n");
  }
}

CLOCK_T CLOCK_GET(void)
{
  return (uint64_t)(ticks * 1000);
}

void
sleepusec(uint64_t usec)
{
  //outstr("sleepusec ");
  //outdec(usec);
  //outstr("\r\n");
  delay_ms((usec + 999) / 1000);
}

uintptr_t
gettimemilli(void)
{
  return ticks;
}

extern int _read(int fd, void *buf, int len);
int read(int fd, void *buf, int len) {
  return _read(fd, buf, len);
}

extern int _write(int fd, const void *buf, int len);
int write(int fd, const void *buf, int len) {
  return _write(fd, buf, len);
}

extern int _close(int fd);
int close(int fd) {
  return _close(fd);
}

extern int _open(const char *name, int flags, int mode);
int open(const char *name, int flags, int mode) {
  return _open(name, flags, mode);
}
