module multiplier_3bit(
    input [2:0] A, 
    input [2:0] B, 
    output [5:0] P
);
    wire p00, p01, p02;
    wire p10, p11, p12;
    wire p20, p21, p22;
    wire c11, c12, c13;
    wire s12, s13;
    wire c21, c22, c23;
    // Partial Products (High Node Count)
    and g00(P[0], A[0], B[0]);
    and g01(p01, A[1], B[0]);
    and g02(p02, A[2], B[0]);
    and g10(p10, A[0], B[1]);
    and g11(p11, A[1], B[1]);
    and g12(p12, A[2], B[1]);
    and g20(p20, A[0], B[2]);
    and g21(p21, A[1], B[2]);
    and g22(p22, A[2], B[2]);
    // Adder Tree (Increases Logic Depth)
    half_adder ha1(p01, p10, P[1], c11);
    full_adder fa1(p02, p11, c11, s12, c12);
    half_adder ha2(s12, p20, P[2], c21);
    full_adder fa2(p12, p21, c12, P[3], c22);
    full_adder fa3(p22, c21, c22, P[4], P[5]); 
endmodule
// Helper Modules
module full_adder(input a, b, cin, output s, cout);
    wire w1, w2, w3;
    xor g1(w1, a, b);
    xor g2(s, w1, cin);
    and g3(w2, w1, cin);
    and g4(w3, a, b);
    or  g5(cout, w2, w3);
endmodule
module half_adder(input a, b, output s, c);
    xor g1(s, a, b);
    and g2(c, a, b);
endmodule