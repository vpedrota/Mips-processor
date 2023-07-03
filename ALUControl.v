module ALUControl(input [2:0] ALUop, input [5:0] opcode, output reg [3:0] ALUControl_operation );
 
 
 always @(ALUop, opcode)
 begin
    case(ALUop)
		  4'b0000: ALUControl_operation <= 4'b0000;  // SOMA
		  4'b0001: ALUControl_operation <= 4'b0001;  // SUBTRAÇÃO
		  4'b0010: ALUControl_operation <= 4'b0010;  // DIFERENTE
		  4'b0011: ALUControl_operation <= 4'b0011;  // MAIOR
		  4'b0100: ALUControl_operation <= 4'b0100;  // MENOR
		  4'b0110: ALUControl_operation <= 4'b0110;  // AND
		  4'b0010: ALUControl_operation <= 4'b1000;  // MULT
		  4'b0110: ALUControl_operation <= 4'b1001;  // DIV
		  default: ALUControl_operation <= 4'b1111;
	  endcase
 end
 
endmodule