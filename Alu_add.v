module ALU_Add_32(
	 input [31:0] next_instruction_address, 
	 input [27:0] signal_28bits,
	 output [31:0] jump_address);

 assign jump_address = {next_instruction_address[31:28], signal_28bits };
endmodule