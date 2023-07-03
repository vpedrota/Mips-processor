module DataMemory 
(
	input [31:0] data,
	input [8:0] addr,
	input we, clk, MemRead,
	output [31:0] q
);

	// Declare the DataMemory variable
	reg [31:0] ram[1023:0];

	// Variable to hold the registered read address
	reg [31:0] addr_reg;
	
	initial 
		begin
			addr_reg = 0;
		end

	always @ (negedge clk)
	begin
		// Write
		if (we)
			ram[addr] = data;
		
	end
	
	always @ (*)
	begin
		if(MemRead)
			addr_reg = addr;
	end

	// Continuous assignment implies read returns NEW data.
	// This is the natural behavior of the TriMatrix memory
	// blocks in Single Port mode.  
	assign q = ram[addr_reg];

endmodule
