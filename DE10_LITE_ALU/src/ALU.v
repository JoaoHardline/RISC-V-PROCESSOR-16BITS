module ALU
#(
parameter WIDTH = 4)
(
input [WIDTH-1:0] SrcA,
input [WIDTH-1:0] SrcB,
input [2:0] ALUControl,
output reg [WIDTH-1:0] ALUResult,
output reg Zero
);


always @(*)
    begin
        case(ALUControl)
        3'b000: // Addition
           ALUResult = SrcA + SrcB; 
        3'b001: // Subtraction
           ALUResult = SrcA - SrcB;
          3'b010: //  Logical and 
           ALUResult = SrcA & SrcB;
          3'b011: //  Logical or
           ALUResult = SrcA | SrcB;
          3'b101: // Greater comparison SLT
           ALUResult = (SrcA<SrcB)?8'b1:8'b0;
          default: ALUResult = SrcA + SrcB; 
        endcase
		  
		  Zero = (ALUResult == 0)?8'b1:8'd0;
		  
    end


endmodule