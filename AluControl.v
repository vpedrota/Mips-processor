module ALU_Control(input [2:0] ALUop, input [5:0] opcode, output reg [3:0] ALU_control_operation );
 
 
 always @(ALUop, opcode)
 begin
    case(ALUop)
		  3'b000: ALU_control_operation <= 4'b0010;  //ADDI SOMA
		  3'b001: ALU_control_operation <= 4'b0110; //BEQ // SUB
		  3'b011: ALU_control_operation <= 4'b0011; //BNE
		  3'b111: ALU_control_operation <= 4'b0100; //BGT
		  3'b101: ALU_control_operation <= 4'b0101; //BGT
		  3'b010:
				begin
					case(opcode)
						6'b100000: ALU_control_operation <= 4'b0010; //SOMA
						6'b100010: ALU_control_operation <= 4'b0110; //SUBTRAÇÃO
						6'b100100: ALU_control_operation <= 4'b0000; //AND
						6'b100101: ALU_control_operation <= 4'b0001; //OR
						6'b011000: ALU_control_operation <= 4'b1000; //MULT
						6'b011010: ALU_control_operation <= 4'b1001; //DIV
						default: ALU_control_operation <= 4'b1111;
					endcase
				end
			default: ALU_control_operation <= 4'b1111;
	  endcase
 end
 
endmodule