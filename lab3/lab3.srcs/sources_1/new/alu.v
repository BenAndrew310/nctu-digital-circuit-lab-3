`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/06/2020 04:31:01 PM
// Design Name: 
// Module Name: alu
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


module alu(alu_out, accum, data, opcode, zero, clk, reset);

input [8-1:0] accum;
input [8-1:0] data;
input [3-1:0] opcode;
input clk;
input reset;
output reg signed [8-1:0] alu_out;
output wire zero;

assign zero = (accum==0) ? 1'b1 : 1'b0;

reg signed [4-1:0] accum_c;
reg signed [4-1:0] data_c;

always @(posedge clk) begin
	if (reset) begin
	   alu_out = 8'b0;
	end
	// 000 : Pass accum
	else if (opcode==3'b0) alu_out <= accum;
	// 001 : accum + data	(add)
	else if (opcode==3'b001) alu_out <= accum + data;
	// 010 : accum - data 	(sub)
	else if (opcode==3'b010) alu_out <= accum - data;
	// 011 : accum AND data (bit-wise AND)
	else if (opcode==3'b011) alu_out <= accum & data;
	// 100 : accum XOR data (bit-wise XOR)
	else if (opcode==3'b100) alu_out <= accum ^ data;
	// 101 : ABS(accum) 	(absolute value)
	else if (opcode==3'b101) alu_out <= (accum[7]) ? (~accum + 1) : accum;
	// 110 : MUL 			(multiplication)
	else if (opcode==3'b110) begin
	   accum_c = accum[3:0];
	   data_c = data[3:0]; 
	   alu_out = accum_c * data_c;
	end
	// 111 : Pass data
	else if (opcode==3'b111) alu_out <= data;
	
	else alu_out <= 0;
end

endmodule

