
// Include all the msp430 defines
#include <msp430.h>

// define what pin the led is connected to
#define LED_PIN 0

void setup_watchdog() {
    // disable the watchdog
    WDTCTL = WDTPW | WDTHOLD;
}

void setup_led() {
    // set the correct pin on port 1 to be an output for the led
    P1DIR |= 1<<LED_PIN;

    // turn off the led output
    P1OUT &= ~(1<<LED_PIN);
}

int main() {
    // run setup functions above
    setup_watchdog();
    setup_led();

    // Enter infinite loop
    // since there is nothing to exit to, there is no point
    // in not having an infinite loop
    while(1) {
        // Toggle the led pin with an xor
        P1OUT ^= 1<<LED_PIN;

        // delay with a simple busy loop
        // time delayed is determined by the initial value of i
        for (long i = 50000L; i; i--) {
            // tell the compiler that we are intending to do nothing here,
            // so that it does not optimise away the loop
            __no_operation();
        }
    }
}

