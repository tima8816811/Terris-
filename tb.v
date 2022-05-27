`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/14 18:00:44
// Design Name: 
// Module Name: tb
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


module tb(
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

debounce u1 (
.clk(clk),
.clr(clr),
.UP(UP),
.LEFT(LEFT),
.RIGHT(RIGHT),
.DOWN(DOWN),
.rotate(rotate),
.left(left),
.right(right),
.down(down)
);

control u2 (
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

tetris u3(
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
