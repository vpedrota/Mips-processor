 module Control_Unit(op,RegDst,jump,Branch,MemRead,MemtoReg,ALUop,MemWrite,ALUSrc,RegWrite);
 input [5:0] op;
 output reg RegDst,jump,Branch,MemtoReg,ALUSrc,RegWrite,MemWrite,MemRead;
 output reg [2:0] ALUop;
 always @ *
 begin
  case(op)
   
  //OPCODES ESCOLHIDOS COM BASE NA LISTA DISPONÍVEL EM:
  //https://opencores.org/projects/plasma/opcodes
  
  //------------------------------------------------------------//
  
  
  // SYSCALL - input
  // flags para realizar a parada do clock e esperar a entrada do usuário
  6'b110011:begin 
	  RegDst <= 1; 
	  jump <= 0; 
	  ALUop <= 3'b010;
	  Branch <= 0; 
	  MemtoReg <= 0; 
	  RegWrite <= 1;
	  MemWrite <= 0; 
	  MemRead <= 0; 
	  ALUSrc <= 0;
  end
  
  // SYSCALL - output
  // flags para realizar a impressão de um valor de um registrador nos displays de 7 segmentos
  6'b110111:begin 
	  RegDst <= 1; 
	  jump <= 0; 
	  ALUop <= 3'b010;
	  Branch <= 0; 
	  MemtoReg <= 0; 
	  RegWrite <= 1;
	  MemWrite <= 0; 
	  MemRead <= 0; 
	  ALUSrc <= 0;
  end
  
  //instruções tipo R
  //000000
  //flags em nível alto - RegDst, RegWrite
  
  6'b0:begin 
	  RegDst <= 1; 
	  jump <= 0; 
	  ALUop <= 3'b010;
	  Branch <= 0; 
	  MemtoReg <= 0; 
	  RegWrite <= 1;
	  MemWrite <= 0; 
	  MemRead <= 0; 
	  ALUSrc <= 0;
  end
  
  //instrução tipo I ADDI
  //001000
  //flags em nível alto - RegWrite, ALUSrc
  
  6'b001000:begin 
	  RegDst <= 0; 
	  jump <= 0; 
	  ALUop <= 3'b000;
	  Branch <= 0; 
	  MemtoReg <= 0; 
	  RegWrite <= 1;
	  MemWrite <= 0; 
	  MemRead <= 0; 
	  ALUSrc <= 1; 
  end
  
  //instrução tipo I SUBI
  //001000
  //flags em nível alto - RegWrite, ALUSrc
  
  6'b101010:begin 
	  RegDst <= 0; 
	  jump <= 0; 
	  ALUop <= 3'b001;
	  Branch <= 0; 
	  MemtoReg <= 0; 
	  RegWrite <= 1;
	  MemWrite <= 0; 
	  MemRead <= 0; 
	  ALUSrc <= 1; 
  end
  
  //instruções tipo I LW 
  //100011
  //flags em nível alto - MemtoReg, MemRead, RegWrite, ALUSrc
  
  6'b100011:begin
	  RegDst <= 0; 
	  jump <= 0; 
	  ALUop <= 3'b000;
	  Branch <= 0; 
	  MemtoReg <= 1; 
	  RegWrite <= 1;
	  MemWrite <= 0; 
	  MemRead <= 1; 
	  ALUSrc <= 1;
	end
  
  //instruções tipo I SW 
  //101011
  //flags em nível alto - MemtoReg, ALUSrc
  
  6'b101011:begin
	  RegDst <= 0; 
	  jump <= 0; 
	  ALUop <= 3'b000;
	  Branch <= 0; 
	  MemtoReg <= 0; 
	  RegWrite <= 0;
	  MemWrite <= 1; 
	  MemRead <= 0; 
	  ALUSrc <= 1;
  end
  
  
  //instrução tipo I BEQ 
  //000100
  //flags em nível alto - Branch
  6'b000100:begin
	  RegDst <= 0; 
	  jump <= 0; 
	  ALUop <= 3'b001;
	  Branch <= 1; 
	  MemtoReg <= 0; 
	  RegWrite <= 0;
	  MemWrite <= 0; 
	  MemRead <= 0; 
	  ALUSrc <= 0;
  end
  
  //instrução tipo I BNE
  //000101
  //flags em nível alto - Branch
  6'b000101:begin
	  RegDst <= 0; 
	  jump <= 0; 
	  ALUop <= 3'b011;
	  Branch <= 1; 
	  MemtoReg <= 0; 
	  RegWrite <= 0;
	  MemWrite <= 0; 
	  MemRead <= 0; 
	  ALUSrc <= 0;
	end
  
  //instrução tipo I BGT
  //000101
  //flags em nível alto - Branch
  6'b000111:begin
	  RegDst <= 0;
	  jump <= 0;
	  ALUop <= 3'b111;
	  Branch <= 1;
	  MemtoReg <= 0;
	  RegWrite <= 0;
	  MemWrite <= 0;
	  MemRead <= 0;
	  ALUSrc <= 0;
	end
  
  //instrução tipo I BLT
  //000101
  //flags em nível alto - Branch
  6'b000001:begin
	  RegDst <= 0;
	  jump <= 0; 
	  ALUop <= 3'b101;
	  Branch <= 1; 
	  MemtoReg <= 0; 
	  RegWrite <= 0;
	  MemWrite <= 0;
	  MemRead <= 0; 
	  ALUSrc <= 0;
	end
	  
  
  //instruções do tipo J
  6'd2:begin
	  RegDst <= 0; 
	  jump <= 1; 
	  ALUop <= 0;
	  Branch <= 0; 
	  MemtoReg <= 0; 
	  RegWrite <= 0;
	  MemWrite <= 0; 
	  MemRead <= 0; 
	  ALUSrc <= 0;
	end
	  
  default:begin
	  RegDst <= 0; 
	  jump <= 0;
	  ALUop <= 0;
	  Branch <= 0; 
	  MemtoReg <= 0;
	  RegWrite <= 0;
	  MemWrite <= 0;
	  MemRead <= 0; 
	  ALUSrc <= 0;
	end
  endcase
 end
endmodule