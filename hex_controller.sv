module hex_controller (
    input clk_i,
    input reset_ni,
    input enable,   
    output reg [2:0] col_i,      
    output reg direction         // 0 = jos, 1 = sus
);

	// ===========================================================
	// GENERATOR CONTROL POZIȚIE AFISAJE HEX ȘI DIRECȚIE DEPLASARE
	// ===========================================================

    always @(posedge clk_i or negedge reset_ni) begin
        if (!reset_ni) begin
            col_i <= 0;
            direction <= 0; 
        end else if (enable) begin
            if (!direction) begin
                if (col_i == 5)
                    direction <= 1; 
                else
                    col_i <= col_i + 1; 
            end else begin
                if (col_i == 0)
                    direction <= 0; 
                else
                    col_i <= col_i - 1; 
            end
        end
    end
endmodule
