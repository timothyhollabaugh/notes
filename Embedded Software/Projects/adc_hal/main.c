#include "library.h" // for useful macros and int defs
#include "project_settings.h"
#include "timing.h"
#include "task.h"
#include "uart.h"
#include "adc.h"
#include "hal_general.h" // for definition of EnableInterrupts
// define which uart channel to use
#define UART_CHANNEL 1

#define NUM_SAMPLES 256

typedef enum {
    TRIGGER_RISING,
    TRIGGER_FALLING,
} trigger_direction_t;

uint16_t samples[NUM_SAMPLES] = {0};
uint16_t sample_index = 0;

uint16_t trigger = 2048;
trigger_direction_t trigger_direction = TRIGGER_FALLING;

typedef enum {
    PRE_SAMPLE,
    SAMPLE,
    POST_SAMPLE,
    SEND
} state_t;

state_t state = PRE_SAMPLE;
uint16_t sample_index_send_offset = 0;
uint16_t pre_post_index;

void send_sample() {
/*
    UART_printf(UART_CHANNEL, "s\n", state, pre_post_index);
    if (state == SEND) {
        UART_printf(UART_CHANNEL, "sending\n");
        state = PRE_SAMPLE;
    }*/

    if (state == SEND) {
        P1OUT &= ~BIT0;

        uint16_t offset_sample_index = sample_index + sample_index_send_offset;

        if (offset_sample_index >= NUM_SAMPLES) {
            offset_sample_index -= NUM_SAMPLES;
        }

        UART_printf(
                UART_CHANNEL,
                "%d\t%d\n",
                sample_index_send_offset,
                samples[offset_sample_index]
        );

        sample_index_send_offset += 1;

        if (sample_index_send_offset >= NUM_SAMPLES) {
            sample_index_send_offset = 0;
            state = PRE_SAMPLE;
        }
    }
}

void record_sample(uint16_t value, void * local_state) {

    //UART_printf(UART_CHANNEL, "s: %d p: %d\n", state, pre_post_index);

    if ((state == PRE_SAMPLE || state == SAMPLE || state == POST_SAMPLE) && (UART_IsTransmitting(UART_CHANNEL) == 0)) {
        P1OUT |= BIT0;

        uint16_t next_sample_index =
                sample_index < NUM_SAMPLES-1 ? sample_index + 1 : 0;

        samples[next_sample_index] = value;

        if (state == SAMPLE) {
            if (trigger_direction == TRIGGER_RISING) {
                if (value > samples[sample_index] && value >= trigger) {
                    state = POST_SAMPLE;
                }
            } else if (trigger_direction == TRIGGER_FALLING) {
                if (value < samples[sample_index] && value <= trigger) {
                    state = POST_SAMPLE;
                }
            }
        } else if (state == PRE_SAMPLE) {
            if (pre_post_index < NUM_SAMPLES/2) {
                pre_post_index += 1;
            } else {
                state = SAMPLE;
            }
        } else if (state == POST_SAMPLE) {
            if (pre_post_index > 0) {
                pre_post_index -= 1;
            } else {
                state = SEND;
            }
        }

        sample_index = next_sample_index;
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

int32_t main(void) {
    // do any device specific configuration here
    //SYSTEMConfig(FCPU, SYS_CFG_ALL); // config clock for PIC32
    WDTCTL = WDTPW | WDTHOLD;    // Stop watchdog timer for MSP430
    P1DIR |= BIT0;
    Timing_Init(); // initialize the timing module first
    Task_Init(); // initialize task management module next
    UART_Init(UART_CHANNEL);
    UART_printf(UART_CHANNEL, "Inited\n");

    ADC_Init();

    //counter_t counter = {0};

    // enable interrupts after modules using interrupts have been initialized
    EnableInterrupts();
    Task_Schedule(send_sample, 0, 10, 10);
    //Task_Schedule(hello_world, &counter, 1000, 1000);
    ADC_AddChannel(1, 20, record_sample, 0);
    while(1) SystemTick();
}
