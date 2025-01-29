module D_FF_Enable(
input d, enb, clk, reset,
output q);

// D-FF with an enable signal

mux2x1 mux(d_mux_out, enb, {d, q_internal});

D_FF dff(q_internal, d_mux_out, reset, clk);

assign q = q_internal;

endmodule