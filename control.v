`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/16 18:39:51
// Design Name: 
// Module Name: control
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


module control(
input clk,clr,rotate,left,right,down,start,
input shift_finish,remove_finish,down_able,move_able,die_true,
output reg  [3:0] code,
output reg  gen_random,renew1,move_down,renew2,remove,stop,move,die,auto_down
);
//not reg not debounce
parameter time_f = 26'd25000001;
reg [25:0] time_cnt;
reg auto_down_reg;
reg keep;
  
    
always @ (posedge clk or posedge clr)
    begin
        if (clr)
            auto_down_reg <= 0;
        else if (time_cnt == time_f)
            auto_down_reg <= 1;
        else 
            auto_down_reg <= 0;
    end

 always @ (posedge clk or posedge clr)
    begin
        if (clr)
            auto_down <= 0;
        else
            auto_down <= auto_down_reg;
    end
    
parameter       S_blank     = 4'd0,
                S_random    = 4'd1,
                S_keep      = 4'd2,
                S_move      = 4'd3,
                S_renew1     = 4'd4,
                S_down      = 4'd5,
                S_renew2  = 4'd6,
                S_remove  = 4'd7,
                S_new     = 4'd8,
                S_stop      = 4'd9;
reg [3:0] state, next_state;

 always @(posedge clk or posedge clr)
    begin
        if (clr)
            state <= S_blank;
        else
            state <= next_state;
    end
 
     always @ (posedge clk or posedge clr)
    begin
        if (clr)
            time_cnt <= 0;
        else if (keep == 0 && time_cnt < time_f)
            time_cnt <= time_cnt + 1;
        else if (move_down == 1)
            time_cnt <= 0;
        else begin
            time_cnt <= time_cnt;
        end
    end
    
    
    always @ (posedge clk or posedge clr)
    begin
        if (clr) code<=0;
        else code<={right, left, down, rotate};
    end 
       
        
 always @ (*)
    begin
        next_state = S_blank;
        keep = 1;
        gen_random = 0;
        //code = 4'b0000;
        renew1 = 0;
        move_down = 0;
        renew2 = 0;
        remove = 0;
        stop = 0;
        move = 0;
        die = 0;
        case (state)
        S_blank:
        begin
            if (start)
                next_state = S_random;
            else
                next_state = S_blank;
        end
        S_random:
        begin
            gen_random = 1;
            next_state = S_keep;
        end
        S_keep:
        begin
            keep = 0;
            if (time_cnt == time_f)  
            begin
                next_state = S_down;
         
            end
            else if (down == 1)
            begin
               next_state = S_down;
  
            end
            else if ((left == 1)|| (right == 1)||(rotate == 1))
            begin
                next_state = S_move;
            end
            else
                next_state = S_keep;
        end
        S_move:    
        begin
            move = 1;
            if (move_able)
                next_state = S_renew1 ;
            else
                next_state = S_keep;
        end
        S_renew1 : 
        begin
            renew1  = 1;
            next_state = S_keep;
        end
        S_down:
        begin
            move_down = 1;
            if (down_able)
                next_state = S_renew1 ;
            else
                next_state = S_renew2;                
        end
        S_renew2:
        begin
            renew2 = 1;
            next_state = S_remove;
        end
        S_remove:
        begin
            remove = 1;
            if (remove_finish)
                next_state = S_new;
            else
                next_state = S_remove;
        end
        S_new:
        begin
            die = 1;
            if (die_true == 1)
                next_state = S_stop;
            else
                next_state = S_random;
        end
        S_stop:
        begin
            stop = 1;
            next_state = S_blank;
        end
        
        default next_state = S_blank;
        endcase
    end
    
endmodule
