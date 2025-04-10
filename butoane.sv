module butoane(
    input clk_i,
    input reset_ni,
    input sw0,
    input sw1,
    output reg bLED,
    output reg bHEX
);


	// ======================================
	// ATRIBUIRE SEMNALE BUTOANE CĂTRE IEȘIRI
	// ======================================

always @(posedge clk_i or negedge reset_ni) begin
    if (!reset_ni) begin
        bLED <= 0;
        bHEX <= 0;
    end else begin
        bLED <= sw0;
        bHEX <= sw1;
    end
end

endmodule
