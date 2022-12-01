`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
/* This program was written by Claire Seidel, a student at Texas A&M University, for her capstone project. */
//////////////////////////////////////////////////////////////////////////////////
/* This module creates a clock at the desired frequency by changing the value of the divisor */

module secondary_clock(clock, dividedClk);
    input clock; // built-in reference clock; 125 MHz
    output dividedClk; // output new clock at the desired frequency 
    reg dividedClk;
    
    parameter divisor = 32'd125000; // 125000000 / 125000 = 1000 Hz
    reg[31:0] divCount = 32'd0;// counter 
    
    /* This loop calculates the new clock by assigning the new clock the value of the reference clock if less then the divisor divided by two. 
    Then, the process repeats. */ 
    always@(posedge clock) begin
        divCount = divCount + 32'd1; // increment count by 1
        if (divCount >= (divisor - 1)) begin // reset the clock if greater or equal to divisor - 1
            divCount = 32'd0;
        end
        dividedClk <= (divCount<(divisor/2))?1'b1:1'b0; // assign new clock to one if less than is true; assign to zero otherwise
    end
endmodule
