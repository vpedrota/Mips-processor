module RAM 
#(parameter DATA_WIDTH=32, parameter ADDR_WIDTH=32)
(
	input [(ADDR_WIDTH-1):0] address,
	input [(DATA_WIDTH-1):0] write_data,
	input MemWrite, MemRead, clock,
	output reg [(DATA_WIDTH-1):0] read_data_memory
);
	
	reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];
	reg [ADDR_WIDTH-1:0] addr_reg;

	always @ (negedge clock)
	begin
		
		if (MemWrite )
			ram[address] <= write_data;
	end
	
	always @ (*)
	begin
	
		read_data_memory = ram[address];
	end

endmodule
