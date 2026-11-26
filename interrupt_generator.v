`timescale 1ns / 1ps
/*
Name: Antonio Anzora Jr

Project Name: Interrupt Generaotr:

Summary: The goal is to generate interrupts by creating a cusotm AXI IP where
it contains an Interrupt Generator Module.
*/

module interrupt_generator(
    // System Clock: Sourced from the 50 MHz clock provided by the PS Side.
    input sys_clk,
    // System Reset: Active high reset for all logic assigned to the system clock domain.
    input sys_rst,
    // Interrupt Enabler Signal driven by control register in AXI reg block.
    input int_en,
    // Interrupt Clear control signal driven by control reg in the AXI reg block.
    input int_clr,
    // Generic Input to the interrupt generator. 
    input sig_in,
    // Level triggered interrupt output.
    output reg int_out
    );

    reg old_sig_in;
    wire sig_rising = sig_in & ~old_sig_in;
    
    always @(posedge sys_clk) begin
        if (sys_rst) begin
            // the reset clears eveything
            int_out <= 1'b0;
            //Clears old value to prevent false edge detection after reset.
            old_sig_in <= 1'b0;
        end else begin
            // Update the old value evvery cycle.Tracking sig_in every cycle
                old_sig_in <= sig_in;
                
                if(int_clr)
                    //Clears the interrupt by asserting int_clr
                    int_out <= 1'b0;
                else if (int_en && sig_rising)
                    // Rising edge is detected and interrupt enabled, assert interrupt.
                    int_out <= 1'b1;
                end
        end
endmodule
