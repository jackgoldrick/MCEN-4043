/******** Load AVR timer interrupt macros ********/
#include <avr/interrupt.h>

/******** Sine wave parameters ********/
#define PI2     6.283185 // 2 * PI - saves calculating it later
#define AMP     255      // Multiplication factor for the sine wave
#define OFFSET  96      // Offset shifts wave to just positive values

/******** Lookup table ********/
#define LENGTH  256  // The length of the waveform lookup table
byte wave[LENGTH];   // Storage for the waveform

void setup() {

  additive();
 
  /******** Set timer1 for 8-bit fast PWM output ********/
  pinMode(9, OUTPUT);       // Make timer's PWM pin an output
  TCCR1B  = (1 << CS10);    // Set prescaler to full 16MHz
  TCCR1A |= (1 << COM1A1);  // PWM pin to go low when TCNT1=OCR1A
  TCCR1A |= (1 << WGM10);   // Put timer into 8-bit fast PWM mode
  TCCR1B |= (1 << WGM12); 

  /******** Set up timer 2 to call ISR ********/
  TCCR2A = 0;               // We need no options in control register A
  TCCR2B = (6 << CS20);     // Set prescaller to divide by 8
  TIMSK2 = (1 << OCIE2A);   // Set timer to call ISR when TCNT2 = OCRA2
  OCR2A = 32;               // sets the frequency of the generated wave
  sei();                    // Enable interrupts to generate waveform!
}

void loop() {  // Nothing to do!
}

/******** Called every time TCNT2 = OCR2A ********/
ISR(TIMER2_COMPA_vect) {  // Called each time TCNT2 == OCR2A
  static byte index=0;    // Points to successive entries in the wavetable
  OCR1AL = wave[index++]; // Update the PWM output
  asm("NOP;NOP");         // Fine tuning
  TCNT2 = 6;              // Timing to compensate for time spent in ISR
}

void additive(void) {
#define PARTIALS 20
float harmonic[PARTIALS] = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20};
float amplitude[PARTIALS] = {0.4340,-0.1013,-0.2347,-0.0000,0.1192,-0.0113, -0.0951,   -0.0000,    0.0682,   -0.0041,   -0.0595,   -0.0000, 0.0478,   -0.0021,   -0.0433,   -0.0000,    0.0367,   -0.0013, -0.0341,   -0.0000};
float v;

float an;
int i,j;
for (int i=0; i<LENGTH; i++) {
v = OFFSET;
for (int j=0; j<PARTIALS; j++) {
an = AMP*amplitude[j];
v += an*cos((PI2/LENGTH)*(i*harmonic[j]));
}
v = constrain(v,0,255);
wave[i]=byte(v);
}
}

//void additive(void) {
//  #define PARTIALS 8
//  float harmonic[PARTIALS] =  {1,3,5,7,9,11,13,15};
//  float amplitude[PARTIALS] = {1,3,5,7,9,11,13,15};
//  float v;
//  int i,j;
//  
//  
//  for (int i=0; i<LENGTH; i++) {
//    v = 0;
//    for (int j=0; j<PARTIALS; j++) {
//      if (amplitude[j] > 0) {
//        v += (AMP/(amplitude[j]+1)*sin((PI2/LENGTH)*(i*harmonic[j])));
//      }
//    }
//    v = constrain(v+OFFSET,0,255);
//    wave[i]=byte(v);
//  }
//}
