// fifo.sv
// Implements delay buffer (fifo)
// On reset all entries are set to 0
// Shift causes fifo to shift out oldest entry to q, shift in d

module fifo
  #(
  parameter DEPTH=8,
  parameter BITS=64
  )
  (
  input clk,rst_n,en,
  input [BITS-1:0] d,
  output [BITS-1:0] q
  );


  //REGISTERS
  reg [DEPTH*BITS - 1: 0] fifo_register; 
  
  //q is always the latest item in the register
  assign q = fifo_register[BITS-1:0];

  always_ff @ (posedge clk, negedge rst_n) begin
    if (!rst_n) fifo_register[DEPTH*BITS-1:0] <= 0;
    else if (en)
      //Shift out the first entry and shift in q
      fifo_register[DEPTH*BITS-1:0] <= {d,fifo_register[BITS*DEPTH-1:BITS]};
  end

endmodule // fifo
