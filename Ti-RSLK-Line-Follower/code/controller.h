/*
 * Controlling file of line following TI-RSLK
 * author: Jonas K
 * latest updated: 26.02.2025
 */

#ifndef CODE_EXC_H_
#define CODE_EXC_H_

#include <code/button.h>
#include <stdint.h> // to use uint32_t
#include "reflectance.h"
#include "bumper.h"
#include "msp.h"
#include "timerA0.h"

/*
 * input: None
 * ouput: None
 * description: This function is a polling function that stalls the program flow until button S2 (1.4) is pressed.
 */
void awaitButtonS2Press();

/*
 * input: None
 * output: None
 * description: This function is the main routine executer. It is meant to be executed within the main loop. In each iteration following steps are made:
 *          1. It is checked if the program is still running
 *          2. A delay of 100ms is applied
 *          3. It is checked if collision-mode is active. If so the robot behavior is adapted using "handleCollision()". First it is checked, if the "fixingCollision"-flag is set to prevent double executions of collision handling routine.
 *             after the routine, the flag is reset and future interrupts are allowed again.
 *             It is checked, if the robot bumped at least 5 times into something. If so, the reflectance sensors are activated and it is checked if a line is found again during each collision handle iteration. This minimum is introduced to
 *             prevent the robot of reading the initial line again after bumping into something.
 *          4. The reflectance sensors are read and the motor speeds of the robots are adapted accordingly.
 */
void executeRoutine();

/*
 * input: uint8_t data / reflectance sensor output
 * output: None
 * description: This function changes the speeds of the left and right motor using "setLeftMotorSpeed()" and "setRightMotorSpeed()" based on the given reflectance sensor input.
 *              There are 5 different modes for motor controll:
 *              1. Center
 *              2. Slightly left
 *              3. Slightly right
 *              4. Sharp left
 *              5. Sharp right
 */
void adaptMotors(uint8_t data);

/*
 * input: None
 * output: None
 * description: This function is called by "executeRoutine()" after at least one of the bumpers threw an interrupt. The robot drives back to the right. After that it drives forward again in a curve.
 */
void handleCollision();

#endif /* CODE_EXC_H_ */
