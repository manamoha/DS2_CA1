`timescale 1ns/1ns
module BubbleSortTB ();

logic clk, rst, start;
wire done;
bubbleSort UUT (clk, rst, start, done);
initial begin
    clk = 0;
    rst = 0;
    start = 1;
    #10
    start = 0;  
    #25000 $stop;
end
    always #3 clk = ~clk;
endmodule