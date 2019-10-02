#include<msp430.h>
#include<stdint.h>

#include "adc.h"

/** @brief hardware abstaction layer ADC initialization
 *
 * Must be implemented for each MCU in hal_adc.c and configure the ADC for single measurements with
 * interrupts enabled after completion of measurements.
 */
void hal_ADC_Init(void) {
    // Set sample time, enable conversion, and enable adc
    ADC12CTL0 = ADC12SHT02 | ADC12ON;
    ADC12CTL1 = ADC12SHP;

}


void setup_adc_pin(uint8_t channel) {
    switch (channel) {
    case 0:
        P6SEL |= BIT0;
        break;
    case 1:
        P6SEL |= BIT1;
        break;
    case 2:
        P6SEL |= BIT2;
        break;
    case 3:
        P6SEL |= BIT3;
        break;
    case 4:
        P6SEL |= BIT4;
        break;
    case 5:
        P6SEL |= BIT5;
        break;
    case 6:
        P6SEL |= BIT6;
        break;
    case 7:
        P6SEL |= BIT7;
        break;
    }
}

uint8_t converting = 0;

/** @brief hardware abstaction layer start ADC measurement for a channel
 *
 * Must be implemented for each MCU in hal_adc.c and setup the ADC to sample the given channel, automatically
 * start the conversion, and interrupt when the conversion is complete. A interrupt service routine also
 * needs to be added to hal_adc.c which calls ADC_ProcessMeasurementFromISR() with the measured value.
 */
void hal_ADC_StartChannel(uint8_t channel) {
    // Setting up the pin is done here instead of hal_ADC_Init
    // because hal_ADC_Init does not know what channels to setup
    //setup_adc_pin(channel);

    P1SEL |= 1 << channel;

    // Select the input channel
    ADC12MCTL0 = channel & 0x07;

    // Enable conversion
    ADC12CTL0 |= ADC12ENC;

    // Start sampling
    ADC12CTL0 |= ADC12SC;

    // Enable interrupt
    ADC12IE = 1;

    converting = 1;
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
      // Disable interrupt
      //ADC12IE = 0;
      // Save measurement
      if (converting) {
          ADC_ProcessMeasurementFromISR(ADC12MEM0);
          converting = 0;
      }


      break;
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
