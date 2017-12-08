module VGA(
 input CLOCK_50,
 output [3:0] VGA_R,
 output [3:0] VGA_G,
 output [3:0] VGA_B,
 output [3:0] LEDG,
 output VGA_HS,
 output VGA_VS
);


reg [30:0] h_count = 0;
reg [30:0] v_count = 0;

reg [3:0] R;
reg [3:0] G;
reg [3:0] B;

assign LEDG = 4'b1111;

assign VGA_HS = ~(h_count < 190);
assign VGA_VS = ~(v_count < 2);

wire [12:0] x;
wire [12:0] y;

assign x = h_count - 285;
assign y = v_count - 35;

wire q = (x > 0) & (x < 1300) & (y > 0) & (y < 505);

wire [11:0] Ponto1X = 200;
wire [11:0] Ponto1Y = 100;

wire [11:0] Ponto2X = 500;
wire [11:0] Ponto2Y = 300;

wire [11:0] Ponto3X = 500;
wire [11:0] Ponto3Y = 100;

wire [11:0] PontoTX;
wire [11:0] PontoTY;

assign PontoTX = x;
assign PontoTY = y;

wire Dentro;

TesteTriangulo A(Ponto1X, Ponto1Y, Ponto2X, Ponto2Y, Ponto3X, Ponto3Y, PontoTX, PontoTY, Dentro);

wire visible;
assign visible = (v_count > 35) & (v_count < 515) & (h_count > 285) & (h_count < 1505);


assign VGA_R = visible ? R : 0;
assign VGA_G = visible ? G : 0;
assign VGA_B = visible ? B : 0;

always @(posedge CLOCK_50) begin
 if(h_count == 1585) begin
 h_count <= 0;
 if(v_count == 525) begin
 v_count <= 0;
 end
 else begin
 v_count <= v_count + 1;
 end
 end
 else begin
 h_count <= h_count + 1;
 end
end
always@(*) begin
	if(Dentro) begin
	R <= 4'hf;
	G <= 4'h0;
	B <= 4'h0;
	end
	else begin
	R <= 4'hf;
	G <= 4'hf;
	B <= 4'hf;
	end
end

endmodule

module sinal (

 input [11:0] Ponto1X,
 input [11:0] Ponto1Y,

 input [11:0] Ponto2X,
 input [11:0] Ponto2Y,

 input [11:0] PontoTX,
 input [11:0] PontoTY,

 output Dentro

 );

 // Declaração dos Fios
 wire signed [11:0] Subtracao1;
 wire signed [11:0] Subtracao2;
 wire signed [11:0] Subtracao3;
 wire signed [11:0] Subtracao4;

 wire signed [22:0] Multiplicacao1;
 wire signed [22:0] Multiplicacao2;

 wire signed [22:0] Subtracao5; // comparador


 // Ligação dos Fios

 assign Subtracao1 = PontoTX - Ponto2Y;
 assign Subtracao2 = Ponto1Y - Ponto2Y;
 assign Subtracao3 = Ponto1X - Ponto2X;
 assign Subtracao4 = PontoTY - Ponto2Y;

 assign Multiplicacao1 = Subtracao1 * Subtracao2;
 assign Multiplicacao2 = Subtracao3 * Subtracao4;

 assign Subtracao5 = Multiplicacao1 - Multiplicacao2;

 assign sinal = (Subtracao5 >= 0) ? 1 : 0; //==== Verifica se o resultado da ultima multiplicação é maior ou igual a zero e retornar o sinal 1 ou 0.

endmodule


module TesteTriangulo (
 input [11:0] Ponto1X,
 input [11:0] Ponto1Y,

 input [11:0] Ponto2X,
 input [11:0] Ponto2Y,

 input [11:0] Ponto3X,
 input [11:0] Ponto3Y,

 input [11:0] PontoTX, // x
 input [11:0] PontoTY, // y

 output dentro
 );

 wire sinal1;
 wire sinal2;
 wire sinal3;

 sinal S1(Ponto1X, Ponto1Y, Ponto2X, Ponto2Y, PontoTX, PontoTY, sinal1);
 sinal S2(Ponto2X, Ponto2Y, Ponto3X, Ponto3Y, PontoTX, PontoTY, sinal2);
 sinal S3(Ponto3X, Ponto3Y, Ponto1X, Ponto1Y, PontoTX, PontoTY, sinal3);

 assign dentro = (sinal1 == 1 && sinal2 == 1 && sinal3 == 1) ? 1:0;
endmodule

module Teste;
 reg [11:0] Ponto1X;
 reg [11:0] Ponto1Y;

 reg [11:0] Ponto2X;
 reg [11:0] Ponto2Y;

 reg [11:0] Ponto3X;
 reg [11:0] Ponto3Y;

 reg [11:0] PontoTX;
 reg [11:0] PontoTY;

 wire Dentro;

 TesteTriangulo A(Ponto1X, Ponto1Y, Ponto2X, Ponto2Y, Ponto3X, Ponto3Y, PontoTX, PontoTY, Dentro);

endmodule
