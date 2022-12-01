`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////////////////////////////////
/* This program was written by Claire Seidel, a student at Texas A&M University, for her capstone project. */
/////////////////////////////////////////////////////////////////////////////////////////////////////////////

/* This module sequentially turns on and off each element of the array used. 
Feedback from the PCB will be used to ensure this test is functional and will light and LED if successful. */

module beamforming_test(posOutput, negOutput, clock);
    input clock;
    output reg [7:0] posOutput;
    output reg [7:0] negOutput;

    
    wire DivClk; // set frequency of test
    reg [3:0] counter = 4'b000; // counter to determine which element is on
    initial posOutput = 8'b0; // assigning initial output to 0
    
    // instantiating clock divider module 
    clock_divider ClkDiv(clock, DivClk);
    
    /* This loop calculates the counter and then activates the corresponding element of the array. */
    always@(posedge DivClk) begin
        posOutput = 8'b0; // reset the array to 0
        if (counter == 4'b1000) begin
            counter = 4'b0000; // reset count if equal to eight
        end else begin
            posOutput[counter] = 1; // turns on element at counter location
            counter = counter + 1; // increment counter
        end 
    end
    
endmodule