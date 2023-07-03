 module Control_Unit(instruction, RegDst, jump, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, Jal, JR, halt, output_flag, ALU_ctr);

	input [31:0] instruction;
	reg [6:0] opcode, funct;
	output reg RegDst, jump, Branch, MemtoReg, ALUSrc, RegWrite, MemWrite, MemRead, Jal, JR, halt, output_flag;
	output reg [3:0] ALU_ctr;
	
	always @ *
	
	begin
	
		opcode = instruction[31:26];
		funct = instruction[6:0];
		
		case(opcode)
		

			// HALT
			6'b111111: 
				begin
					halt <= 1;
				end
				
			// OUTPUT
			6'b101110: 
				begin
					halt <= 0;
					RegDst <= 0; 
					jump <= 0; 
					ALU_ctr <= 3'b000;
					Branch <= 0; 
					MemtoReg <= 0; 
					RegWrite <= 0;
					MemWrite <= 0; 
					MemRead <= 0; 
					ALUSrc <= 0;
					Jal <= 0;
					JR <= 0;
					output_flag <= 1;
				end

			//instruções tipo R
			6'b000000:begin 
				halt <= 0;
				RegDst <= 1; 
				jump <= 0; 
				Branch <= 0; 
				MemtoReg <= 0; 
				RegWrite <= 1;
				MemWrite <= 0; 
				MemRead <= 0; 
				ALUSrc <= 0;
				Jal <= 0;
				JR <= 0;
				output_flag <= 0;
				
				case (funct)
				
					6'b011000: ALU_ctr <= 4'b1000; // MULT
					6'b011010: ALU_ctr <= 4'b1001; // DIV
					6'b100000: ALU_ctr <= 4'b0010; // ADD
					6'b100010: ALU_ctr <= 4'b0110; // SUB
					6'b100100: ALU_ctr <= 4'b0000; // AND
					6'b100101: ALU_ctr <= 4'b0001; // OR
					6'b101010: ALU_ctr <= 4'b0101; // LESS THAN
					6'b101010: ALU_ctr <= 4'b1010; // LESS THAN
					6'b111111: ALU_ctr <= 4'b0011; //  COMP
					default: ALU_ctr <= 4'b1111;	
				endcase
			end
			
			//instrução tipo I ADDI
			6'b001000:begin 

				RegDst <= 0; halt <= 0; 
				jump <= 0; 
				ALU_ctr <= 4'b0010;
				Branch <= 0; 
				MemtoReg <= 0; 
				RegWrite <= 1;
				MemWrite <= 0; 
				MemRead <= 0; 
				ALUSrc <= 1; 
				Jal <= 0;
				JR <= 0;
				output_flag <= 0;
			end
			
			//instrução tipo I SUBI
			6'b101010:begin 
				RegDst <= 0; halt <= 0; 
				jump <= 0; 
				ALU_ctr <= 4'b0010;
				Branch <= 0; 
				MemtoReg <= 0; 
				RegWrite <= 1;
				MemWrite <= 0; 
				MemRead <= 0; 
				ALUSrc <= 1; 
				Jal <= 0;
				JR <= 0;
				output_flag <= 0;
			end
			
			//instruções tipo I LW 
			6'b100011:begin
				RegDst <= 0; halt <= 0; 
				jump <= 0; 
				ALU_ctr <= 4'b0010;
				Branch <= 0; 
				MemtoReg <= 1; 
				RegWrite <= 1;
				MemWrite <= 0; 
				MemRead <= 1; 
				ALUSrc <= 1;
				Jal <= 0;
				JR <= 0;
				output_flag <= 0;
				end
			
			//instruções tipo I SW 
			6'b101011:begin
				RegDst <= 0; halt <= 0; 
				jump <= 0; 
				ALU_ctr <= 4'b0010;
				Branch <= 0; 
				MemtoReg <= 0; 
				RegWrite <= 0;
				MemWrite <= 1; 
				MemRead <= 0; 
				ALUSrc <= 1;
				Jal <= 0;
				JR <= 0;
				output_flag <= 0;
			end
			
			//instrução tipo I BEQ 
			6'b000100:begin
				RegDst <= 0; halt <= 0; 
				jump <= 0; 
				ALU_ctr <= 4'b1010;
				Branch <= 1; 
				MemtoReg <= 0; 
				RegWrite <= 0;
				MemWrite <= 0; 
				MemRead <= 0; 
				ALUSrc <= 0;
				Jal <= 0;
				JR <= 0;
				output_flag <= 0;
			end
			
			//instrução tipo I BNE
			6'b000101:begin
				RegDst <= 0; 
				halt <= 0; 
				jump <= 0; 
				ALU_ctr <= 4'b0011;
				Branch <= 1; 
				MemtoReg <= 0; 
				RegWrite <= 0;
				MemWrite <= 0; 
				MemRead <= 0; 
				ALUSrc <= 0;
				Jal <= 0;
				JR <= 0;
				output_flag <= 0;
				end
			
			//instrução tipo I BGT
			6'b000111:begin
				RegDst <= 0; 
				halt <= 0;
				jump <= 0;
				ALU_ctr <= 4'b0100;
				Branch <= 1;
				MemtoReg <= 0;
				RegWrite <= 0;
				MemWrite <= 0;
				MemRead <= 0;
				ALUSrc <= 0;
				Jal <= 0;
				JR <= 0;
				output_flag <= 0;
				end
			
			//instrução tipo I BLT
			6'b000001:begin
				RegDst <= 0; halt <= 0;
				jump <= 0; 
				ALU_ctr <= 4'b0101;
				Branch <= 1; 
				MemtoReg <= 0; 
				RegWrite <= 0;
				MemWrite <= 0;
				MemRead <= 0; 
				ALUSrc <= 0;
				Jal <= 0;
				JR <= 0;
				output_flag <= 0;
				end
				
			
			//instruções do tipo J
			6'b000010:begin
				RegDst <= 0; halt <= 0; 
				jump <= 1; 
				ALU_ctr <= 0;
				Branch <= 0; 
				MemtoReg <= 0; 
				RegWrite <= 0;
				MemWrite <= 0; 
				MemRead <= 0; 
				ALUSrc <= 0;
				Jal <= 0;
				JR <= 0;
				output_flag <= 0;
				end
				
				
				
			6'b000011:begin 
				RegDst <= 0; 
				halt <= 0; 
				jump <= 1; 
				ALU_ctr <= 0;
				Branch <= 0; 
				MemtoReg <= 0; 
				RegWrite <= 1;
				MemWrite <= 0; 
				MemRead <= 0; 
				ALUSrc <= 0;
				Jal <= 1;
				JR <= 0;
				output_flag <= 0;
			end
			
			6'b001111:begin 
				RegDst <= 0; halt <= 0; 
				jump <= 0; 
				ALU_ctr <= 0;
				Branch <= 0; 
				MemtoReg <= 0; 
				RegWrite <= 0;
				MemWrite <= 0; 
				MemRead <= 0; 
				ALUSrc <= 0;
				Jal <= 0;
				JR <= 1;
				output_flag <= 0;
			end
				
			default:begin
				RegDst <= 0; halt <= 0; 
				jump <= 0;
				ALU_ctr <= 0;
				Branch <= 0; 
				MemtoReg <= 0;
				RegWrite <= 0;
				MemWrite <= 0;
				MemRead <= 0; 
				ALUSrc <= 0;
				Jal <= 0;
				JR <= 0;
				output_flag <= 0;
				end
			endcase
	end
endmodule