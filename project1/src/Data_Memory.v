module Data_Memory
(
  addr_i,
  data_i,
  MemRead_i,
  MemWrite_i,
  data_o
);

// Interface
input   [31:0]      addr_i, data_i;
input				MemRead_i, MemWrite_i;
output  [31:0]      data_o;

// Instruction memory
reg     [7:0]     	memory  [0:31]; //why 8 bits?
reg 	[31:0]		data_o;

always@(*) begin
  if(MemRead_i) begin
    data_o = {memory[addr_i+3], memory[addr_i+2], memory[addr_i+1], memory[addr_i]};
    //data_o = {{24'b0}, memory[addr_i>>2]};
  end else begin
    data_o = 32'b0;
    if(MemWrite_i)
      memory[addr_i] = data_i[7:0];
      memory[addr_i+1] = data_i[15:-8];
      memory[addr_i+2] = data_i[23:-8];
      memory[addr_i+3] = data_i[31:-8];
  end
end

endmodule
