module full_adder_4bit (
    input [3:0] A,
    input [3:0] B,
    input Cin,
    output [3:0] Sum,
    output Cout
);
    wire c1, c2, c3; // Internal wires (fan-out points)
    // 1-bit Adder instances (Logic Depth increases here)
    full_adder fa0 (A[0], B[0], Cin, Sum[0], c1);
    full_adder fa1 (A[1], B[1], c1,  Sum[1], c2);
    full_adder fa2 (A[2], B[2], c2,  Sum[2], c3);
    full_adder fa3 (A[3], B[3], c3,  Sum[3], Cout);
endmodule
module full_adder (
    input a, b, cin,
    output sum, cout
);
    wire w1, w2, w3;
    // Gate level primitives (Node count)
    xor g1 (w1, a, b);
    xor g2 (sum, w1, cin);
    and g3 (w2, w1, cin);
    and g4 (w3, a, b);
    or  g5 (cout, w2, w3);
endmodule