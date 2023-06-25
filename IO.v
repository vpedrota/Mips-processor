module IO (valor, HEX0, HEX1, HEX2);

input [0:31] valor;
output wire [0:6] HEX0, HEX1, HEX2;
	

	bcd bcd1((valor % 10), HEX0);
	bcd bcd2((valor / 10)  % 10, HEX1);
	bcd bcd3((valor / 100) % 10, HEX2);

	
endmodule