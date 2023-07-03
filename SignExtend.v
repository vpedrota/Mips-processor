module SignExtend( input [15:0] signal_16, output reg [31:0]  signal_32);

	always @(signal_16)
	begin
		if(signal_16[15]==1) 
				signal_32[31:16]=16'b1111111111111111;
		else 
				signal_32[31:16]=16'b0000000000000000;
				
		signal_32[15:0]=signal_16[15:0];
	end
endmodule