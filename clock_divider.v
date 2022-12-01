`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
/* This program was written by Claire Seidel, a student at Texas A&M University, for her capstone project. */
//////////////////////////////////////////////////////////////////////////////////


module clock_divider(clock, divClk);
    input clock; // built-in reference clock; 125 MHz
    output divClk; // output new clock at the desired frequency 
    reg divClk;
    
    parameter divisor = 32'd62500000; // 125000000 / 62500000 = 2 Hz
    reg[31:0] divCount = 32'd0;// counter 
    
    /* This loop calculates the new clock by assigning the new clock the value of the reference clock if less than the divisor divided by two. 
    Then, the process repeats. */ 
    always@(posedge clock) begin 
        divCount = divCount + 32'd1; // increment count by 1
        if (divCount >= (divisor - 1)) begin 
            divCount = 32'd0; // reset count
        end
        divClk <= (divCount<(divisor/2))?1'b1:1'b0; // assign new clock to one if less than is true; assign to zero otherwise
    end
    
endmodule