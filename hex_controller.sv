module hex_controller (
    input clk_i,
    input reset_ni,
    input enable,   
    output reg [2:0] col_i,      // 3 biți pentru 6 poziții (0-5)
    output reg direction          // 0 = urcă, 1 = coboară
);

    always @(posedge clk_i or negedge reset_ni) begin
        if (!reset_ni) begin
            col_i <= 0;
            direction <= 0; // începem cu urcarea
        end else if (enable) begin
            if (!direction) begin
                if (col_i == 5)
                    direction <= 1; // schimbă direcția la 5
                else
                    col_i <= col_i + 1; // urcă
            end else begin
                if (col_i == 0)
                    direction <= 0; // schimbă direcția la 0
                else
                    col_i <= col_i - 1; // coboară
            end
        end
    end
endmodule
