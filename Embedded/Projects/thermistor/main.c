#include <msp430.h>

#include "thermistor_10k.h"

double lookup_temp(int voltage) {

    return thermistor_table[voltage>>2]-273;

    //    int temp_index = voltage / THERMISTOR_STEP_DELTA;
    //
    //if (temp_index < 0) {
    //return 0.0;
    //} else if (temp_index = THERMISTOR_STEP_MAX) {
    //return thermistor_table[THERMISTOR_STEP_MAX];
    //} else if (temp_index > THERMISTOR_STEP_MAX) {
    //return 0.0;
    //} else {

    /*   |
     *   |                             *
     *   |                        *
     * T |                   *
     * e |              *
     * m |         *
     * p |    *
     *   |
     *   |
     *   +--------------------------------
     *            ADC reading
     */

    //double low_temp = thermistor_table[temp_index];
    //double high_temp = thermistor_table[temp_index+1];
    //
    //double slope = (high_temp - low_temp) / THERMISTOR_STEP_DELTA;
    //
    //double offset = slope * (voltage - temp_index * THERMISTOR_STEP_DELTA);
    //
    //double temp = low_temp + offset;
    //
    //return temp;
    //}
}

void write_serial(char* buffer) {
    for (int i = 0; i < 8; i++) {
        while (!(UCA1IFG && UCTXIFG));
        UCA1TXBUF = buffer[i];
    }
}

void write_dec(int number) {
    char buffer[9] = "00000000";

    unsigned int to_convert = 0;

    if (number >= 0) {
        buffer[0] = ' ';
        to_convert = (unsigned int) number;
    } else {
        buffer[0] = '-';
        to_convert = (unsigned int) -number;
    }

    int i = 6;
    while (to_convert != 0 && i >=0) {
        buffer[i] = to_convert % 10 + '0';
        to_convert /= 10;
        i--;
        for (int i = 0; i < 10000; i++) {
            asm("");
        }
    }

    buffer[7] = '\n';
    write_serial(buffer);
}

void set_pwm(int value) {
    if (value == 0) {
        TA0CCTL1 &= ~OUT;
        TA0CCTL1 &= ~OUTMOD_7;
        TA0CCTL1 |= OUTMOD_0;
    } else if (value >= 10000) {
        TA0CCTL1 |= OUT;
        TA0CCTL1 &= ~OUTMOD_7;
        TA0CCTL1 |= OUTMOD_0;
    } else {
        TA0CCTL1 |= OUTMOD_7;
        TA0CCR1 = value;
    }
}

void setup_watchdog() {
    WDTCTL = WDTPW + WDTHOLD;                 // Stop WDT
}

void setup_adc() {
    ADC12CTL0 = ADC12SHT02 + ADC12ON;         // Sampling time, ADC12 on
    ADC12CTL1 = ADC12SHP;                     // Use sampling timer
    ADC12IE = 0x01;                           // Enable interrupt
    ADC12CTL0 |= ADC12ENC;
    P6SEL |= 0x01;                            // P6.0 ADC option select
    P1DIR |= 0x01;                            // P1.0 output
}

void setup_uart() {
    P4SEL |= BIT4+BIT5;                       // P3.3,4 = USCI_A0 TXD/RXD
    UCA1CTL1 |= UCSWRST;                      // **Put state machine in reset**
    UCA1CTL1 |= UCSSEL_2;                     // SMCLK
    UCA1BR0 = 9;                              // 1MHz 115200 (see User's Guide)
    UCA1BR1 = 0;                              // 1MHz 115200
    UCA1MCTL |= UCBRS_1 + UCBRF_0;            // Modulation UCBRSx=1, UCBRFx=0
    UCA1CTL1 &= ~UCSWRST;                     // **Initialize USCI state machine**
    UCA1IE |= UCRXIE;                         // Enable USCI_A0 RX interrupt
}

void setup_pwm() {
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
    TA0CCR0 = 9999;

    // Set capture/compare 1 to 499
    // 50% duty cycle
    TA0CCR1 = 4999;

    // Set CCR1 to Reset/Set
    TA0CCTL1 |= OUTMOD_7;
}

int main(void) {

    setup_watchdog();
    setup_adc();
    setup_uart();
    setup_pwm();

    __bis_SR_register(GIE);     // LPM0, ADC12_ISR will force exit

    int value = 0;
    int acc = 1;

    while (1) {
        ADC12CTL0 |= ADC12SC;                   // Start sampling/conversion

        int adc_value = ADC12MEM0;

        double temp = lookup_temp(adc_value);

        write_dec((int)temp);
    }
}

int in_buffer = 0;
int in_digit = 4;

// Echo back RXed character, confirm TX buffer is ready first
#if defined(__TI_COMPILER_VERSION__) || defined(__IAR_SYSTEMS_ICC__)
#pragma vector=USCI_A1_VECTOR
__interrupt void USCI_A1_ISR(void)
#elif defined(__GNUC__)
void __attribute__ ((interrupt(USCI_A1_VECTOR))) USCI_A1_ISR (void)
#else
#error Compiler not supported!
#endif
{

    while (!(UCA1IFG && UCTXIFG));

    char in = UCA1RXBUF;
    UCA1TXBUF = in;

    if (in == 'S') {
        in_buffer = 0;
        in_digit = 0;
    } else {
        switch(in_digit) {
            case 0:
                in_buffer = (in - '0') * 1000;
                in_digit = 1;
                break;
            case 1:
                in_buffer += (in - '0') * 100;
                in_digit = 2;
                break;
            case 2:
                in_buffer += (in - '0') * 10;
                in_digit = 3;
                break;
            case 3:
                in_buffer += (in - '0') * 1;
                in_digit = 4;
                set_pwm(in_buffer);
                //write_dec(in_buffer);
                break;
        }
    }
}

#if defined(__TI_COMPILER_VERSION__) || defined(__IAR_SYSTEMS_ICC__)
#pragma vector = ADC12_VECTOR
__interrupt void ADC12_ISR(void)
#elif defined(__GNUC__)
void __attribute__ ((interrupt(ADC12_VECTOR))) ADC12_ISR (void)
#else
#error Compiler not supported!
#endif
{
    switch(__even_in_range(ADC12IV,34))
    {
        case  0: break;                           // Vector  0:  No interrupt
        case  2: break;                           // Vector  2:  ADC overflow
        case  4: break;                           // Vector  4:  ADC timing overflow
        case  6:                                  // Vector  6:  ADC12IFG0
                 if (ADC12MEM0 >= 0x7ff)                 // ADC12MEM = A0 > 0.5AVcc?
                     P1OUT |= BIT0;                        // P1.0 = 1
                 else
                     P1OUT &= ~BIT0;                       // P1.0 = 0

                 __bic_SR_register_on_exit(LPM0_bits);   // Exit active CPU
        case  8: break;                           // Vector  8:  ADC12IFG1
        case 10: break;                           // Vector 10:  ADC12IFG2
        case 12: break;                           // Vector 12:  ADC12IFG3
        case 14: break;                           // Vector 14:  ADC12IFG4
        case 16: break;                           // Vector 16:  ADC12IFG5
        case 18: break;                           // Vector 18:  ADC12IFG6
        case 20: break;                           // Vector 20:  ADC12IFG7
        case 22: break;                           // Vector 22:  ADC12IFG8
        case 24: break;                           // Vector 24:  ADC12IFG9
        case 26: break;                           // Vector 26:  ADC12IFG10
        case 28: break;                           // Vector 28:  ADC12IFG11
        case 30: break;                           // Vector 30:  ADC12IFG12
        case 32: break;                           // Vector 32:  ADC12IFG13
        case 34: break;                           // Vector 34:  ADC12IFG14
        default: break;
    }
}

