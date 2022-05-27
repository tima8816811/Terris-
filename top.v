`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/27 15:57:47
// Design Name: 
// Module Name: top
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


module top(
input clk,
    input clr,
    input UP,
    input LEFT,
    input RIGHT,
    input DOWN,
    input start
    );
wire shift_finish, remove_finish, down_able, move_able,die_true;
wire [3:0] code;
wire gen_random,keep,renew1,move_down,renew2,remove,stop,move,die,auto_down;
wire rotate,left,right,down;

debounce u1 (
.clk(clk),
.clr(clr),
.btn(UP),
.out(rotate)
);

debounce u2 (
.clk(clk),
.clr(clr),
.btn(LEFT),
.out(left)
);

debounce u3 (
.clk(clk),
.clr(clr),
.btn(RIGHT),
.out(right)
);

debounce u4 (
.clk(clk),
.clr(clr),
.btn(DOWN),
.out(down)
);

control u5 (
.clk(clk),
.clr(clr),
.rotate(rotate),
.left(left),
.right(right),
.down(down),
.start(start),
.code(code),
.gen_random(gen_random),
.renew1(renew1),
.move_down(move_down),
.renew2(renew2),
.remove(remove),
.stop(stop),
.move(move),
.die(die),
.shift_finish(shift_finish),
.down_able(down_able),
.move_able(move_able),
.die_true(die_true),
.auto_down(auto_down),
.remove_finish(remove_finish)
);

tetris u6(
.clk(clk),
.clr(clr),
.move(move),
.down(move_down),
.die(die),
.renew1(renew1),
.renew2(renew2),
.remove(remove),
.random(gen_random),
.stop(stop),
.auto_down(auto_down),
.remove_f(remove_finish),
.code(code),
.move_able(move_able),
.shift_finish(shift_finish),
.down_able(down_able),
.die_true(die_true)
);
endmodule
