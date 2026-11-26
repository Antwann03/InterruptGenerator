`timescale 1ns / 1ps
/*
Name: Antonio Anzora Jr

Project Name: Interrupt Generator

Design Name: Interrupt Generator Testbench

SummaryL Verifies the functionality of the interrupt_generator module
*/

module interrupt_generator_TB();
    //inputs
    reg sys_clk;
    reg sys_rst;
    reg int_en;
    reg int_clr;
    reg sig_in;
    //output
    wire int_out;
    
    interrupt_generator UUT(
        .sys_clk(sys_clk), .sys_rst(sys_rst), .int_en(int_en),
        .int_clr(int_clr), .sig_in(sig_in), .int_out(int_out));
    // Clock generator  
    initial sys_clk =0;
    always #10 sys_clk = ~sys_clk;
    
    initial begin
        //Test 1: Assert the reset signal for 5 cons clk cycles at the begining of simulation.
        //Rest is on
        sys_rst = 1;
        int_en=0;
        int_clr=0;
        sig_in=0;
        // This is for the 5 clock cyles; 20x5
        #100
        // Test 2:
        int_en =1;
        sig_in = 1;
        #100
        sig_in =0;
        // spacing to read simu visibily
        #20 
        //clearing the test 1.
        int_clr =1;
        #20
        int_clr=0;
        //Test 2 again
        int_en =0;
        sig_in=1;
        #100
       //spacing to read simu visibily
       sig_in =0;
       #20
       // test 3
       sig_in=1;
       int_en=1;
       #20
       sig_in=0;
       #60
       //Clear it
       int_clr=1;
       #20
       int_clr=0;
       #40
       
       $finish;
   end 
endmodule
