//////////////////////////////////////////////////////////////////////////////////
/* This program was written by Claire Seidel, a student at Texas A&M University, for her capstone project. */
//////////////////////////////////////////////////////////////////////////////////
/* This program creates the beamforming pattern for the low power mode, aka only have of the GPIO are in use. 
This module may not end up being necessary but can be used for future testing to see the amount of power delivered
with a various numbers of GPIO used. */

module beamforming_lowpower(
    input wire clock, 
    output reg [7:0] posOutput, 
    output reg [7:0] negOutput
    );
    
    wire dividedClk;
    
    // instantiating clock divider module
    // clock will be used to determine count
    secondary_clock secondClk(clock, dividedClk);
    
    reg [12:0] counter = 12'h0; // count to keep track of time for delay
    /* This module calculates the count. This determines which GPIO to turn on */
    always @(posedge dividedClk) begin
        if (counter == 12'h7D0) begin // resets when 2000 is hit
            counter = 12'h0;
        end else begin
            counter = counter + 1; // increment count by one
        end
    end
    
    
    /* This module determines which GPIO to activate based on the time. Half of the GPIO is in use which makes this low power. */
    always @(posedge clock) begin // checks to see if in turn off-phase, allows all signals to be on for 1000 time units 
        if (counter >= 12'h3E8) begin // begins by checking if the count is greater than 100
            posOutput[0] <= 0;
            posOutput[7] <= 0;
            if (counter >= 12'h4D3) begin // counter greater than 1235
                posOutput[1] <= 0;
                posOutput[6] <= 0;
            end
        end 
        else if (counter >= 12'h0) begin // clock to turn on GPIO signals
            posOutput[0] <= 1;
            posOutput[7] <= 1;
            if (counter >= 12'hEB) begin // greater than 235
                posOutput[1] <= 1;
                posOutput[6] <= 1;
            end
        end
     end
    
endmodule

