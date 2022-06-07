`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/06/02 14:41:57
// Design Name: 
// Module Name: vga
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


module vga(
input clk,clr,
input [199:0] data,
output reg hsync,vsync,
output [3:0] r,g,b
);

reg[9:0]xsync,ysync;
reg [11:0] vga_rgb;
wire vidon;
wire [9:0] x;
wire [19:0] y;
wire [9:0] R [19:0];
  assign R[0] = data[9:0];
  assign R[1] = data[19:10];
  assign R[2] = data[29:20];
  assign R[3] = data[39:30];
  assign R[4] = data[49:40];
  assign R[5] = data[59:50];
  assign R[6] = data[69:60];
  assign R[7] = data[79:70];
  assign R[8] = data[89:80];
  assign R[9] = data[99:90];
  assign R[10] = data[109:100];
  assign R[11] = data[119:110];
  assign R[12] = data[129:120];
  assign R[13] = data[139:130];
  assign R[14] = data[149:140];
  assign R[15] = data[159:150];
  assign R[16] = data[169:160];
  assign R[17] = data[179:170];
  assign R[18] = data[189:180];
  assign R[19] = data[199:190];
  
always @(posedge clk or posedge clr) 
    begin
    if (clr) begin  
      xsync <= 10'd0;
    end
    else if (xsync == 10'd799) begin
      xsync <= 10'd0;
    end
    else begin
      xsync <= xsync + 1;
    end
  end

always @(posedge clk or posedge clr) 
  begin
    if (clr) begin
      ysync <= 10'd0;
    end
    else if (ysync == 10'd524) begin
      ysync <= 10'd0;
    end
    else if (xsync == 10'd799) begin
      ysync <= ysync + 1;
    end
  end

  always @(posedge clk or posedge clr) begin
    if (clr) begin
      hsync <= 1'b0;
    end
    else if (xsync == 799) begin
      hsync <=1'b0;
    end
    else if (xsync == 95) begin
      hsync <= 1'b1;
    end
  end

always @(posedge clk or posedge clr) begin
    if (clr) begin
      vsync <= 1'b0;
    end
    else if (ysync == 0) begin
      vsync <=1'b0;
    end
    else if (ysync == 1) begin
      vsync <= 1'b1;
    end
  end

assign vidon = (xsync > 143) && (xsync < 784) && (ysync > 34) && (ysync < 515);


assign x[0] = (xsync >= 344) && (xsync <= 367);
assign x[1] = (xsync >= 368) && (xsync <= 391);
assign x[2] = (xsync >= 392) && (xsync <= 415);
assign x[3] = (xsync >= 416) && (xsync <= 439);
assign x[4] = (xsync >= 440) && (xsync <= 463);
assign x[5] = (xsync >= 464) && (xsync <= 487);
assign x[6] = (xsync >= 488) && (xsync <= 511);
assign x[7] = (xsync >= 512) && (xsync <= 535);
assign x[8] = (xsync >= 536) && (xsync <= 559);
assign x[9] = (xsync >= 560) && (xsync <= 588);

assign y[0]  = (ysync >= 35) && (ysync <= 58); 
assign y[1]  = (ysync >= 59) && (ysync <= 82);
assign y[2]  = (ysync >= 83) && (ysync <= 106);
assign y[3]  = (ysync >= 107) &&(ysync <= 130);
assign y[4]  = (ysync >= 131) && (ysync <=154);
assign y[5]  = (ysync >= 155) && (ysync <=178); 
assign y[6]  = (ysync >= 179) && (ysync <202); 
assign y[7]  = (ysync >= 203) && (ysync <=226); 
assign y[8]  = (ysync >= 227) && (ysync <=250); 
assign y[9]  = (ysync >= 251) && (ysync <=274); 
assign y[10] = (ysync >= 275) && (ysync <=298); 
assign y[11] = (ysync >= 299) && (ysync <=322); 
assign y[12] = (ysync >= 323) && (ysync <=346); 
assign y[13] = (ysync >= 347) && (ysync <=370); 
assign y[14] = (ysync >= 371) && (ysync <=394); 
assign y[15] = (ysync >= 395) && (ysync <=418); 
assign y[16] = (ysync >= 419) && (ysync <=442); 
assign y[17] = (ysync >= 443) && (ysync <=466); 
assign y[18] = (ysync >= 467) && (ysync <=490); 
assign y[19] = (ysync >= 491) && (ysync <=514); 

integer i,j;
  always @(posedge clk or posedge clr) begin
    if (clr) begin
      vga_rgb <= 0;
    end
    else if (vidon)
    begin
        if (xsync>=344 && xsync<=583)
            if (x[0]&y[0]&R[0][0])
                vga_rgb <= 12'd4095;
            else if (x[1] & y[0] &R[0][1])
                vga_rgb <= 12'd4095;
            else if (x[2] & y[0] &R[0][2])
                vga_rgb <= 12'd4095;            
            else if (x[3] & y[0] &R[0][3])
                 vga_rgb <= 12'd4095;
            else if (x[4] & y[0] &R[0][4])
                 vga_rgb <= 12'd4095;
            else if (x[5] & y[0] &R[0][5])
                 vga_rgb <= 12'd4095;        
            else if (x[6] & y[0] &R[0][6])
                 vga_rgb <= 12'd4095;
            else if (x[7] & y[0] &R[0][7])
                 vga_rgb <= 12'd4095;
            else if (x[8] & y[0] & R[0][8])
                 vga_rgb <= 12'd4095;
            else if (x[9] & y[0] & R[0][9])
                vga_rgb <= 12'd4095;

            else if (x[0]&y[1]&R[1][0])
                vga_rgb <= 12'd4095;
            else if (x[1] & y[1] &R[1][1])
                vga_rgb <= 12'd4095;
            else if (x[2] & y[1] &R[1][2])
                vga_rgb <= 12'd4095;            
            else if (x[3] & y[1] &R[1][3])
                 vga_rgb <= 12'd4095;
            else if (x[4] & y[1] &R[1][4])
                 vga_rgb <= 12'd4095;
            else if (x[5] & y[1] &R[1][5])
                 vga_rgb <= 12'd4095;        
            else if (x[6] & y[1] &R[1][6])
                 vga_rgb <= 12'd4095;
            else if (x[7] & y[1] &R[1][7])
                 vga_rgb <= 12'd4095;
            else if (x[8] & y[1] & R[1][8])
                 vga_rgb <= 12'd4095;
            else if (x[9] & y[1] & R[1][9])
                vga_rgb <= 12'd4095;

            else if (x[0]&y[2]&R[2][0])
                vga_rgb <= 12'd4095;
            else if (x[1] & y[2] &R[2][1])
                vga_rgb <= 12'd4095;
            else if (x[2] & y[2] &R[2][2])
                vga_rgb <= 12'd4095;            
            else if (x[3] & y[2] &R[2][3])
                 vga_rgb <= 12'd4095;
            else if (x[4] & y[2] &R[2][4])
                 vga_rgb <= 12'd4095;
            else if (x[5] & y[2] &R[2][5])
                 vga_rgb <= 12'd4095;        
            else if (x[6] & y[2] &R[2][6])
                 vga_rgb <= 12'd4095;
            else if (x[7] & y[2] &R[2][7])
                 vga_rgb <= 12'd4095;
            else if (x[8] & y[2] & R[2][8])
                 vga_rgb <= 12'd4095;
            else if (x[9] & y[2] & R[2][9])
                vga_rgb <= 12'd4095;


            else if (x[0]&y[3]&R[3][0])
                vga_rgb <= 12'd4095;
            else if (x[1] & y[3] &R[3][1])
                vga_rgb <= 12'd4095;
            else if (x[2] & y[3] &R[3][2])
                vga_rgb <= 12'd4095;            
            else if (x[3] & y[3] &R[3][3])
                 vga_rgb <= 12'd4095;
            else if (x[4] & y[3] &R[3][4])
                 vga_rgb <= 12'd4095;
            else if (x[5] & y[3] &R[3][5])
                 vga_rgb <= 12'd4095;        
            else if (x[6] & y[3] &R[3][6])
                 vga_rgb <= 12'd4095;
            else if (x[7] & y[3] &R[3][7])
                 vga_rgb <= 12'd4095;
            else if (x[8] & y[3] & R[3][8])
                 vga_rgb <= 12'd4095;
            else if (x[9] & y[3] & R[3][9])
                vga_rgb <= 12'd4095;

            else if (x[0] & y[4] & R[4][0])
                vga_rgb <= 12'd4095;
            else if (x[1] & y[4] &R[4][1])
                vga_rgb <= 12'd4095;
            else if (x[2] & y[4] &R[4][2])
                vga_rgb <= 12'd4095;            
            else if (x[3] & y[4] &R[4][3])
                 vga_rgb <= 12'd4095;
            else if (x[4] & y[4] &R[4][4])
                 vga_rgb <= 12'd4095;
            else if (x[5] & y[4] &R[4][5])
                 vga_rgb <= 12'd4095;        
            else if (x[6] & y[4] &R[4][6])
                 vga_rgb <= 12'd4095;
            else if (x[7] & y[4] &R[4][7])
                 vga_rgb <= 12'd4095;
            else if (x[8] & y[4] & R[4][8])
                 vga_rgb <= 12'd4095;
            else if (x[9] & y[4] & R[4][9])
                vga_rgb <= 12'd4095;

            else if (x[0] &y[5] & R[5][0])
                vga_rgb <= 12'd4095;
            else if (x[1] & y[5] & R[5][1])
                vga_rgb <= 12'd4095;
            else if (x[2] & y[5] &R[5][2])
                vga_rgb <= 12'd4095;            
            else if (x[3] & y[5] &R[5][3])
                 vga_rgb <= 12'd4095;
            else if (x[4] & y[5] &R[5][4])
                 vga_rgb <= 12'd4095;
            else if (x[5] & y[5] &R[5][5])
                 vga_rgb <= 12'd4095;        
            else if (x[6] & y[5] &R[5][6])
                 vga_rgb <= 12'd4095;
            else if (x[7] & y[5] &R[5][7])
                 vga_rgb <= 12'd4095;
            else if (x[8] & y[5] & R[5][8])
                 vga_rgb <= 12'd4095;
            else if (x[9] & y[5] & R[5][9])
                vga_rgb <= 12'd4095;


            else if (x[0] & y[6] & R[6][0])
                vga_rgb <= 12'd4095;
            else if (x[1] & y[6] & R[6][1])
                vga_rgb <= 12'd4095;
            else if (x[2] & y[6] &R[6][2])
                vga_rgb <= 12'd4095;            
            else if (x[3] & y[6] &R[6][3])
                 vga_rgb <= 12'd4095;
            else if (x[4] & y[6] &R[6][4])
                 vga_rgb <= 12'd4095;
            else if (x[5] & y[6] &R[6][5])
                 vga_rgb <= 12'd4095;        
            else if (x[6] & y[6] &R[6][6])
                 vga_rgb <= 12'd4095;
            else if (x[7] & y[6] &R[6][7])
                 vga_rgb <= 12'd4095;
            else if (x[8] & y[6] & R[6][8])
                 vga_rgb <= 12'd4095;
            else if (x[9] & y[6] & R[6][9])
                vga_rgb <= 12'd4095;
            
            else if (x[0]&y[7]&R[7][0])
                vga_rgb <= 12'd4095;
            else if (x[1] & y[7] &R[7][1])
                vga_rgb <= 12'd4095;
            else if (x[2] & y[7] &R[7][2])
                vga_rgb <= 12'd4095;            
            else if (x[3] & y[7] &R[7][3])
                 vga_rgb <= 12'd4095;
            else if (x[4] & y[7] &R[7][4])
                 vga_rgb <= 12'd4095;
            else if (x[5] & y[7] &R[7][5])
                 vga_rgb <= 12'd4095;        
            else if (x[6] & y[7] &R[7][6])
                 vga_rgb <= 12'd4095;
            else if (x[7] & y[7] &R[7][7])
                 vga_rgb <= 12'd4095;
            else if (x[8] & y[7] & R[7][8])
                 vga_rgb <= 12'd4095;
            else if (x[9] & y[7] & R[7][9])
                vga_rgb <= 12'd4095;


            else if (x[0]&y[8]&R[8][0])
                vga_rgb <= 12'd4095;
            else if (x[1] & y[8] &R[8][1])
                vga_rgb <= 12'd4095;
            else if (x[2] & y[8] &R[8][2])
                vga_rgb <= 12'd4095;            
            else if (x[3] & y[8] &R[8][3])
                 vga_rgb <= 12'd4095;
            else if (x[4] & y[8] &R[8][4])
                 vga_rgb <= 12'd4095;
            else if (x[5] & y[8] &R[8][5])
                 vga_rgb <= 12'd4095;        
            else if (x[6] & y[8] &R[8][6])
                 vga_rgb <= 12'd4095;
            else if (x[7] & y[8] &R[8][7])
                 vga_rgb <= 12'd4095;
            else if (x[8] & y[8] & R[8][8])
                 vga_rgb <= 12'd4095;
            else if (x[9] & y[8] & R[8][9])
                vga_rgb <= 12'd4095;            


            else if (x[0]&y[9]&R[9][0])
                vga_rgb <= 12'd4095;
            else if (x[1] & y[9] &R[9][1])
                vga_rgb <= 12'd4095;
            else if (x[2] & y[9] &R[9][2])
                vga_rgb <= 12'd4095;            
            else if (x[3] & y[9] &R[9][3])
                 vga_rgb <= 12'd4095;
            else if (x[4] & y[9] &R[9][4])
                 vga_rgb <= 12'd4095;
            else if (x[5] & y[9] &R[9][5])
                 vga_rgb <= 12'd4095;        
            else if (x[6] & y[9] &R[9][6])
                 vga_rgb <= 12'd4095;
            else if (x[7] & y[9] &R[9][7])
                 vga_rgb <= 12'd4095;
            else if (x[8] & y[9] & R[9][8])
                 vga_rgb <= 12'd4095;
            else if (x[9] & y[9] & R[9][9])
                vga_rgb <= 12'd4095;

            else if (x[0]&y[10]&R[10][0])
                vga_rgb <= 12'd4095;
            else if (x[1] & y[10] &R[10][1])
                vga_rgb <= 12'd4095;
            else if (x[2] & y[10] &R[10][2])
                vga_rgb <= 12'd4095;            
            else if (x[3] & y[10] &R[10][3])
                 vga_rgb <= 12'd4095;
            else if (x[4] & y[10] &R[10][4])
                 vga_rgb <= 12'd4095;
            else if (x[5] & y[10] &R[10][5])
                 vga_rgb <= 12'd4095;        
            else if (x[6] & y[10] &R[10][6])
                 vga_rgb <= 12'd4095;
            else if (x[7] & y[10] &R[10][7])
                 vga_rgb <= 12'd4095;
            else if (x[8] & y[10] & R[10][8])
                 vga_rgb <= 12'd4095;
            else if (x[9] & y[10] & R[10][9])
                vga_rgb <= 12'd4095;

            else if (x[0]&y[11]&R[11][0])
                vga_rgb <= 12'd4095;
            else if (x[1] & y[11] &R[11][1])
                vga_rgb <= 12'd4095;
            else if (x[2] & y[11] &R[11][2])
                vga_rgb <= 12'd4095;            
            else if (x[3] & y[11] &R[11][3])
                 vga_rgb <= 12'd4095;
            else if (x[4] & y[11] &R[11][4])
                 vga_rgb <= 12'd4095;
            else if (x[5] & y[11] &R[11][5])
                 vga_rgb <= 12'd4095;        
            else if (x[6] & y[11] &R[11][6])
                 vga_rgb <= 12'd4095;
            else if (x[7] & y[11] &R[11][7])
                 vga_rgb <= 12'd4095;
            else if (x[8] & y[11] & R[11][8])
                 vga_rgb <= 12'd4095;
            else if (x[9] & y[11] & R[11][9])
                vga_rgb <= 12'd4095;

            else if (x[0]&y[12]&R[12][0])
                vga_rgb <= 12'd4095;
            else if (x[1] & y[12] &R[12][1])
                vga_rgb <= 12'd4095;
            else if (x[2] & y[12] &R[12][2])
                vga_rgb <= 12'd4095;            
            else if (x[3] & y[12] &R[12][3])
                 vga_rgb <= 12'd4095;
            else if (x[4] & y[12] &R[12][4])
                 vga_rgb <= 12'd4095;
            else if (x[5] & y[12] &R[12][5])
                 vga_rgb <= 12'd4095;        
            else if (x[6] & y[12] &R[12][6])
                 vga_rgb <= 12'd4095;
            else if (x[7] & y[12] &R[12][7])
                 vga_rgb <= 12'd4095;
            else if (x[8] & y[12] & R[12][8])
                 vga_rgb <= 12'd4095;
            else if (x[9] & y[12] & R[12][9])
                vga_rgb <= 12'd4095;


            else if (x[0]&y[13]&R[13][0])
                vga_rgb <= 12'd4095;
            else if (x[1] & y[13] &R[13][1])
                vga_rgb <= 12'd4095;
            else if (x[2] & y[13] &R[13][2])
                vga_rgb <= 12'd4095;            
            else if (x[3] & y[13] &R[13][3])
                 vga_rgb <= 12'd4095;
            else if (x[4] & y[13] &R[13][4])
                 vga_rgb <= 12'd4095;
            else if (x[5] & y[13] &R[13][5])
                 vga_rgb <= 12'd4095;        
            else if (x[6] & y[13] &R[13][6])
                 vga_rgb <= 12'd4095;
            else if (x[7] & y[13] &R[13][7])
                 vga_rgb <= 12'd4095;
            else if (x[8] & y[13] & R[13][8])
                 vga_rgb <= 12'd4095;
            else if (x[9] & y[13] & R[13][9])
                vga_rgb <= 12'd4095;

            else if (x[0] & y[14] & R[14][0])
                vga_rgb <= 12'd4095;
            else if (x[1] & y[14] &R[14][1])
                vga_rgb <= 12'd4095;
            else if (x[2] & y[14] &R[14][2])
                vga_rgb <= 12'd4095;            
            else if (x[3] & y[14] &R[14][3])
                 vga_rgb <= 12'd4095;
            else if (x[4] & y[14] &R[14][4])
                 vga_rgb <= 12'd4095;
            else if (x[5] & y[14] &R[14][5])
                 vga_rgb <= 12'd4095;        
            else if (x[6] & y[14] &R[14][6])
                 vga_rgb <= 12'd4095;
            else if (x[7] & y[14] &R[14][7])
                 vga_rgb <= 12'd4095;
            else if (x[8] & y[14] & R[14][8])
                 vga_rgb <= 12'd4095;
            else if (x[9] & y[14] & R[14][9])
                vga_rgb <= 12'd4095;

            else if (x[0] &y[15] & R[15][0])
                vga_rgb <= 12'd4095;
            else if (x[1] & y[15] & R[15][1])
                vga_rgb <= 12'd4095;
            else if (x[2] & y[15] &R[15][2])
                vga_rgb <= 12'd4095;            
            else if (x[3] & y[15] &R[15][3])
                 vga_rgb <= 12'd4095;
            else if (x[4] & y[15] &R[15][4])
                 vga_rgb <= 12'd4095;
            else if (x[5] & y[15] &R[15][5])
                 vga_rgb <= 12'd4095;        
            else if (x[6] & y[15] &R[15][6])
                 vga_rgb <= 12'd4095;
            else if (x[7] & y[15] &R[15][7])
                 vga_rgb <= 12'd4095;
            else if (x[8] & y[15] & R[15][8])
                 vga_rgb <= 12'd4095;
            else if (x[9] & y[15] & R[15][9])
                vga_rgb <= 12'd4095;


            else if (x[0] & y[16] & R[16][0])
                vga_rgb <= 12'd4095;
            else if (x[1] & y[16] & R[16][1])
                vga_rgb <= 12'd4095;
            else if (x[2] & y[16] &R[16][2])
                vga_rgb <= 12'd4095;            
            else if (x[3] & y[16] &R[16][3])
                 vga_rgb <= 12'd4095;
            else if (x[4] & y[16] &R[16][4])
                 vga_rgb <= 12'd4095;
            else if (x[5] & y[16] &R[16][5])
                 vga_rgb <= 12'd4095;        
            else if (x[6] & y[16] &R[16][6])
                 vga_rgb <= 12'd4095;
            else if (x[7] & y[16] &R[16][7])
                 vga_rgb <= 12'd4095;
            else if (x[8] & y[16] & R[16][8])
                 vga_rgb <= 12'd4095;
            else if (x[9] & y[16] & R[16][9])
                vga_rgb <= 12'd4095;
            
            else if (x[0]&y[17]&R[17][0])
                vga_rgb <= 12'd4095;
            else if (x[1] & y[17] &R[17][1])
                vga_rgb <= 12'd4095;
            else if (x[2] & y[17] &R[17][2])
                vga_rgb <= 12'd4095;            
            else if (x[3] & y[17] &R[17][3])
                 vga_rgb <= 12'd4095;
            else if (x[4] & y[17] &R[17][4])
                 vga_rgb <= 12'd4095;
            else if (x[5] & y[17] &R[17][5])
                 vga_rgb <= 12'd4095;        
            else if (x[6] & y[17] &R[17][6])
                 vga_rgb <= 12'd4095;
            else if (x[7] & y[17] &R[17][7])
                 vga_rgb <= 12'd4095;
            else if (x[8] & y[17] & R[17][8])
                 vga_rgb <= 12'd4095;
            else if (x[9] & y[17] & R[17][9])
                vga_rgb <= 12'd4095;


            else if (x[0]&y[18]&R[18][0])
                vga_rgb <= 12'd4095;
            else if (x[1] & y[18] &R[18][1])
                vga_rgb <= 12'd4095;
            else if (x[2] & y[18] &R[18][2])
                vga_rgb <= 12'd4095;            
            else if (x[3] & y[18] &R[18][3])
                 vga_rgb <= 12'd4095;
            else if (x[4] & y[18] &R[18][4])
                 vga_rgb <= 12'd4095;
            else if (x[5] & y[18] &R[18][5])
                 vga_rgb <= 12'd4095;        
            else if (x[6] & y[18] &R[18][6])
                 vga_rgb <= 12'd4095;
            else if (x[7] & y[18] &R[18][7])
                 vga_rgb <= 12'd4095;
            else if (x[8] & y[18] & R[18][8])
                 vga_rgb <= 12'd4095;
            else if (x[9] & y[18] & R[18][9])
                vga_rgb <= 12'd4095;            


            else if (x[0]&y[19]&R[19][0])
                vga_rgb <= 12'd4095;
            else if (x[1] & y[19] &R[19][1])
                vga_rgb <= 12'd4095;
            else if (x[2] & y[19] &R[19][2])
                vga_rgb <= 12'd4095;            
            else if (x[3] & y[19] &R[19][3])
                 vga_rgb <= 12'd4095;
            else if (x[4] & y[19] &R[19][4])
                 vga_rgb <= 12'd4095;
            else if (x[5] & y[19] &R[19][5])
                 vga_rgb <= 12'd4095;        
            else if (x[6] & y[19] &R[19][6])
                 vga_rgb <= 12'd4095;
            else if (x[7] & y[19] &R[19][7])
                 vga_rgb <= 12'd4095;
            else if (x[8] & y[19] & R[19][8])
                 vga_rgb <= 12'd4095;
            else if (x[9] & y[19] & R[19][9])
                vga_rgb <= 12'd4095;


            else
                vga_rgb <= 12'b0000_0000_1111;
         else
            vga_rgb <= 12'b0000_0000_0000;
    end
    else
    begin
      vga_rgb <= 0;
    end
end

  assign r = vga_rgb[11:8];
  assign g = vga_rgb[7:4];
  assign b = vga_rgb[3:0];
endmodule
