module bcd(input [31:0] valor, output [6:0] HEX1, HEX2, input output_flag);

reg [3:0] valor1, valor2;
reg [6:0] segmentos1, segmentos2;


// Converte cada valor BCD de 4 bits em uma saída para um display de 7 segmentos
always @(*)
begin
	if(output_flag)
		begin
			valor1 = valor%10;
			case (valor1)
				4'b0000: segmentos1=7'b0000001;
				4'b0001: segmentos1=7'b1001111;
				4'b0010: segmentos1=7'b0010010;
				4'b0011: segmentos1=7'b0000110;
				4'b0100: segmentos1=7'b1001100;
				4'b0101: segmentos1=7'b0100100;
				4'b0110: segmentos1=7'b0100000;
				4'b0111: segmentos1=7'b0001111;
				4'b1000: segmentos1=7'b0000000;
				4'b1001: segmentos1=7'b0000100;
				default: segmentos1 = 7'b1111111;
			endcase
		end
end

always @(*)
begin
	if(output_flag)
		valor2 = (valor/10)%10;
		begin
			case (valor2)
				4'b0000: segmentos2=7'b0000001;
				4'b0001: segmentos2=7'b1001111;
				4'b0010: segmentos2=7'b0010010;
				4'b0011: segmentos2=7'b0000110;
				4'b0100: segmentos2=7'b1001100;
				4'b0101: segmentos2=7'b0100100;
				4'b0110: segmentos2=7'b0100000;
				4'b0111: segmentos2=7'b0001111;
				4'b1000: segmentos2=7'b0000000;
				4'b1001: segmentos2=7'b0000100;
				default: segmentos2 = 7'b1111111;
			endcase
		end
end

assign HEX1 = segmentos1;
assign HEX2 = segmentos2;


endmodule