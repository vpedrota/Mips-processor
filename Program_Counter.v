
module PC(
	clock,
	input_address,
	output_address,
	reset, 
	halt);
	
	
	input clock, reset, halt; 
	input [31:0] input_address;
	output reg [31:0] output_address;
	
	 always@(posedge clock) 
	 begin
	 
		if(reset)
				output_address <= 32'd0;
		 
		else if(~halt)
			output_address <= input_address;

		
	 end
	 
endmodule