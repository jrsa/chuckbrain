// map editor for ming mecca world core
// (for use with MindBrain)

// James Anderson and Shaurjya Banerjee, 2016

class DCShitter extends Chugen {
    float n;
    fun float tick(float in) {
        return n;
    }
}

DCShitter idx => dac.chan(1);
DCShitter invert => dac.chan(0);
Hid hi;
HidMsg msg;

if(!hi.openKeyboard(0)) {
    cherr <= "kb not opened, u fuckin wot m8" <= IO.newline();
    me.exit();
}

// on X7S1U
// 0.444V
// -1.0 => out.n;
-1.0 => float bottom;

// 5.02V
// -0.28 => out.n;
-0.28 => float top;

bottom - top => Math.fabs => float range;
119 - 11 => int steps;

range / steps => float stepsize;

// set both outputs to "zero"
bottom => idx.n;
bottom => invert.n;

// key codes
82 => int UP;
81 => int DOWN;
80 => int LEFT;
79 => int RIGHT;
44 => int SPACE;

while(true) {
    hi => now;
    while( hi.recv( msg ) ) {
        if( msg.isButtonDown() ) {
            if(msg.key == RIGHT) {
                stepsize +=> idx.n;   
            }            
            else if(msg.key == LEFT) {
                stepsize -=> idx.n;   
            }
            else if(msg.key == UP) {
                (stepsize * 9.5) +=> idx.n;
            }
            else if(msg.key == DOWN) {
                (stepsize * 9.5) -=> idx.n;
            }
            else if(msg.key == SPACE) {
                top => invert.n;
                100::ms => now;
                bottom => invert.n;
            }
        }
    }
}