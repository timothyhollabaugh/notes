#include "library.h" // for useful macros and int defs
#include "project_settings.h"
#include "timing.h"
#include "task.h"
#include "uart.h"
#include "adc.h"
#include "hal_general.h" // for definition of EnableInterrupts
// define which uart channel to use
#define UART_CHANNEL 1

#define NUM_SAMPLES 512

typedef enum {
    TRIGGER_RISING,
    TRIGGER_FALLING,
} trigger_direction_t;

uint16_t samples[NUM_SAMPLES] = {0};
uint16_t sample_index = 0;

uint16_t trigger = 2048;
trigger_direction_t trigger_direction = TRIGGER_FALLING;

void recod_sample(uint16_t value, void * state) {

    uint16_t next_sample_index =
            sample_index < NUM_SAMPLES-1? sample_index + 1 : 0;

    samples[next_sample_index] = value;

    if (trigger_direction == TRIGGER_RISING) {
        if (value > samples[sample_index] && value >= trigger) {
            send_samples();
        }
    } else if (trigger_direction == TRIGGER_FALLING) {
        if (value < samples[sample_index] && value <= trigger) {
            send_samples();
        }
    }
}

void send_samples() {
    for (
            uint16_t sample_offset = 0;
            sample_offest < NUM_SAMPLES;
            sample_offset++
    ) {
        uint16_t offset_sample_index = sample_index + sample_offset;

        if (offset_sampe_index >= NUM_SAMPLES {
            offset_sample_index -= NUM_SAMPLES;
        }

        UART_printf(
                UART_CHANNEL,
                "%d\t%d",
                sample_offset,
                samples[offset_sample_index]
        );
    }
}

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
    ADC_AddChannel(0, 1, record_sample, 0);
    while(1) SystemTick();
}
