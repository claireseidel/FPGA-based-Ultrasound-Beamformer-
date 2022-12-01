`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
/* This program was written by Claire Seidel, a student at Texas A&M University, for her capstone project. */
//////////////////////////////////////////////////////////////////////////////////
/* This program combines all three modes (normal beamforming, low power, and test) and allows the user to 
switch between them by pressing the buttons. The LEDs corresponding to the buttons and therefore the mode so 
the user knows which mode is in use. */

module beamformer(posOutput, negOutput, led, clock, btn);          
    input clock; // refernce clock that is built-in; frequency of 125 MHz
    input [3:0] btn; // input buttons 
    output reg [7:0] posOutput; // output registers for the program 
    output reg [7:0] negOutput; // additional registers if array size increases
    output reg [3:0] led; // output leds
    
    wire [7:0] out1, out2, out3; // output of various modules
    wire [7:0] negOut; // additional output for various modules
    
    /* This loop assigns the status and led values as a function of the button pressed. */
    reg [1:0] status = 2'b00; // status to reflect which module the user wants to use
    always@(posedge clock) begin
        if (btn[0] == 1) begin // first button pressed
            status <= 2'b01; // status assigned 
            led <= 4'b0001; // first led illuminates
        end
        else if (btn[1] == 1) begin // second button pressed
            status <= 2'b10; // status assigned
            led <= 4'b0010; // second led illuminated
        end
        else if (btn[2] == 1) begin // third button pressed
            status <= 2'b11; // status assigned
            led <= 4'b0100; // third led illuminates
        end
    end
    
    /* These are the instantiations of the various modules. This has to be done outside of a loop
    Otherwise there is an error. */
    
    beamforming normBeam(.posOutput(out1), .negOutput(negOut), .clock(clock));
    beamforming_lowpower lowBeam(.posOutput(out2), .negOutput(negOut), .clock(clock));
    beamforming_test testBeam(.posOutput(out3), .negOutput(negOut), .clock(clock));
    
    /* This loop assigns the overall output to the output of a module depending on the value of the status variable. */
    always@(clock) begin
        case(status)
            2'b01: posOutput = out1; // normal mode
            2'b10: posOutput = out2; // low power mode
            2'b11: posOutput = out3; // test mode
        endcase
    end
      
endmodule