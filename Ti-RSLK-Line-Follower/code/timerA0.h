/*
 * author: Jonas K
 * latest updated: 26.02.2025
 */
#ifndef TIMERA0_H_
#define TIMERA0_H_

#include <stdint.h>

/*
 * input: None
 * output: None
 * description: This function initializes TIMER_A0. The period is set to 15000. No dividers are used. SMCLK is used as clock (12mHz). Up-Down-Mode is used for PWM. ccr[3] is used for the left motor. ccr[4] is used for the right motor.
 *              ccr[0] is set to 0xFFFF. The period is 2*ccr[0].
 */
void timerA0Init();

/*
 * input: uint32_t motorSpeed (left)
 * output: None
 * description: This function is used to set the duty period of TIMER_A0 3 to motorSpeed. The maximum input is 14999. Greater inputs are ignored.
 */
void setLeftMotorSpeed(uint32_t motorSpeed);

/*
 * input: uint32_t motorSpeed (right)
 * output: None
 * description: This function is used to set the duty period of TIMER_A0 4 to motorSpeed. The maximum input is 14999. Greater inputs are ignored.
 */
void setRightMotorSpeed(uint32_t motorSpeed);

/*
 * input: uint32_t direction (0: forward, 1: backward)
 * output: None
 * description: This function changes the direction of both motors using Port 5 Pin 4 and 5 based on direction.
 */
void setMotorDirection(uint32_t direction);

/*
 * input: uint32_t activation (0: off, 1: on)
 * output: None
 * description: This function activates or deactivated both motors using Port 3 Pin 6 and 7 based on activation.
 */
void setMotorActivation(uint32_t activation);

/*
 * input: None
 * output: None
 * description: This function is used to initialize all necessary pins for PWM of the motors. Port 2 Pin 4 and 5 (PWM). Port 3 Pin 6 and 7 (activation). Port 5 Pin 4 and 5 (direction).
 */
void pinInit();

#endif /* TIMERA0_H_ */
