#include "library.h" // for useful macros and int defs
#include "project_settings.h"
#include "timing.h"
#include "task.h"
#include "uart.h"
#include "adc.h"
#include "hal_general.h" // for definition of EnableInterrupts
// define which uart channel to use
#define UART_CHANNEL 1

typedef struct {
    uint16_t count;
} counter_t;

void hello_world(void * counter_void) {
    counter_t * counter = (counter_t *) counter_void;
    UART_printf(UART_CHANNEL, "Hello, World! %d\r\n", counter->count);
    counter->count++;
}

void report_adc(uint16_t value, void * state) {
    UART_printf(UART_CHANNEL, "ADC: %d\n", value);
}

int32_t main(void)
{
    // do any device specific configuration here
    //SYSTEMConfig(FCPU, SYS_CFG_ALL); // config clock for PIC32
    WDTCTL = WDTPW | WDTHOLD;    // Stop watchdog timer for MSP430
    Timing_Init(); // initialize the timing module first
    Task_Init(); // initialize task management module next
    UART_Init(UART_CHANNEL);
    UART_printf(UART_CHANNEL, "Inited\n");

    ADC_Init();

    counter_t counter = {0};

    // enable interrupts after modules using interrupts have been initialized
    EnableInterrupts();
    Task_Schedule(hello_world, &counter, 1000, 1000);
    ADC_AddChannel(0, 100, report_adc, 0);
    while(1) SystemTick();
}
