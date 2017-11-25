module sinal (

    input [11:0] Ponto1X,
    input [11:0] Ponto1Y,

    input [11:0] Ponto2X,
    input [11:0] Ponto2Y,

    input [11:0] PontoTX,
    input [11:0] PontoTY,

    output sinal

    );

    // DECLARAÇÃO DOS FIOS
    wire signed [11:0] Subtracao1;
    wire signed [11:0] Subtracao2;
    wire signed [11:0] Subtracao3;
    wire signed [11:0] Subtracao4;

    wire signed [22:0] Multiplicacao1;
    wire signed [22:0] Multiplicacao2;

    wire signed [22:0] Subtracao5; // comparador


    // LIGAÇÃO DOS FIOS

    assign Subtracao1 = PontoTX - Ponto2Y;
    assign Subtracao2 = Ponto1Y - Ponto2Y;
    assign Subtracao3 = Ponto1X - Ponto2X;
    assign Subtracao4 = PontoTY - Ponto2Y;

    assign Multiplicacao1 = Subtracao1 * Subtracao2;
    assign Multiplicacao2 = Subtracao3 * Subtracao4;

    assign Subtracao5 = Multiplicacao1 - Multiplicacao2;

    assign sinal = (Subtracao5 >= 0) ? 1 : 0; //==== VERIFICA SE O RESULTADO DA ULTIMA MULTIPLICAÇÃO É MAIOR OU IGUAL A ZERO E RETORNA O SINAL 1 OU 0.

endmodule


module TesteTriangulo (
    input [11:0] Ponto1X,
    input [11:0] Ponto1Y,

    input [11:0] Ponto2X,
    input [11:0] Ponto2Y,

    input [11:0] Ponto3X,
    input [11:0] Ponto3Y,

    input [11:0] PontoTX,
    input [11:0] PontoTY,

    output dentro
    );

    wire sinal1;
    wire sinal2;
    wire sinal3;

    assign dentro = (sinal1 == 1 && sinal2 == 1 && sinal3 == 1) ? 1:0;

    sinal S1(Ponto1X, Ponto1Y, Ponto2X, Ponto2Y, PontoTX, PontoTY, sinal1);
    sinal S2(Ponto2X, Ponto2Y, Ponto3X, Ponto3Y, PontoTX, PontoTY, sinal2);
    sinal S3(Ponto3X, Ponto3Y, Ponto1X, Ponto1Y, PontoTX, PontoTY, sinal3);

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

    initial
        begin
           $dumpvars(0,A);
           #1

           Ponto1X <= 10;
           Ponto1Y <= 10;
           Ponto2X <= 30;
           Ponto2Y <= 10;
           Ponto3X <= 20;
           Ponto3Y <= 30;
           PontoTX <= 15;
           PontoTY <= 15;

           #1
           PontoTX <= 15;
           PontoTY <= 15;
           #1
           PontoTX <= 9;
           PontoTY <= 15;
           #1
           PontoTX <= 10;
           PontoTY <= 11;
           #1
           PontoTX <= 30;
           PontoTY <= 11;
           #40
           $finish;
        end
endmodule
