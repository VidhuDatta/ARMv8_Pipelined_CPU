`timescale 1ns/10ps
module Full_Adder (a,b,Carryin,sum,Carryout);
input a,b,Carryin;
output sum,Carryout;

xor #0.05 x1(sum, a, b, Carryin); //sum output

and #0.05 a1(w2, a, b);
and #0.05 a2(w3, b, Carryin);
and #0.05 a3(w4, Carryin, a);

or #0.05 o1(Carryout,w2,w3,w4);     //carry output

endmodule