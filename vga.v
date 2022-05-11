`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/04/27 18:47:54
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

module vga_sync

	(
		input wire clk, reset,
		output wire hsync, vsync, video_on, countF,
		output wire [9:0] x, y
	);

	parameter H_DISPLAY       = 640; 
	parameter H_L_BORDER      =  48; 
	parameter H_R_BORDER      =  16; 
	parameter H_RETRACE       =  96; 
	parameter H_MAX           = H_DISPLAY + H_L_BORDER + H_R_BORDER + H_RETRACE - 1;//799
	parameter START_H_RETRACE = H_DISPLAY + H_R_BORDER;
	parameter END_H_RETRACE   = H_DISPLAY + H_R_BORDER + H_RETRACE - 1;
	
	parameter V_DISPLAY       = 480; 
	parameter V_T_BORDER      =  10; 
	parameter V_B_BORDER      =  33; 
	parameter V_RETRACE       =   2; 
	parameter V_MAX           = V_DISPLAY + V_T_BORDER + V_B_BORDER + V_RETRACE - 1;//524
    parameter START_V_RETRACE = V_DISPLAY + V_B_BORDER;
	parameter END_V_RETRACE   = V_DISPLAY + V_B_BORDER + V_RETRACE - 1;
	
	// mod4 divHZ==25Mhz
	
	reg [1:0] count_next;
	wire count;
	
	always @(posedge clk, posedge reset)
		if(reset)
		  count_next <= 0;
		else
		  count_next <= count_next+1;

	
	assign count = count_next[1]; 
	
	reg [9:0] h_count_next, v_count_next;
	
	reg vsync_reg, hsync_reg;
	wire vsync_next, hsync_next;
 
	always @(posedge clk, posedge reset)
		if(reset)
		    begin
                    v_count_next <= 0;
                    h_count_next <= 0;
                    vsync_reg   <= 0;
                    hsync_reg   <= 0;
		    end
		else
		    begin
                    v_count_next <= v_count_next;
                    h_count_next <= h_count_next;
                    vsync_reg   <= vsync_next;
                    hsync_reg   <= hsync_next;
		    end
			
	always @(posedge count or posedge reset)
		begin
		  if (h_count_next == H_MAX)
		      h_count_next <= 0;
		  else 
		      h_count_next <= h_count_next + 1;
		 end
    
    always @(posedge count or posedge reset)
		begin
		  if (h_count_next == H_MAX)
		          if (v_count_next == V_MAX)
		              v_count_next <= 0;
		          else 
		              v_count_next <= v_count_next + 1;
		   end
		 
		  
        assign hsync_next = h_count_next >= START_H_RETRACE && h_count_next <= END_H_RETRACE;
   
        assign vsync_next = v_count_next >= START_V_RETRACE && v_count_next <= END_V_RETRACE;

        assign video_on = (h_count_next < H_DISPLAY) && (v_count_next < V_DISPLAY);

        assign hsync  = hsync_reg;
        assign vsync  = vsync_reg;
        assign x      = h_count_next;
        assign y      = v_count_next;
        assign countF = count;
endmodule

module vga_test
	(
		input wire clk, reset,
		input wire [11:0] sw,
		output wire hsync, vsync,
		output wire [11:0] rgb
	);
	
	reg [11:0] rgb_reg;
	
	wire video_on;

        vga_sync vga_sync_unit (
        .clk(clk), 
        .reset(reset), 
        .hsync(hsync), 
        .vsync(vsync),
        .video_on(video_on), 
        .countF(), 
        .x(), 
        .y()
        );
   
        always @(posedge clk, posedge reset)
        if (reset)
            rgb_reg <= 0;
        else
            rgb_reg <= sw;
        
        assign rgb = (video_on) ? rgb_reg : 12'b0;
endmodule
