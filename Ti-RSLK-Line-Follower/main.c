#include <code/controller.h>
#include <stdint.h>

#include "msp.h"
#include "inc/clock.h"

void main(void) {
    Clock_Init48MHz();
	WDT_A->CTL = WDT_A_CTL_PW | WDT_A_CTL_HOLD;		//stop watchdog timer
	awaitButtonS2Press();                           //initialize all necessary peripherals and ports
	pinInit();
	timerA0Init();
	setMotorActivation(1);
	setMotorDirection(0);
	reflectanceInit();
	bumpersInit();
	while(1) {                                      //main loop
	    executeRoutine();
	}
}
