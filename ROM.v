module ROM
#(parameter DATA_WIDTH=32, parameter read_address_WIDTH=5)
(
	input [(read_address_WIDTH-1):0] read_address,
	input clock, 
	output reg [(DATA_WIDTH-1):0] instruction
);

	
	reg [DATA_WIDTH-1:0] rom[2**read_address_WIDTH-1:0];

	initial
	begin
		$readmemb("single_port_rom_init.txt", rom);
	end

	always @ (read_address)
	begin
		instruction <= rom[read_address];
	end

endmodule
