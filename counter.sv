module counter #(
    parameter WIDTH = 32,
    parameter COUNT_TO = 25000000
)(
    input clk_i,
    input reset_ni,
    input enable,
    output reg [WIDTH-1:0] count,
    output reg overflow_o
);

always @(posedge clk_i or negedge reset_ni) begin
    if (!reset_ni) begin
        count <= 0;
        overflow_o <= 0;

    end else if (enable) begin  // enable = 1 când unul din cele două butoane este apăsat
        
        if (count == COUNT_TO) begin
            count <= 0;
            overflow_o <= 1;
        end else begin
            count <= count + 1;
            overflow_o <= 0;
        end
    end else begin
        count <= 0;
        overflow_o <= 0;
    end
end

endmodule
