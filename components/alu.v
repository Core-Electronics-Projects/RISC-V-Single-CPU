// alu.v - ALU module with 4-bit ALU control

module alu #(parameter WIDTH = 32) (
    input       [WIDTH-1:0] a, b,       // operands
    input       [3:0] alu_ctrl,         // ALU control (now 4 bits)
    output reg  [WIDTH-1:0] alu_out,    // ALU output
    output      zero                    // zero flag
);

always @(a, b, alu_ctrl) begin
    case (alu_ctrl)
        4'b0000:  alu_out <= a + b;       // ADD, ADDI
        4'b0001:  alu_out <= a + ~b + 1;  // SUB
        4'b0010:  alu_out <= a & b;       // AND, ANDI
        4'b0011:  alu_out <= a | b;       // OR, ORI
        4'b0100:  alu_out <= a ^ b;       // XOR, XORI
        
        4'b0101:  alu_out <= a << b[4:0]; // SLL, SLLI (Shift Left Logical)
        4'b0110:  alu_out <= a >> b[4:0]; // SRL, SRLI (Shift Right Logical)
        4'b0111:  alu_out <= $signed(a) >>> b[4:0]; // SRA, SRAI (Shift Right Arithmetic)
        
        4'b1000:  alu_out <= ($signed(a) < $signed(b)) ? 1 : 0; // SLT, SLTI (Set Less Than Signed)
        4'b1001: begin                   // SLTU / SLTIU
                     if (a[31] != b[31]) alu_out <= a[31] ? 0 : 1;
                     else alu_out <= a < b ? 1 : 0;
                 end
        
        default:  alu_out <= 0;  // Default case
    endcase
end

assign zero = (alu_out == 0) ? 1'b1 : 1'b0;

endmodule
