/*
 * author: Jonas K
 * latest updated: 26.02.2025
 */
#ifndef RELFECTANCE_H_
#define RELFECTANCE_H_

#include <stdint.h> // to use uint32_t

/*
 * input: None
 * output: None
 * description: This functions initializes the relfectance sensors at Port 7, which are used as capacitors and phototransistors, and initializes infrared-LEDs using Port 5 Pin 3 and Port 9 Pin 2.
 */
void reflectanceInit();

/*
 * input: None
 * output: uint8_t / reflectance sensor output (positive logic)
 * description: This function returns the reflectance sensor input using 8 bits. The lsb is the most left sensor, while the msb is the most right sensor.
 */
uint8_t reflectanceRead();

/*
 * input: uint32_t time (in cycles)
 * output: None
 * description: This function uses the SysTick-Timer using 48mHz to stall the execution for the given cycles. Can stall up to 300ms.
 */
void SysTick_var(uint32_t time);

/*
 * input: None
 * output: None
 * description: This function stalls the program flow for 500ms by calling "SysTick_var()" multiple times.
 */
void SysTick_05s();

/*
 * input: uint32_t time
 * output: None
 * description: This function stalls the program for time*500ms by calling "SysTick_05s()" time times.
 */
void SysTick_05s_var(uint32_t time);

#endif /* RELFECTANCE_H_ */
