	module mipsProcessor(

								input CLOCK_50, 
								input halt,reset,
								output [31:0] instruction, 
								output RegDst, Jump, Branch, MemtoReg, ALUSrc, RegWrite, MemWrite, MemRead, clock_output, zero,
								output [2:0] ALUop, 
								output [4:0] write_register,
								output[31:0] jump_address,sign, ALU_output, read_data1, read_data2, write_data_input, ALU_input2, address_in, address_out, next_instruction_address
			
		);
		
		
 wire [4:0]  ALU_ctr;
 wire [31:0]  read_data_memory, out_sign, and_branch_zero, desvio, instruction_Left, branch_address;
 
 ClockManager #(0) clock(.reset(reset), .clock(~CLOCK_50), .clock_output(clock_output)); 								
							
 PC program_counter(.input_clock(clock_output), .input_address(address_in), .output_address(address_out), .reset(reset), .halt(halt));
 
 Add_PC NextAdress(.address_in(address_out), .address_added(next_instruction_address));
 
 ROM Instruction_memory(.read_address(address_out[6:2]), .clock(clock_output), .instruction(instruction));

 Control_Unit UC(instruction[31:26], RegDst, Jump, Branch, MemRead, MemtoReg, ALUop, MemWrite, ALUSrc, RegWrite);
 
 MUX #(6) write_register_MUX(.data1(instruction[20:16]), .data2(instruction[15:11]), .flag(RegDst), .data_out(write_register));
 
 Registers(.RegWrite(RegWrite), .clock(clock_output), .read_register1(instruction[25:21]), .read_register2(instruction[20:16]), .write_register(write_register), .write_data(write_data_input), .read_data1(read_data1), .read_data2(read_data2));
 
 sign_ep SignalExtend(.signal_16(instruction[15:0]), .signal_32(sign));
 
 MUX #(32) ALU_in(.data1(read_data2), .data2(sign), .flag(ALUSrc), .data_out(ALU_input2));
 
 ALU_Control ALUc(.ALUop(ALUop), .opcode(instruction[5:0]), .ALU_control_operation(ALU_ctr));
 
 ALU ULA(.ALU_ctr(ALU_ctr), .data1(read_data1), .data2(ALU_input2), .Zero(zero), .ALU_output(ALU_output));
 
 RAM DataMemory(.address(ALU_output), .write_data(read_data2), .MemWrite(MemWrite), .MemRead(MemRead), .clock(clock_output), .read_data_memory(read_data_memory));
 
 MUX #(32) write_input_data(.data1(ALU_output), .data2(read_data_memory), .flag(MemtoReg), .data_out(write_data_input));
 
 Left2(sign, out_sign);
 
 Left2_26(instruction[25:0], instruction_Left);
 
 ALU_Add_32 FinalAdress(.next_instruction_address(next_instruction_address), .signal_28bits(instruction_Left), .jump_address(jump_address));
 
 Branch_address_adder(out_sign, next_instruction_address, branch_address);
 
 doBranch(.flag(Branch), .zero(zero), .out(and_branch_zero));
 
 MUX #(32) Branchs(next_instruction_address, branch_address, and_branch_zero, desvio);
 
 MUX #(32) jump(desvio, jump_address, Jump, address_in);	
 
endmodule
