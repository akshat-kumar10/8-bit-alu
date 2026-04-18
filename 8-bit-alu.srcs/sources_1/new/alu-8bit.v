`timescale 1ns / 1ps

module alu_8bit (
    input  wire [7:0] a,       // 8-bit operand A
    input  wire [7:0] b,       // 8-bit operand B
    input  wire [2:0] alu_op,  // 3-bit operation selector
    output reg  [7:0] result,  // 8-bit result
    output wire       zero,    // Zero flag
    output reg        carry    // Carry/Borrow flag
);

    // Continuous assignment for the Zero flag
    assign zero = (result == 8'b00000000);

    // Temporary 9-bit register to capture carry-out bits during arithmetic
    reg [8:0] temp_result;

    always @(*) begin
        // Default assignments to prevent latches
        temp_result = 9'b0;
        carry       = 1'b0;
        result      = 8'b0;

        case(alu_op)
            3'b000: begin // ADD
                temp_result = a + b;
                result      = temp_result[7:0];
                carry       = temp_result[8];
            end
            
            3'b001: begin // SUBTRACT (A - B)
                temp_result = a - b;
                result      = temp_result[7:0];
                carry       = temp_result[8]; // Acts as a borrow flag
            end
            
            3'b010: begin // BITWISE AND
                result = a & b;
            end
            
            3'b011: begin // BITWISE OR
                result = a | b;
            end
            
            3'b100: begin // BITWISE XOR
                result = a ^ b;
            end
            
            3'b101: begin // BITWISE NOT (Invert A)
                result = ~a;
            end
            
            3'b110: begin // SHIFT LEFT LOGICAL (A << 1)
                temp_result = {1'b0, a} << 1;
                result      = temp_result[7:0];
                carry       = a[7]; // The bit shifted out becomes the carry
            end
            
            3'b111: begin // SHIFT RIGHT LOGICAL (A >> 1)
                result = a >> 1;
                carry  = a[0]; // The bit shifted out becomes the carry
            end
            
            default: begin
                result = 8'b0;
                carry  = 1'b0;
            end
        endcase
    end

endmodule