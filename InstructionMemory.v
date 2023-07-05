module InstructionMemory
(
	input [31:0] read_address,
	input clock, 
	output reg [31:0] instruction
);

	
	reg [31:0] InstructionMemory[1023:0];

	initial
	begin
		$readmemb("instructions.txt", InstructionMemory);
	end

	always @ (read_address)
	begin
		instruction <= InstructionMemory[read_address];
	end

endmodule
