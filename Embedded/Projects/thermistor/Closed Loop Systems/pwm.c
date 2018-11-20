#include <msp430.h>
#include "pwm.h"

#define MAX_OUTPUT 10000
#define MIN_OUTPUT 0

#define MANUAL 0
#define AUTO 1

int mode = MANUAL;

int target = 0;

double kp = 0;
double ki = 0;

double integral_term = 0;

int output = MIN_OUTPUT;

void pwm_init() {
    // sets up timer 0 for pwm

    // Set P1.2 to output
    P1DIR |= BIT2;

    // Set P1.2 for peripheral function
    P1SEL |= BIT2;

    // Select clock source to SMCLK
    TA0CTL |= TASSEL_2;

    // Set to up mode
    TA0CTL |= MC_1;

    // Set capture/compare 0 to 999
    // 1kHz rate
    TA0CCR0 = MAX_OUTPUT-1;

    // Set capture/compare 1 to 499
    // 50% duty cycle
    TA0CCR1 = MIN_OUTPUT;

    // Set CCR1 to Reset/Set
    TA0CCTL1 |= OUTMOD_7;


    // Set timer 1 for pid loop

    // Use SMCLk
    TA1CTL |= TASSEL_2;

    // Continuous mode
    TA1CTL |= MC_2;

    // Enable interrupts
    TA1CTL |= TAIE;
}

void set_output(int value) {
    if (value <= MIN_OUTPUT) {
        TA0CCTL1 &= ~OUT;
        TA0CCTL1 &= ~OUTMOD_7;
        TA0CCTL1 |= OUTMOD_0;
        output = MIN_OUTPUT;
    } else if (value >= MAX_OUTPUT) {
        TA0CCTL1 |= OUT;
        TA0CCTL1 &= ~OUTMOD_7;
        TA0CCTL1 |= OUTMOD_0;
        output = MAX_OUTPUT;
    } else {
        TA0CCTL1 |= OUTMOD_7;
        TA0CCR1 = value;
        output = value;
    }
}

void pwm_manual_set(int value) {
    mode = MANUAL;
    set_output(value);
}

void pwm_auto_set(int value) {
    if (mode == MANUAL) {
        integral_term = output;
    }

    mode = AUTO;
    target = value;
}

void calculate_pid() {
    if (mode == AUTO) {
        double current_value = temperature_read();
        double error = target - current_value;

        double proportional_term = kp * error;
        integral_term += ki * error;

        // cap the integral to prevent integral windup
        if (integral_term > MAX_OUTPUT) {
            integral_term = MAX_OUTPUT;
        } else if (integral_term < MIN_OUTPUT) {
            integral_term = MIN_OUTPUT;
        }

        double new_output = proportional_term + integral_term;

        if (new_output > MAX_OUTPUT) {
            new_output = MAX_OUTPUT;
        } else if (new_output < MIN_OUTPUT) {
            new_output = MIN_OUTPUT;
        }

        set_output(new_output);
    }
}

void pwm_p_set(double p) {
    kp = p;
}


void pwm_i_set(double i) {
    ki = i;
}

// the rest of the interrupts
void __attribute__((interrupt(TIMER0_A1_VECTOR))) Timer_A1 (void) {

    // Reading TA0IV clears the interrupt flag
    switch (TA0IV) {
        case 2: // CCR1
            break;
        case 4: // CCR2
            break;
        case 10: // Overflow
            calculate_pid();
            break;
    }
}


