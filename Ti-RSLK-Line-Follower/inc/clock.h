/*
 * clock.h
 *
 *  Created on: 07.11.2021
 *      Author: Stolz
 */

#ifndef INC_CLOCK_H_
#define INC_CLOCK_H_

/**
 * Configure the MSP432 clock to run at 48 MHz
 * @param none
 * @return none
 * @note  Since the crystal is used, the bus clock will be very accurate
 * @see Clock_GetFreq()
 * @brief  Initialize clock to 48 MHz
 */
void Clock_Init48MHz(void);


#endif /* INC_CLOCK_H_ */
