`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:45:57 02/12/2018 
// Design Name: 
// Module Name:    c2 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module c2(a,b,c,clk);
output a,b,c;
reg a,b,c;
input clk;
wire clk;

initial begin 
	a=0;
	b=0;
	c=0;
	end
	
always @(posedge clk)
begin
	if (b&&c) 
	a<=~a;
	if( (~a&&~b&&~c) || (a&&c) || (b&&c)) 
	b<=~b;
	if((a&&b&&c) || (~a&&b&&~c))
	c<=~c;
	
end


endmodule
