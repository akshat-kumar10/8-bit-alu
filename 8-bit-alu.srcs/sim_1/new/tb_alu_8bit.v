`timescale 1ns / 1ps

module tb_alu_8bit;

    // Inputs
    reg [7:0] a;
    reg [7:0] b;
    reg [2:0] alu_op;

    // Outputs
    wire [7:0] result;
    wire zero;
    wire carry;

    // Instantiate the Unit Under Test (UUT)
    alu_8bit uut (
        .a(a), 
        .b(b), 
        .alu_op(alu_op), 
        .result(result), 
        .zero(zero), 
        .carry(carry)
    );

    initial begin
        // Initialize Inputs
        a = 0;
        b = 0;
        alu_op = 0;

        // Wait 10 ns for global reset to finish
        #10;
        
        // Test 1: ADD (No Carry)
        a = 8'h0A; b = 8'h05; alu_op = 3'b000; #10;
        
        // Test 2: ADD (With Carry)
        a = 8'hFF; b = 8'h01; alu_op = 3'b000; #10;
        
        // Test 3: SUBTRACT
        a = 8'h10; b = 8'h05; alu_op = 3'b001; #10;
        
        // Test 4: BITWISE AND
        a = 8'hFF; b = 8'h0F; alu_op = 3'b010; #10;
        
        // Test 5: BITWISE OR
        a = 8'hF0; b = 8'h0F; alu_op = 3'b011; #10;
        
        // Test 6: BITWISE XOR
        a = 8'hAA; b = 8'h55; alu_op = 3'b100; #10;
        
        // Test 7: BITWISE NOT
        a = 8'h00; b = 8'h00; alu_op = 3'b101; #10;
        
        // Test 8: SHIFT LEFT
        a = 8'h81; b = 8'h00; alu_op = 3'b110; #10;
        
        // Test 9: SHIFT RIGHT
        a = 8'h81; b = 8'h00; alu_op = 3'b111; #10;

        // End simulation
        $finish;
    end
      
    // Optional: Monitor changes
    initial begin
        $monitor("Time=%0t | A=%h B=%h Op=%b | Res=%h Zero=%b Carry=%b", 
                 $time, a, b, alu_op, result, zero, carry);
    end

endmodule