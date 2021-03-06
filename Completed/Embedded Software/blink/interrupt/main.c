
// Include all the msp430 defines
#include <msp430.h>

// define what pin the led is connected to
#define LED_PIN 0

// Timer A interrupt
// CCR0 only
void __attribute__((interrupt(TIMER0_A0_VECTOR))) Timer_A0 (void) {
    //TA0CTL &= ~TAIFG;
    P1OUT ^= (1 << LED_PIN);
}

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

void setup_timer() {
    // Select clock source
    // SMCLK
    TA0CTL |= TASSEL_2;

    // Divide SMCLK by 1
    //UCSCTL5 |= DIVS_0;

    // Set to continuous mode
    TA0CTL |= MC_2;

    // divide timer clock by 8
    TA0CTL |= ID_3;

    // Enable timer interrupt
    TA0CCTL0 = CCIE;

    // Set capture compare register
    TA0CCR0 = 50000;

    // Enable Timer A0
    //TA0CTL |= TAIE;
}

int main() {
    // run setup functions above
    setup_watchdog();
    setup_led();
    setup_timer();

    __bis_SR_register(GIE);

    // Enter infinite loop
    // since there is nothing to exit to, there is no point
    // in not having an infinite loop
    while(1) {
        __no_operation();
    }
}

