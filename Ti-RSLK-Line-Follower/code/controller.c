#include <code/controller.h>
#include <stdio.h>

volatile uint8_t active = 1;
uint8_t collisionCounter = 0;
uint8_t fixingRoutine = 0;

//handles bumper interrupts
void PORT4_IRQHandler(void) {
    asm("   cpsid i");
    if(active && !fixingRoutine) {          //only executes if the program is active and no interrupt is handled at the time
        collisionCounter++;                 //increment "collisionCounter" to count the first 5 iterations to prevent reading the starting line again
        fixingRoutine = 1;                  //sets flag that a collision is currently handled.
        for(int i = 0; i < 10000; i++) {}   //short delay
    }
    P4->IFG &= ~(237);
    asm("   cpsie i");
}

//handles TIMER_A0 interrupts
void TA0_0_IRQHandler(void) {
    TIMER_A0->CCTL[0] &= ~1;
}


#define PWN 15000   //pulse-width-modulation period of the motors


void adaptMotors(uint8_t data) {
    static uint16_t left = 0;                       //history of left motor speed. Remembers the left motor speed, if unhandled reflectance sensor input
    static uint16_t right = 0;                      //history of right motor speed. Remembers the left motor speed, if unhandled reflectance sensor input
    setLeftMotorSpeed(left);                        //sets left motor speed
    setRightMotorSpeed(right);                      //sets right motor speed
    if(data == 24 || data == 16 || data == 8) {     //center
        left = PWN/4;
        right = PWN/4;
    }
    if(data == 96 || data == 64 || data == 32) {    //slightly left
        left = PWN/4;
        right = PWN/6;
    }
    if(data == 6 || data == 4 || data == 2) {       //slightly right
            left = PWN/6;
            right = PWN/4;
    }
    if(data == 3 || data == 1) {                    //hard right
        left = 0;
        right = PWN/4;
    }
    if(data == 192 || data == 128) {                //hard left
        left = PWN/4;
        right = 0;
    }
}

//collision handling routine
void handleCollision() {
            setMotorDirection(1);
            setLeftMotorSpeed(3500);
            setRightMotorSpeed(4500);
            SysTick_05s();
            setMotorDirection(0);
            setRightMotorSpeed(0);
            SysTick_05s();
            SysTick_var(4799999);
            setLeftMotorSpeed(1000);
            setRightMotorSpeed(5000);
}


//main execution routine
void executeRoutine() {
    if (!active) return;
    SysTick_var(47999);
    if (fixingRoutine) {                    //guarantee that only one collision is handled and no cancels of executions happens
        handleCollision();                  //call function to handle collision
        fixingRoutine = 0;                  //reset flag
    }
    if (collisionCounter > 5) {             //active after at least 5 bumps
        if(reflectanceRead() == 0) return;  //if no line is found, end the iteration
        P4->IE &= ~(237);                   //else:     disable interrupts of bumpers for line handling
        setMotorDirection(1);               //reverse a bit
        setLeftMotorSpeed(2000);
        setRightMotorSpeed(2000);
        SysTick_05s_var(2);
        setMotorDirection(0);
        setLeftMotorSpeed(4000);            //forward right curve untill line is found again
        setRightMotorSpeed(0);
        SysTick_05s_var(2);
        adaptMotors(reflectanceRead());     //adapt to line
        collisionCounter = 0;               //reset collision flag
        P4->IE |= 237;                      //reactivate interrupts of bumpers

    }
    if (collisionCounter == 0) {            //normal execution without collision handling
        adaptMotors(reflectanceRead());     //adapt motor speeds to reflectance sensor output
    }
}

//polling until button S2 is pressed
void awaitButtonS2Press() {
    buttonS2Init();
    while(P1->IN & 16) {
    }
}
