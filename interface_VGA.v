module vga
(
input clk,clr,
output reg hsync,vsync,
output [3:0] r,g,b
);

reg[9:0]xsync,ysync;
reg [3:0] r_r,g_r,b_r;
wire vidon;

always @(posedge clk) 
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

always @(posedge clk ) 
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

  always @(posedge clk  ) begin
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

always @(posedge clk ) begin
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

always @ (posedge clk)
		begin

			if (ysync < 135)
				begin              
					r_r <= 4'hF;    
					b_r <= 4'hF;
					g_r <= 4'hF;
				end 		
				
			else if (ysync >= 135 && ysync < 138)
				begin 
					if (xsync < 324)
						begin 
							r_r <= 4'hF;    
							b_r <= 4'hF;
							g_r <= 4'hF;
						end  
					else if (xsync >= 324 && xsync < 350)
						begin 
							r_r <= 4'h0;   
							b_r <= 4'h0;
							g_r <= 4'h0;
						end
					else if (xsync >= 370 && xsync < 396)
						begin 
							r_r <= 4'h0;   
							b_r <= 4'h0;
							g_r <= 4'h0;
						end 	
					else if (xsync >= 416 && xsync < 442)
						begin 
							r_r <= 4'h0;   
							b_r <= 4'h0;
							g_r <= 4'h0;
						end 
					else if (xsync >= 462 && xsync < 488)
						begin 
							r_r <= 4'h0;   
							b_r <= 4'h0;
							g_r <= 4'h0;
						end 	
				    else 
						begin 
							r_r <= 4'hF;   
							b_r <= 4'hF;
							g_r <= 4'hF;
						end	
					end  
		      else if (ysync >= 138 && ysync < 152)
				begin 
					if (xsync < 324)
						begin 
							r_r <= 4'hF;    
							b_r <= 4'hF;
							g_r <= 4'hF;
						end  
					else if (xsync >= 324 && xsync < 327)
						begin 
							r_r <= 4'h0;   
							b_r <= 4'h0;
							g_r <= 4'h0;
						end 
					else if (xsync >= 370 && xsync < 373)
						begin 
							r_r <= 4'h0;   
							b_r <= 4'h0;
							g_r <= 4'h0;
						end		
				    else if (xsync >= 393 && xsync < 396)
						begin 
							r_r <= 4'h0;   
							b_r <= 4'h0;
							g_r <= 4'h0;
						end 
					else if (xsync >= 416 && xsync < 419)
						begin 
							r_r <= 4'h0;   
							b_r <= 4'h0;
							g_r <= 4'h0;
						end	 
					else if (xsync >= 462 && xsync < 465)
						begin 
							r_r <= 4'h0;   
							b_r <= 4'h0;
							g_r <= 4'h0;
						end 	
					else if (xsync >= 485 && xsync < 488)
						begin 
							r_r <= 4'h0;   
							b_r <= 4'h0;
							g_r <= 4'h0;
						end 	
				    else 
						begin 
							r_r <= 4'hF;   
							b_r <= 4'hF;
							g_r <= 4'hF;
						end	
					end
					
			 else if (ysync >= 152 && ysync < 155)
				begin 
					if (xsync < 324)
						begin 
							r_r <= 4'hF;    
							b_r <= 4'hF;
							g_r <= 4'hF;
						end  
					else if (xsync >= 324 && xsync < 350)
						begin 
							r_r <= 4'h0;   
							b_r <= 4'h0;
							g_r <= 4'h0;
						end
					else if (xsync >= 370 && xsync < 396)
						begin 
							r_r <= 4'h0;   
							b_r <= 4'h0;
							g_r <= 4'h0;
						end
					else if (xsync >= 416 && xsync < 419)
						begin 
							r_r <= 4'h0;   
							b_r <= 4'h0;
							g_r <= 4'h0;
						end
					else if (xsync >= 429 && xsync < 442)
						begin 
							r_r <= 4'h0;   
							b_r <= 4'h0;
							g_r <= 4'h0;
						end	
					else if (xsync >= 462 && xsync < 488)
						begin 
							r_r <= 4'h0;   
							b_r <= 4'h0;
							g_r <= 4'h0;
						end 	
					else 
						begin 
							r_r <= 4'hF;   
							b_r <= 4'hF;
							g_r <= 4'hF;
						end
					end
			  
			  else if (ysync >= 155 && ysync < 180)
				begin 
					if (xsync < 324)
						begin 
							r_r <= 4'hF;    
							b_r <= 4'hF;
							g_r <= 4'hF;
						end  
					else if (xsync >= 324 && xsync < 327)
						begin 
							r_r <= 4'h0;   
							b_r <= 4'h0;
							g_r <= 4'h0;
						end 
					else if (xsync >= 370 && xsync < 373)
						begin 
							r_r <= 4'h0;   
							b_r <= 4'h0;
							g_r <= 4'h0;
						end	
					else if (xsync >= 416 && xsync < 419)
						begin 
							r_r <= 4'h0;   
							b_r <= 4'h0;
							g_r <= 4'h0;
						end 
					else if (xsync >= 439 && xsync < 442)
						begin 
							r_r <= 4'h0;   
							b_r <= 4'h0;
							g_r <= 4'h0;
						end 
					else if (xsync >= 462 && xsync < 465)
						begin 
							r_r <= 4'h0;   
							b_r <= 4'h0;
							g_r <= 4'h0;
						end 	
					else if (xsync >= 485 && xsync < 488)
						begin 
							r_r <= 4'h0;   
							b_r <= 4'h0;
							g_r <= 4'h0;
						end	
					else 
						begin 
							r_r <= 4'hF;   
							b_r <= 4'hF;
							g_r <= 4'hF;
						end	
					end
				else if (ysync >= 180 && ysync < 183)
				    begin
				        if(xsync >= 416 && xsync < 442)
				            begin 
							r_r <= 4'h0;   
							b_r <= 4'h0;
							g_r <= 4'h0;
						end 
						else begin 
							r_r <= 4'hF;   
							b_r <= 4'hF;
							g_r <= 4'hF;
						end	
					end
					
					
			     else if (ysync >= 360 && ysync < 363)
				begin 
					if (xsync < 324)
						begin 
							r_r <= 4'hF;    
							b_r <= 4'hF;
							g_r <= 4'hF;
						end  
					else if (xsync >= 324 && xsync < 350)
						begin 
							r_r <= 4'h0;   
							b_r <= 4'h0;
							g_r <= 4'h0;
						end
					else if (xsync >= 370 && xsync < 396)
						begin 
							r_r <= 4'h0;   
							b_r <= 4'h0;
							g_r <= 4'h0;
						end 	
					else if (xsync >= 416 && xsync < 442)
						begin 
							r_r <= 4'h0;   
							b_r <= 4'h0;
							g_r <= 4'h0;
						end 
					else if (xsync >= 462 && xsync < 488)
						begin 
							r_r <= 4'h0;   
							b_r <= 4'h0;
							g_r <= 4'h0;
						end 	
				    else 
						begin 
							r_r <= 4'hF;   
							b_r <= 4'hF;
							g_r <= 4'hF;
						end	
					end  
		      else if (ysync >= 363 && ysync < 377)
				begin 
					if (xsync < 324)
						begin 
							r_r <= 4'hF;    
							b_r <= 4'hF;
							g_r <= 4'hF;
						end  
					else if (xsync >= 324 && xsync < 327)
						begin 
							r_r <= 4'h0;   
							b_r <= 4'h0;
							g_r <= 4'h0;
						end 
					else if (xsync >= 370 && xsync < 373)
						begin 
							r_r <= 4'h0;   
							b_r <= 4'h0;
							g_r <= 4'h0;
						end		
				    else if (xsync >= 393 && xsync < 396)
						begin 
							r_r <= 4'h0;   
							b_r <= 4'h0;
							g_r <= 4'h0;
						end 
					else if (xsync >= 416 && xsync < 419)
						begin 
							r_r <= 4'h0;   
							b_r <= 4'h0;
							g_r <= 4'h0;
						end	 
					else if (xsync >= 428 && xsync < 431)
						begin 
							r_r <= 4'h0;   
							b_r <= 4'h0;
							g_r <= 4'h0;
						end	
					else if (xsync >= 439 && xsync < 442)
						begin 
							r_r <= 4'h0;   
							b_r <= 4'h0;
							g_r <= 4'h0;
						end		
					else if (xsync >= 462 && xsync < 465)
						begin 
							r_r <= 4'h0;   
							b_r <= 4'h0;
							g_r <= 4'h0;
						end 	
				    else 
						begin 
							r_r <= 4'hF;   
							b_r <= 4'hF;
							g_r <= 4'hF;
						end	
					end
					
			 else if (ysync >= 377 && ysync < 380)
				begin 
					if (xsync < 324)
						begin 
							r_r <= 4'hF;    
							b_r <= 4'hF;
							g_r <= 4'hF;
						end  
					else if (xsync >= 324 && xsync < 327)
						begin 
							r_r <= 4'h0;   
							b_r <= 4'h0;
							g_r <= 4'h0;
						end
					else if (xsync >= 337 && xsync < 350)
						begin 
							r_r <= 4'h0;   
							b_r <= 4'h0;
							g_r <= 4'h0;
						end	
					else if (xsync >= 370 && xsync < 396)
						begin 
							r_r <= 4'h0;   
							b_r <= 4'h0;
							g_r <= 4'h0;
						end
					else if (xsync >= 416 && xsync < 419)
						begin 
							r_r <= 4'h0;   
							b_r <= 4'h0;
							g_r <= 4'h0;
						end
					else if (xsync >= 428 && xsync < 431)
						begin 
							r_r <= 4'h0;   
							b_r <= 4'h0;
							g_r <= 4'h0;
						end	
					else if (xsync >= 439 && xsync < 442)
						begin 
							r_r <= 4'h0;   
							b_r <= 4'h0;
							g_r <= 4'h0;
						end	
					else if (xsync >= 462 && xsync < 488)
						begin 
							r_r <= 4'h0;   
							b_r <= 4'h0;
							g_r <= 4'h0;
						end 	
					else 
						begin 
							r_r <= 4'hF;   
							b_r <= 4'hF;
							g_r <= 4'hF;
						end
					end
			  
			  else if (ysync >= 380 && ysync < 405)
				begin 
					if (xsync < 324)
						begin 
							r_r <= 4'hF;    
							b_r <= 4'hF;
							g_r <= 4'hF;
						end  
					else if (xsync >= 324 && xsync < 327)
						begin 
							r_r <= 4'h0;   
							b_r <= 4'h0;
							g_r <= 4'h0;
						end 
					else if (xsync >= 347 && xsync < 350)
						begin 
							r_r <= 4'h0;   
							b_r <= 4'h0;
							g_r <= 4'h0;
						end 	
					else if (xsync >= 370 && xsync < 373)
						begin 
							r_r <= 4'h0;   
							b_r <= 4'h0;
							g_r <= 4'h0;
						end	
					else if (xsync >= 393 && xsync < 396)
						begin 
							r_r <= 4'h0;   
							b_r <= 4'h0;
							g_r <= 4'h0;
						end		
					else if (xsync >= 416 && xsync < 419)
						begin 
							r_r <= 4'h0;   
							b_r <= 4'h0;
							g_r <= 4'h0;
						end
					else if (xsync >= 428 && xsync < 431)
						begin 
							r_r <= 4'h0;   
							b_r <= 4'h0;
							g_r <= 4'h0;
						end	
					else if (xsync >= 439 && xsync < 442)
						begin 
							r_r <= 4'h0;   
							b_r <= 4'h0;
							g_r <= 4'h0;
						end				
					else if (xsync >= 462 && xsync < 465)
						begin 
							r_r <= 4'h0;   
							b_r <= 4'h0;
							g_r <= 4'h0;
						end 
					else 
						begin 
							r_r <= 4'hF;   
							b_r <= 4'hF;
							g_r <= 4'hF;
						end	
					end
					
				else if (ysync >= 405 && ysync < 408)
				    begin
				        if(xsync >= 324 && xsync < 350)
				            begin 
							r_r <= 4'h0;   
							b_r <= 4'h0;
							g_r <= 4'h0;
						end 
						else if(xsync >= 462 && xsync < 488)
				            begin 
							r_r <= 4'h0;   
							b_r <= 4'h0;
							g_r <= 4'h0;
						end
						else begin 
							r_r <= 4'hF;   
							b_r <= 4'hF;
							g_r <= 4'hF;
						end	
					end  
		end          
         
    assign r = (xsync > 144 && xsync <= 783 && ysync > 35 && ysync <= 514) ? r_r : 4'h0;
	assign b = (xsync > 144 && xsync <= 783 && ysync > 35 && ysync <= 514) ? b_r : 4'h0;
	assign g = (xsync > 144 && xsync <= 783 && ysync > 35 && ysync <= 514) ? g_r : 4'h0;
  
endmodule
