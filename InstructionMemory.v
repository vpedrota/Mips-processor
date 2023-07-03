module InstructionMemory
#(parameter DATA_WIDTH=32, parameter read_address_WIDTH=10)
(
	input [(read_address_WIDTH-1):0] read_address,
	input clock, 
	output reg [(DATA_WIDTH-1):0] instruction
);

	
	reg [DATA_WIDTH-1:0] InstructionMemory[2**read_address_WIDTH-1:0];

	initial
	begin
		$readmemb("instructions.txt", InstructionMemory);
	end

	always @ (read_address)
	begin
		instruction <= InstructionMemory[read_address];
	end

endmodule
