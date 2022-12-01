timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
/* This program was written by Claire Seidel, a student at Texas A&M University, for her capstone project. */
//////////////////////////////////////////////////////////////////////////////////
/* This program produces the desired beamforming waves. The various GPIO are activated in a certain pattern that
was determined by the algorithm developed. The program currently makes a centrally focused beam. This module will be edited
to include more/less GPIO and timing altered to reflect the optimized beamforming algorithm. Feedback from the receiver will also
be included to ensure the proper placement of the transmitting device. Potentially, this code will update due to the feedback to change the timing to beamform at the correct distance the receiver is from the transmitter. */

module beamforming(posOutput, negOutput, clock);
    input clock; // built-in reference clock; 125 MHz
    output reg [7:0] posOutput; // output of modules
    output reg [7:0] negOutput; // additional output for expansion
    
    // wire DivClk for clock divider;
    wire dividedClk;
    
    // instantiating clock divider module 
    // new clock will be used for counter 
    secondary_clock secondClk(clock, dividedClk);
    
    reg [12:0] counter = 12'h0; // count is initially set to 0
    
    /* This loop increments the counter at the positive edge of the divided clock frequency (1 MHz).
    The counter values will be used to determine which register to excite. */
    always @(posedge dividedClk) begin
        if (counter == 12'h7D0) begin // resets when 2000 is hit
            counter = 12'h0;
        end else begin // counter increments 
            counter = counter + 1;
        end
    end
    
 
    /* This loop determines which registers should be on according to the time. 
    The sequence of register excitation reflects a beamforming pattern that forms a central beam. */
    always @(posedge clock) begin // checks to see if in turn off-phase, allows all signals to be on for 1000 time units 
        if (counter >= 12'h3E8) begin // begins by checking if the count is greater than 100
            posOutput[0] <= 0;
            posOutput[7] <= 0;
            if (counter >= 12'h4D3) begin // counter greater than 1235
                posOutput[1] <= 0;
                posOutput[6] <= 0;
                if (counter >= 12'h573) begin //counter greater than 1395
                    posOutput[2] <= 0;
                    posOutput[5] <= 0;
                    if (counter >= 12'h5C3) begin // counter greater than 1475
                        posOutput[3] <= 0;
                        posOutput[4] <= 0;
                    end
                end
            end
        end
        else if (counter >= 12'h0) begin // clock to turn on GPIO signals
            posOutput[0] <= 1;
            posOutput[7] <= 1;
            if (counter >= 12'hEB) begin // greater than 235
                posOutput[1] <= 1;
                posOutput[6] <= 1;
                if (counter >= 12'h18B) begin // greater than 395
                    posOutput[2] <= 1;
                    posOutput[5] <= 1;
                    if (counter >= 12'h1D8) begin // greater than 475
                        posOutput[3] <= 1;
                        posOutput[4] <= 1;
                    end
                end
            end
        end
     end
     
endmodule