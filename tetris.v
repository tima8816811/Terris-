`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/26 16:16:25
// Design Name: 
// Module Name: tetris
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


module tetris (
    output reg move_able,shift_finish,down_able,die_true,remove_f,
    input clk,clr,move,down,die,renew1,renew2,remove,random,stop,auto_down,
    input [3:0] code
    );
wire     [239:0] M_OUT;
reg       [4:0] n;
reg       [3:0] m;
reg       [6:0] block;

parameter       A_1 = 7'b0001000;
parameter       B_1 = 7'b0011000;
parameter       B_2 = 7'b0010100;
parameter       B_3 = 7'b0010010;
parameter       B_4 = 7'b0010001;
parameter       C_1 = 7'b0101000;
parameter       C_2 = 7'b0100100;
parameter       C_3 = 7'b0100010;
parameter       C_4 = 7'b0100001;
parameter       D_1 = 7'b0111000;
parameter       D_2 = 7'b0110100;
parameter       E_1 = 7'b1001000;
parameter       E_2 = 7'b1000100;
parameter       E_3 = 7'b1000010;
parameter       E_4 = 7'b1000001;
parameter       F_1 = 7'b1011000;
parameter       F_2 = 7'b1010100;
parameter       G_1 = 7'b1101000;
parameter       G_2 = 7'b1100100;

    reg [2:0] ran;
    reg [9:0] R [23:0];
    reg [6:0] new_block;
    reg [6:0] block_p;
    reg [4:0] remove_cnt;
    reg [3:0] remove_s;
    reg [3:0] remove_finish;
    reg [4:0] remove_c;
    reg       carry;

assign M_OUT = {R[23],R[22],R[21],R[20],R[19],R[18],R[17],R[16],R[15],R[14],R[13],R[12],R[11],R[10],R[9],R[8],R[7],R[6],R[5],R[4],R[3],R[2],R[1],R[0]};

    always @ (posedge clk or posedge clr)
    begin
        if (clr) 
            ran<=0;
        else if (ran==7) 
            ran<=1;
        else ran<=ran+1;
    end 

//move
    always @ (*)
    begin
        move_able = 0;
        if (move)
        begin
            if (code[0])  //up
            begin
                case (block)
                A_1: move_able=0;
                B_1: if (m>=1)
                        begin if (!((R[n][m-1])|(R[n][m+1])|(R[n-1][m+1])))move_able=1; else move_able=0;end
                B_2: if (n<=22)
                        begin if (!((R[n-1][m-1])|(R[n+1][m])|(R[n-1][m]))) move_able=1; else move_able=0;end
                B_3: if (m<=8)
                        begin if (!(R[n][m-1] | R[n][m+1] | R[n+1][m-1])) move_able=1; else move_able=0;  end   
                B_4:    begin if (!((R[n-1][m])|(R[n+1][m])|(R[n+1][m+1]))) move_able=1; else move_able=0;end
                C_1: if (m<=8)
                        begin if (!((R[n][m-1])|(R[n][m+1])|(R[n+1][m+1]))) move_able=1; else move_able=0;end
                C_2:    begin if (!((R[n-1][m])|(R[n-1][m+1])|(R[n+1][m]))) move_able=1; else move_able=0;end
                C_3: if (m>=1)
                        begin if (!((R[n-1][m-1])|(R[n][m-1])|(R[n][m+1]))) move_able=1; else move_able=0;end
                C_4: if (n<=22)
                        begin if (!((R[n-1][m])|(R[n+1][m-1])|(R[n+1][m]))) move_able=1; else move_able=0;end
                D_1: if ((m>=1)&(m<=7))
                        begin if (!((R[n][m-1])|(R[n][m+1])|(R[n][m+2]))) move_able=1; else move_able=0;end
                D_2: if (n<=21)
                        begin if (!((R[n-1][m])|(R[n+1][m])|(R[n+2][m]))) move_able=1; else move_able=0;end
                E_1: if (n<=22)
                        begin if (!(R[n+1][m])) move_able=1; else move_able=0;end
                E_2: if (m<=8)
                        begin if (!(R[n][m+1])) move_able=1; else move_able=0;end
                E_3:    begin if (!(R[n-1][m])) move_able=1; else move_able=0;end
                E_4: if (m>=1)
                        begin if (!(R[n][m-1])) move_able=1; else move_able=0;end
                F_1: if (m>=1)
                        begin if (!((R[n-1][m-1])|(R[n-1][m]))) move_able=1; else move_able=0;end
                F_2: if (n<=22)
                        begin if (!((R[n-1][m+1])|(R[n+1][m]))) move_able=1; else move_able=0;end
                G_1: if (m>=1)
                        begin if (!((R[n-1][m+1])|(R[n][m-1]))) move_able=1; else move_able=0;end
                G_2: if (n<=22)
                        begin if (!((R[n][m+1])|(R[n+1][m+1]))) move_able=1; else move_able=0;end
                default move_able=0;
                endcase 
            end
            else if (code[2])  //left
            begin
                case (block)
                A_1: if (m>=1) if (!((R[n+1][m-1])|(R[n][m-1]))) move_able=1; else move_able=0;
                B_1: if (m>=1) if (!((R[n-1][m-1])|(R[n][m-1])|(R[n+1][m-1]))) move_able=1; else move_able=0;
                B_2: if (m>=2) if (!((R[n][m-2])|(R[n-1][m]))) move_able=1; else move_able=0;
                B_3: if (m>=2) if (!((R[n-1][m-2])|(R[n][m-1])|(R[n+1][m-1]))) move_able=1; else move_able=0;
                B_4: if (m>=2) if (!((R[n][m-2])|(R[n+1][m-2]))) move_able=1; else move_able=0;
                C_1: if (m>=2) if (!((R[n-1][m-1])|(R[n][m-1])|(R[n+1][m-2]))) move_able=1; else move_able=0;
                C_2: if (m>=2) if (!((R[n][m-2])|(R[n+1][m]))) move_able=1; else move_able=0;
                C_3: if (m>=1) if (!((R[n-1][m-1])|(R[n][m-1])|(R[n+1][m-1]))) move_able=1; else move_able=0;
                C_4: if (m>=2) if (!((R[n-1][m-2])|(R[n][m-2]))) move_able=1; else move_able=0;
                D_1: if (m>=1) if (!((R[n-1][m-1])|(R[n][m-1])|(R[n+1][m-1])|(R[n+2][m-1]))) move_able=1; else move_able=0;
                D_2: if (m>=2) if (!(R[n][m-2])) move_able=1; else move_able=0;
                E_1: if (m>=2) if (!((R[n-1][m-1])|(R[n][m-2]))) move_able=1; else move_able=0;
                E_2: if (m>=2) if (!((R[n-1][m-1])|(R[n][m-2])|(R[n+1][m-1])))    move_able=1; else move_able=0;
                E_3: if (m>=2) if (!((R[n][m-2])|(R[n+1][m-1]))) move_able=1; else   move_able=0;
                E_4: if (m>=1) if (!((R[n-1][m-1])|(R[n][m-1])|(R[n+1][m-1])))    move_able=1; else move_able=0;
                F_1: if (m>=2) if (!((R[n-1][m])|(R[n][m-2])|(R[n+1][m-2])))  move_able=1; else move_able=0;
                F_2: if (m>=2) if (!((R[n][m-2])|(R[n+1][m-1]))) move_able=1; else   move_able=0;
                G_1: if (m>=1) if (!((R[n-1][m-1])|(R[n][m-1])|(R[n+1][m-1])))    move_able=1; else move_able=0;
                G_2: if (m>=2) if (!((R[n-1][m-1])|(R[n][m-2]))) move_able=1; else   move_able=0;
                default move_able=0;
                endcase
            end
            else if (code[3])  //right
            begin
                case (block)
                A_1: if (m<=7) if (!((R[n+1][m+2])|(R[n][m+2]))) move_able=1; else   move_able=0;
                B_1: if (m<=7) if (!((R[n+1][m+2])|(R[n][m+1])|(R[n-1][m+1])))    move_able=1; else move_able=0;
                B_2: if (m<=7) if (!((R[n][m+2])|(R[n-1][m+2]))) move_able=1; else   move_able<=0;
                B_3: if (m<=8) if (!((R[n-1][m+1])|(R[n][m+1])|(R[n+1][m+1])))    move_able=1; else move_able=0;
                B_4: if (m<=7) if (!((R[n][m+2])|(R[n+1][m]))) move_able=1; else     move_able=0;
                C_1: if (m<=8) if (!((R[n-1][m+1])|(R[n][m+1])|(R[n+1][m+1])))    move_able=1; else move_able=0;
                C_2: if (m<=7) if (!((R[n+1][m+2])|(R[n][m+2]))) move_able=1; else  move_able=0;
                C_3: if (m<=7) if (!((R[n-1][m+2])|(R[n][m+1])|(R[n+1][m+1])))    move_able=1; else move_able=0;
                C_4: if (m<=7) if (!((R[n-1][m])|(R[n][m+2]))) move_able=1; else     move_able=0;
                D_1: if (m<=8) if (!((R[n-1][m+1])|(R[n][m+1])|(R[n+1][m+1])|(R[n+2][m+1]))) move_able=1; else move_able=0;
                D_2: if (m<=6) if (!(R[n][m+3])) move_able=1; else move_able=0;
                E_1: if (m<=7) if (!((R[n-1][m+1])|(R[n][m+2]))) move_able=1; else   move_able=0;
                E_2: if (m<=8) if (!((R[n-1][m+1])|(R[n][m+1])|(R[n+1][m+1])))    move_able=1; else move_able=0;
                E_3: if (m<=7) if (!((R[n][m+2])|(R[n+1][m+1]))) move_able=1; else   move_able=0;
                E_4: if (m<=7) if (!((R[n-1][m+1])|(R[n][m+2])|(R[n+1][m+1])))    move_able=1; else move_able=0;
                F_1: if (m<=8) if (!((R[n-1][m+1])|(R[n][m+1])|(R[n+1][m])))    move_able=1; else move_able=0;
                F_2: if (m<=7) if (!((R[n][m+1])|(R[n+1][m+2]))) move_able=1; else   move_able=0;
                G_1: if (m<=7) if (!((R[n-1][m+1])|(R[n][m+2])|(R[n+1][m+2])))    move_able=1; else move_able=0;
                G_2: if (m<=7) if (!((R[n-1][m+2])|(R[n][m+1]))) move_able=1; else   move_able=0;
                default move_able=0;
                endcase
            end
        end
        else
            move_able = 0;
    end
    
       // down
    always @ (*)
    begin
       down_able = 0;
        if (down)
        begin
            case (block)
            A_1: if (n<=21) begin if (!(R[n+2][m] | R[n+2][m+1])) down_able = 1; else down_able = 0; end else down_able=0;
            B_1: if (n<=21) begin if (!(R[n+2][m] | R[n+2][m+1])) down_able = 1; else down_able = 0; end else down_able=0;
            B_2: if (n<=22) begin if (!(R[n+1][m] | R[n+1][m-1] | R[n+1][m+1])) down_able = 1; else down_able = 0; end else down_able=0;
            B_3: if (n<=21) begin if (!(R[n+2][m] | R[n][m-1])) down_able = 1; else down_able = 0; end else down_able=0;
            B_4: if (n<=21) begin if (!(R[n+1][m] | R[n+1][m+1] | R[n+2][m-1])) down_able = 1; else down_able = 0; end else down_able=0;
            C_1: if (n<=21) begin if (!(R[n+2][m] | R[n+2][m-1])) down_able = 1; else down_able = 0; end else down_able=0;
            C_2: if (n<=21) begin if (!(R[n+1][m] | R[n+1][m-1] | R[n+2][m+1])) down_able = 1; else down_able = 0; end else down_able=0;
            C_3: if (n<=21) begin if (!(R[n+2][m] | R[n][m+1])) down_able = 1; else down_able = 0; end else down_able=0;
            C_4: if (n<=22) begin if (!(R[n+1][m] | R[n+1][m-1] | R[n+1][m+1])) down_able = 1; else down_able = 0; end else down_able=0;
            D_1: if (n<=20) begin if (!(R[n+3][m])) down_able = 1; else down_able = 0; end else down_able=0;
            D_2: if (n<=22) begin if (!(R[n+1][m] | R[n+1][m-1] | R[n+1][m+1] | R[n+1][m+2])) down_able = 1; else down_able = 0; end else down_able=0;
            E_1: if (n<=22) begin if (!(R[n+1][m] | R[n+1][m-1] | R[n+1][m+1])) down_able = 1; else down_able = 0; end else down_able=0;
            E_2: if (n<=21) begin if (!(R[n+2][m] | R[n+1][m-1])) down_able = 1; else down_able = 0; end else down_able=0;
            E_3: if (n<=21) begin if (!(R[n+2][m] | R[n+1][m-1] | R[n+1][m+1])) down_able = 1; else down_able = 0; end else down_able=0;
            E_4: if (n<=21) begin if (!(R[n+2][m] | R[n+1][m+1])) down_able = 1; else down_able = 0; end else down_able=0;
            F_1: if (n<=21) begin if (!(R[n+2][m-1] | R[n+1][m])) down_able = 1; else down_able = 0; end else down_able=0;
            F_2: if (n<=21) begin if (!(R[n+2][m] | R[n+1][m-1] | R[n+2][m+1])) down_able = 1; else down_able = 0; end else down_able=0;
            G_1: if (n<=21) begin if (!(R[n+1][m] | R[n+2][m+1])) down_able = 1; else down_able = 0; end else down_able=0;
            G_2: if (n<=22) begin if (!(R[n+1][m] | R[n+1][m-1] | R[n][m+1])) down_able = 1; else down_able = 0; end else down_able=0;
            default down_able = 0;
            endcase
        end
        else
            down_able = 0;
    end

    integer i,j;
    always @ (posedge clk or posedge clr)
    begin
        if (clr)
            begin
                for (i = 0; i < 24; i = i + 1) 
                R[i] <= 0;
                remove_f<=0;
            end
        else if (renew2)
        begin
            case (block)
            A_1: begin R[n][m]<=1;R[n][m+1]<=1;R[n+1][m]<=1;R[n+1][m+1]<=1;end
            B_1: begin R[n-1][m]<=1;R[n][m]<=1;R[n+1][m]<=1;R[n+1][m+1]<=1;end
            B_2: begin R[n-1][m+1]<=1;R[n][m-1]<=1;R[n][m]<=1;R[n][m+1]<=1;end
            B_3: begin R[n-1][m-1]<=1;R[n-1][m]<=1;R[n][m]<=1;R[n+1][m]<=1;end 
            B_4: begin R[n][m-1]<=1;R[n][m]<=1;R[n][m+1]<=1;R[n+1][m-1]<=1;end
            C_1: begin R[n-1][m]<=1;R[n][m]<=1;R[n+1][m]<=1;R[n+1][m-1]<=1;end
            C_2: begin R[n][m-1]<=1;R[n][m]<=1;R[n][m+1]<=1;R[n+1][m+1]<=1;end
            C_3: begin R[n-1][m]<=1;R[n-1][m+1]<=1;R[n][m]<=1;R[n+1][m]<=1;end
            C_4: begin R[n-1][m-1]<=1;R[n][m-1]<=1;R[n][m]<=1;R[n][m+1]<=1;end
            D_1: begin R[n-1][m]<=1;R[n][m]<=1;R[n+1][m]<=1;R[n+2][m]<=1;end
            D_2: begin R[n][m-1]<=1;R[n][m]<=1;R[n][m+1]<=1;R[n][m+2]<=1;end
            E_1: begin R[n-1][m]<=1;R[n][m-1]<=1;R[n][m]<=1;R[n][m+1]<=1;end
            E_2: begin R[n-1][m]<=1;R[n][m-1]<=1;R[n][m]<=1;R[n+1][m]<=1;end
            E_3: begin R[n][m-1]<=1;R[n][m]<=1;R[n][m+1]<=1;R[n+1][m]<=1;end
            E_4: begin R[n-1][m]<=1;R[n][m]<=1;R[n][m+1]<=1;R[n+1][m]<=1;end
            F_1: begin R[n-1][m]<=1;R[n][m]<=1;R[n][m-1]<=1;R[n+1][m-1]<=1;end
            F_2: begin R[n][m-1]<=1;R[n+1][m]<=1;R[n][m]<=1;R[n+1][m+1]<=1;end
            G_1: begin R[n-1][m]<=1;R[n][m]<=1;R[n][m+1]<=1;R[n+1][m+1]<=1;end
            G_2: begin R[n-1][m]<=1;R[n-1][m+1]<=1;R[n][m-1]<=1;R[n][m]<=1;end
            default
            begin
                for (i = 0; i < 24; i = i + 1)
                    R[i] <= R[i];
            end
            endcase
             remove_s<=4'b1111;
        end


        else if (remove)
        begin
          if (!remove_finish[0])
            begin if ((&R[n-1])|(carry))
                begin
                    if (remove_s[0]) begin 
                    remove_c<=n-1; 
                     remove_s[0]<=0; 
                    carry<=1;end
                    else begin
                        if (remove_c>=1) begin 
                        R[remove_c]<=R[remove_c-1]; 
                        remove_c<=remove_c-1; 
                        carry<=1;end
                        else begin 
                        remove_finish[0]<=1;
                        carry<=0;
                        end
                    end
                end
            else begin 
            remove_finish[0]<=1; 
            carry<=0; 
            end
            end 
               
            else if (!remove_finish[1])
            begin if ((&R[n])|(carry))
                begin
                    if ( remove_s[1]) 
                        begin 
                        remove_c<=n; 
                         remove_s[1]<=0; 
                        carry<=1; end
                    else begin
                        if (remove_c>=1) 
                            begin 
                                R[remove_c]<=R[remove_c-1]; 
                                remove_c<=remove_c-1; 
                                carry<=1; end
                        else begin 
                            remove_finish[1]<=1; 
                            carry<=0; end
                    end
                end
            else begin 
                remove_finish[1]<=1; 
                carry<=0; end
            end
            
            else if (!remove_finish[2])
            begin
            if (n<=22)
                begin if ((&R[n+1])|(carry))
                    begin
                        if ( remove_s[2]) 
                            begin 
                                remove_c<=n+1; 
                                 remove_s[2]<=0;
                                carry<=1; end
                        else begin
                            if (remove_c>=1)  
                                begin 
                                    R[remove_c]<=R[remove_c-1]; 
                                    remove_c<=remove_c-1; 
                                    carry<=1; 
                                    end
                            else 
                                begin 
                                    remove_finish[2]<=1; 
                                    carry<=0; end
                        end
                    end
                    else begin remove_finish[2]<=1; carry<=0; end
                end
            else begin remove_finish[2]<=1; carry<=0; end
            end    
            else if (!remove_finish[3])
            begin
            if (n<=21)
                begin if ((&R[n+2])|(carry))
                    begin
                        if ( remove_s[3]) 
                            begin 
                                remove_c<=n+2; 
                                 remove_s[3]<=0; 
                                carry<=1; end
                        else begin
                            if (remove_c>=1) 
                                begin 
                                    R[remove_c]<=R[remove_c-1]; 
                                    remove_c<=remove_c-1; 
                                    carry<=1; end
                            else
                                 begin 
                                    remove_finish[3]<=1; 
                                    carry<=1; end
                        end
                    end
                    else 
                        begin 
                            remove_finish[3]<=1;
                            carry<=0; end
                end
           else begin remove_finish[3]<=1; carry<=0; end    
           end
          else
            begin
            for (i=0; i <24; i = i + 1) 
            R[i] <= R[i];
            remove_finish<=0;
            carry<=0;
            end
     end
     else if (stop) for (i=0;i<24;i=i+1) R[i]<=0;
end


    always @ (*)
    begin
        case (block)
        A_1: block_p = A_1;
        B_1: block_p = B_2;
        B_2: block_p = B_3;
        B_3: block_p = B_4;
        B_4: block_p = B_1;
        C_1: block_p = C_2;
        C_2: block_p = C_3;
        C_3: block_p = C_4;
        C_4: block_p = C_1;
        D_1: block_p = D_2;
        D_2: block_p = D_1;
        E_1: block_p = E_2;
        E_2: block_p = E_3;
        E_3: block_p = E_4;
        E_4: block_p = E_1;
        F_1: block_p = F_2;
        F_2: block_p = F_1;
        G_1: block_p = G_2;
        G_2: block_p = G_1;
        default block_p = 7'b0000000;
        endcase
    end



    always @ (posedge clk or posedge clr)
    begin
        if (clr)
            block <= 7'b0000000;
        else if (random)
            block <= new_block;
        else if (renew1 && code[0])
            block <= block_p;
        else
            block <= block;
    end


    // n    
    always @ (posedge clk or posedge clr)
    begin
        if (clr)
            n <= 0;
        else if (random)
            n <= 1;
        else if ((renew1)&(auto_down))
            n<=n+1;
        else if ((renew1)&(code[1]))
            n <= n+1;
        else
            n <= n;
    end

    // m
    always @ (posedge clk or posedge clr)
    begin
        if (clr)
            m <= 0;
        else if (random)
            m <= 5;
        else if (renew1)
        begin
            if (auto_down) m<=m;
            else if (code[2])
                m <= m - 1;
            else if (code[3])
                m <= m + 1;
            else
                m <= m;
        end
        else
            m <= m;
    end


    always @(*)
    begin
        if (clr)
            new_block = A_1;
        else if (random)
        begin
            case (ran)
            1: new_block = A_1;
            2: new_block = B_1;
            3: new_block = C_1;
            4: new_block = D_1;
            5: new_block = E_1;
            6: new_block = F_1;
            7: new_block = G_1;
            default new_block = A_1;
            endcase
        end
        else
            new_block = A_1;
    end


    always @(posedge clk or posedge clr)
    begin
        if (clr)
            shift_finish <= 0;
        else if (renew1)
            shift_finish <= 1;
        else
           shift_finish <= 0;
    end



    always @(posedge clk or posedge clr)
    begin
        if (clr)
            remove_f <= 0;
        else if (&remove_finish)
            remove_f <= 1;
        else
            remove_f <= 0;
    end

//die
    always @(*)
    begin
       if (die) begin
            if (|R[3]) die_true = 1;
            else die_true = 0;
       end
       else die_true=0;
    end
    

endmodule
