`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/11 11:47:22
// Design Name: 
// Module Name: clockdiv
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


module clockdiv(
input clk,
input clr,
output reg clk_n
);

reg [1:0] count;
always @(posedge clk or posedge clr)
    begin 
        if (clr)
            count <= 0;
         else if (count == 3)
            count <=0;
         else 
            count <= count +1;
          end
always @(posedge clk or posedge clr)
    begin 
        if (clr)
            clk_n <= 0;
         else if(count<2)
            clk_n <= 1;
         else 
            clk_n <= 0;
         end
endmodule
