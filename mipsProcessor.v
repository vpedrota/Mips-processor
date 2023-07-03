module mipsProcessor(
	input CLOCK_50,
	input  reset,
	output [3:0]  ALU_ctr,
	output [31:0] instruction, 
	output RegDst, Jump, Branch, MemtoReg, ALUSrc, RegWrite, MemWrite, MemRead, zero, Jal, JR, halt, output_flag, clock_output,
	output [2:0] ALUop, 
	output [4:0] write_register,
	output [31:0] read_data_memory, jump_address,sign, ALU_output, read_data1, read_data2, write_data_input, ALU_input2, address_in, address_out, next_instruction_address,
	output [6:0] HEX1, HEX2, HEX3
);
	
	wire [31:0]  out_sign, and_branch_zero, desvio, instruction_Left, branch_address, desvio2;	

	ClockManager #(0) clock(.reset(reset), .clock(~CLOCK_50), .clock_output(clock_output)); 

	PC(.clock(clock_output), .input_address(address_in), .output_address(address_out), .reset(reset), .halt(halt));

	PCAdder(.address_in(address_out), .address_added(next_instruction_address));

	InstructionMemory(.read_address(address_out[12:2]), .clock(clock_output), .instruction(instruction));

	Control_Unit(instruction, RegDst, Jump, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, Jal, JR, halt, output_flag, ALU_ctr);

	MUX_3 #(6) MUX_Write_Register(.data1(instruction[20:16]), .data2(instruction[15:11]), .data3(5'b11111), .flag(RegDst), .data_out(write_register));

	BankRegister(.clock(clock_output), .RegWrite(RegWrite), .read_register1(instruction[25:21]), .read_register2(instruction[20:16]), .write_register(write_register), .write_data(write_data_input), .read_data1(read_data1), .read_data2(read_data2));

	SignExtend(.signal_16(instruction[15:0]), .signal_32(sign));

	MUX_2 #(32) ALU_in(.data1(read_data2), .data2(sign), .flag(ALUSrc), .data_out(ALU_input2));

	ALU ULA(.ALU_ctr(ALU_ctr), .data1(read_data1), .data2(ALU_input2), .Zero(zero), .ALU_output(ALU_output));

	DataMemory DataMemory(.addr(ALU_output), .data(read_data2), .we(MemWrite), .MemRead(MemRead), .clk(clock_output), .q(read_data_memory));

	MUX_3 #(6) MUX_Write_Data(.data1(ALU_output), .data2(read_data_memory), .data3(next_instruction_address), .flag(MemtoReg), .data_out(write_data_input));
	
	Left2(sign, out_sign);

	Left2_26(instruction[25:0], instruction_Left);

	ALU_Add_32 FinalAdress(.next_instruction_address(next_instruction_address), .signal_28bits(instruction_Left), .jump_address(jump_address));

	Branch_address_adder(out_sign, next_instruction_address, branch_address);

	doBranch(.flag(Branch), .zero(zero), .out(and_branch_zero));

	MUX_2 #(32) JR_OR_NEXT_ADDRESS_MUX(next_instruction_address, read_data1, JR, desvio2);

	MUX_2 #(32) Branchs(desvio2, branch_address, and_branch_zero, desvio);

	MUX_2 #(32) jump(desvio, jump_address, Jump, address_in);	
	
	bcd(read_data1, HEX1, HEX2, output_flag);
 
endmodule
