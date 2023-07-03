module BankRegister (
	input clock, RegWrite, Jal, 
	input [4:0] read_register1, read_register2, write_register, 
	input [31:0] write_data, PC,
	output [31:0] read_data1, read_data2
);
 
 reg [31:0] register[31:0];
	
	 
	assign  read_data1 = register[read_register1];
	assign  read_data2 = register[read_register2];

 
 always @(negedge clock)
 begin
	
    if(RegWrite)
		begin
			if(~Jal)
				register[write_register] <= write_data;
			else 
				register[31] <= PC;
		end
 end
endmodule