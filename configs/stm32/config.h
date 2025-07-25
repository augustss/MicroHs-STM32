#ifndef CONFIG_H
#define CONFIG_H

#define WANT_STDIO 0
#define WANT_FLOAT32 1
#define WANT_FLOAT64 0
#define WANT_MATH 0
#define WANT_INT64 0
#define WANT_MD5 0
#define WANT_TICK 0
#define WANT_DIR 0
#define WANT_TIME 0
#define WANT_SIGINT 0
#define WANT_ARGS 0
#define WANT_TAGNAMES 0

#define GCRED    0
#define INTTABLE 1
#define SANITY   1
#define STACKOVL 1

#define PACKED

#define HEAP_CELLS 10000
#define STACK_SIZE 100

#include "stm32l5xx.h"
#include "clock.h"
#include "uart.h"
#include "gpio.h"

#define INITIALIZATION

#define EXIT myexit

#define ERR(s) myerr(s,"")
#define ERR1(s, a) myerr(s,a)

#endif /* CONFIG_H */
