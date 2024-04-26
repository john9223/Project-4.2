// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen
// by writing 'black' in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen by writing
// 'white' in every pixel;
// the screen should remain fully clear as long as no key is pressed.

//// Replace this comment with your code.

@status
M=-1        // Set status to black
D=0         
@SETSCREEN
0;JMP       // Jump to SETSCREEN

(LOOP)
@KBD
D=M         // D = curr keyboard character
@SETSCREEN
D;JEQ       // If no key is pressed, set screen to zeroes (white)
D=-1        // If key pressed, set screen to all ones (black)
    
(SETSCREEN)     // Set D=new status 
@ARG
M=D         // Save new status in ARG
@status     
D=D-M       // D=newstatus-status
@LOOP
D;JEQ       // If status didn't change, continue LOOP     
@ARG
D=M
@status
M=D         // Update status with new value    
@SCREEN
D=A         // D=Screen address
@8192
D=D+A       // D=Byte just past last screen address
@i
M=D         // Initialize i to SCREEN address
    
(SETLOOP)    
@i
D=M-1
M=D         // Decrement i
@LOOP
D;JLT       // If i<0, go back to LOOP
    
@status
D=M         // D=status
@i
A=M         
M=D         // Update current screen address with status
@SETLOOP
0;JMP       // Jump back to SETLOOP
