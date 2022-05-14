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
    input clk,
    input clr,
    input UP,
    input LEFT,
    input RIGHT,
    input DOWN,
    output reg rotate,
    output reg left,
    output reg right,
    output reg down
    );
    
    reg [3:0] shift_up;
    reg [3:0] shift_left;
    reg [3:0] shift_right;
    reg [3:0] shift_down;
    
    always @(posedge clk or posedge clr)
    begin
        if (clr)
            shift_up <= 0;
        else
            shift_up <= {shift_up[2:0], UP};
    end
    
    always @(posedge clk or posedge clr)
    begin
        if (clr)
            shift_right <= 0;
        else
            shift_right <= {shift_right[2:0], RIGHT};
    end 
    
    always @(posedge clk or posedge clr)
    begin
        if (clr)
            shift_left <= 0;
        else
            shift_left <= {shift_left[2:0], LEFT};
    end
    
    always @(posedge clk or posedge clr)
    begin
        if (clr)
            shift_down <= 0;
        else
            shift_down <= {shift_down[2:0], DOWN};
    end
    
reg clk_div;
reg [7:0] clk_cnt;
always @ (posedge clk or posedge clr)
begin
    if (clr)
    begin
        clk_cnt <= 0;
        clk_div <= 0;
    end
    else if (clk_cnt <= 8'd49)
    begin
        clk_cnt <= clk_cnt + 1;
        clk_div <= clk_div;
    end
    else
    begin
        clk_cnt <= 0;
        clk_div <= ~clk_div;
    end
end

always @(posedge clk_div or posedge clr)
begin
    if (clr)
    begin
        rotate <= 0;
        left <= 0;
        right <= 0;
        down <= 0;
    end
    else
    begin
        rotate <= shift_up[3];
        left <= shift_left[3];
        right <= shift_right[3];
        down <= shift_down[3];
    end
end
endmodule
