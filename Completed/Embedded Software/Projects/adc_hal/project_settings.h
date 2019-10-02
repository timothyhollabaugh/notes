#ifndef _PROJECT_SETTINGS_H_
#define _PROJECT_SETTINGS_H_
// include the library header
#include "library.h"
// let the system know which lower level modules are in use
// this way higher modules can selectively utilize their resources
#define USE_MODULE_TASK
#define USE_MODULE_TIMING
#define USE_MODULE_LIST
#define USE_MODULE_BUFFER
#define USE_MODULE_BUFFER_PRINTF
#define USE_MODULE_UART
//hint: the MSP430F5529 uses UART1 for the builtin MSP Application UART1 virtual COM port
#define USE_UART1
// hint: the default clock for the MSP430F5529 is 1048576
// the default clock for the PIC32MX is set by configuration bits
#define FCPU     1048576L
// if peripheral clock is slower than main clock change it here
#define PERIPHERAL_CLOCK FCPU
#endif // _SYSTEM_H_
