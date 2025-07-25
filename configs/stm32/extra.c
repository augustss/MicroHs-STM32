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
