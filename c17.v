module c17 (N1, N2, N3, N6, N7, N22, N23);
   input  N1, N2, N3, N6, N7;
   output N22, N23;
   wire   N10, N11, N16, N19;
   // ISCAS-85 c17 Topology
   nand NAND1 (N10, N1, N3);
   nand NAND2 (N11, N3, N6);
   nand NAND3 (N16, N2, N11);
   nand NAND4 (N19, N11, N7);
   nand NAND5 (N22, N10, N16);
   nand NAND6 (N23, N16, N19);
endmodule