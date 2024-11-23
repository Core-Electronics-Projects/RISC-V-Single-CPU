// data_mem.v - data memory
module data_mem #(parameter DATA_WIDTH = 32, ADDR_WIDTH = 32, MEM_SIZE = 64) (
    input       clk, wr_en,
    input [2:0] funct3,
    input       [ADDR_WIDTH-1:0] wr_addr, wr_data,
    output reg  [DATA_WIDTH-1:0] rd_data_mem
);

// Array of 64 32-bit words (memory)
reg [DATA_WIDTH-1:0] data_ram [0:MEM_SIZE-1];

// Word address (aligned access)
wire [ADDR_WIDTH-1:0] word_addr = wr_addr[DATA_WIDTH-1:2] % 64;

// Pre-calculated shifted values for reads and writes
wire [7:0] selected_byte = data_ram[word_addr] >> (wr_addr[1:0] * 8);
wire [15:0] selected_halfword = data_ram[word_addr] >> (wr_addr[1] * 16);

// Synchronous write logic
always @(posedge clk) begin
    if (wr_en) begin 
        case(funct3)
            3'b000: begin // sb (store byte)
                // Mask and store byte
                data_ram[word_addr] <= (data_ram[word_addr] & ~(32'hFF << (wr_addr[1:0] * 8))) | 
                                       ((wr_data & 8'hFF) << (wr_addr[1:0] * 8));
            end
            3'b001: begin // sh (store half-word)
                // Mask and store half-word
                data_ram[word_addr] <= (data_ram[word_addr] & ~(32'hFFFF << (wr_addr[1] * 16))) | 
                                       ((wr_data & 16'hFFFF) << (wr_addr[1] * 16));
            end
            3'b010: begin // sw (store word)
                // Store entire word
                data_ram[word_addr] <= wr_data;
            end
        endcase
    end
end

// Combinational read logic
always @(*) begin
    case(funct3)
        3'b000: begin // lb (load byte, sign-extended)
            // Sign-extend selected byte
            rd_data_mem = {{24{selected_byte[7]}}, selected_byte};
        end
        3'b001: begin // lh (load halfword, sign-extended)
            // Sign-extend selected half-word
            rd_data_mem = {{16{selected_halfword[15]}}, selected_halfword};
        end
        3'b100: begin // lbu (load byte, zero-extended)
            // Zero-extend selected byte
            rd_data_mem = {24'b0, selected_byte};
        end
        3'b101: begin // lhu (load halfword, zero-extended)
            // Zero-extend selected half-word
            rd_data_mem = {16'b0, selected_halfword};
        end
        3'b010: begin // lw (load word)
            // Load entire word
            rd_data_mem = data_ram[word_addr];
        end
        default: begin
            // Default safety case
            rd_data_mem = 32'b0;
        end
    endcase
end

endmodule
