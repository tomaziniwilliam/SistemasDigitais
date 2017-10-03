module piscaleds(
		input CLOCK_50,
		input [3:0] KEY, //botoes
		output [7:0]LEDG //leds verde
		
	);

	reg [25:0] contador = 0;
	reg [7:0] l = 0;
	reg [3:0] cont = 1;

	assign LEDG = l;

	always @(posedge CLOCK_50) begin
		contador = contador + cont;
		if(contador == 50000000) begin
			contador = 0;
			l = ~l;
		end
		
		if(KEY == 14) begin
			contador = 0;
			cont = 1;
		end

		if(KEY == 13) begin
			contador = 0;
			cont = 2;
		end

		if(KEY == 11) begin
			contador = 0;
			cont = 4;
		end

		if(KEY == 7) begin
			contador = 0;
			cont = 8;
		end
	end
endmodule 
