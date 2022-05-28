`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/27 15:50:26
// Design Name: 
// Module Name: tb_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_top();
reg clk,clr,UP,LEFT,RIGHT,DOWN,start;

top u1 (
.clk(clk),
.clr(clr),
.UP(UP),
.LEFT(LEFT),
.RIGHT(RIGHT),
.DOWN(DOWN),
.start(start)
);

always #1 clk=~clk;
initial begin
clk=1;
clr=1;
start=0;
UP=0;
LEFT=0;
RIGHT=0;
DOWN=0;
#5
clr=0;
#5
start=1;
#10
LEFT=1;
#20
LEFT=0;
DOWN=1;
#20
DOWN=0;
#50
UP=1;
#20;
UP=0;
#20
RIGHT=1;
#50
RIGHT=0;
end
endmodule
