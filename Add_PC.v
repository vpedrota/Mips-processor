module Add_PC(address_in, address_added);
		input [31:0] address_in; 
		output [31:0] address_added;
		
		assign address_added = address_in + 32'd4;
endmodule