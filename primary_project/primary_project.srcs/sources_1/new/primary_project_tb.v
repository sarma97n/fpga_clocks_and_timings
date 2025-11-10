`timescale 1ns/1ps
`include "primary_project.v"

module primary_project_tb();

    reg clk;
    reg rst;
    reg [2:0] sw;
    wire [3:0] led;
    wire [6:0] seg;
    wire [3:0] an;
    wire clk_out;
    
    primary_project dut (.clk(clk), .rst(rst), .sw(sw), .led(led), .seg(seg), .an(an), .clk_out(clk_out));
    
 
    initial clk = 0;
    always #5 clk = ~clk;  
    
  
    initial begin
      
        rst = 1;
        sw = 3'b000;
        #100;
        
      
        rst = 0;
        #1000;
        
        
        sw = 3'b000;  
        #10000;
        
        sw = 3'b001;  
        #10000;
        
        sw = 3'b010;  
        #10000;
        
        sw = 3'b011;  
        #50000;
        
        sw = 3'b100;  
        #100000;
        
        
        rst = 1;
        #100;
        rst = 0;
        #10000;
        
        $display("Simulation completed successfully!");
        $finish;
    end
    
    initial begin
    $monitor("Time=%0t | Reset=%b | SW=%b | LED=%b | AN=%b | SEG=%b", 
    $time, rst, sw, led, an, seg);
    end

endmodule