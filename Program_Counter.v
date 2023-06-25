
module PC(
	input_clock,
	input_address,
	output_address,
	reset, 
	halt);
	
	
	input input_clock, reset, halt; 
	input [31:0] input_address;
	output reg [31:0] output_address;
	
	/*
		Entradas:
			input_clock: entrada de um clock que irá sincronizar o funcionamento do módulo,
			input_address: representa o endereço da instrução que está sendo executada na última súbida do block
			reset: é uma entrada usada para redefinir o contador de programa
			halt: é uma entrada usada para pausar o contador de programa
			
		Saída:
			output_address: saída que representa o endereço da instrução anterior, deve ser atualizada a cada subida de clock

	*/


	 always@(posedge input_clock) 
	 begin
	 
		if(reset)
				output_address <= 32'd0;
		 
		else if(~halt)
			output_address <= input_address;
	 end
	 
endmodule