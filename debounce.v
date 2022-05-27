`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/14 17:59:49
// Design Name: 
// Module Name: debounce
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


module debounce(
input btn,clk,clr,
output out
);
reg d1,d2,d3,d4,d5;
always @(posedge clk or posedge clr)
    begin
        if (clr)
            begin
                d1 <= 0;
                d2 <= 0;
                d3 <= 0;
                d4 <= 0;
                d5 <= 0;
             end
         else
            begin
                d1 <= btn;
                d2 <= d1;
                d3 <= d2;
                d4 <= d3;
                d5 <= d4;
             end
          end
assign out = ~d5&d2;

endmodule


