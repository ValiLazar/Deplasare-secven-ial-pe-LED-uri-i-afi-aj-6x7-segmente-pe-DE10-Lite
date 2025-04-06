module deplasare_main(
    input clk_i,
    input reset_ni,
    input sw0,
    input sw1,
    output [9:0] ledr,
    output [7:0] HEX5, HEX4, HEX3, HEX2, HEX1, HEX0
);

    wire bLED, bHEX;
    wire [31:0] count;
    wire overflow_o;
    wire [5:0][7:0] seg7_o;

    wire [2:0] col_i;          // 3 biți pentru 6 poziții (0-5)
    wire direction;            // 0 = urcă, 1 = coboară

    // ========================
    // Instanțiere module
    // ========================

    butoane butoane_inst(
        .clk_i(clk_i),
        .reset_ni(reset_ni),
        .sw0(sw0),
        .sw1(sw1),
        .bLED(bLED),
        .bHEX(bHEX)
    );

    counter #(
        .WIDTH(32),
        .COUNT_TO(25000000)
    ) counter_inst(
        .clk_i(clk_i),
        .reset_ni(reset_ni),
        .enable(bLED || bHEX),
        .count(count),
        .overflow_o(overflow_o)
    );

    led_mergator #(
        .LED_COUNT(10)
    ) led_inst(
        .clk_i(clk_i),
        .reset_ni(reset_ni),
        .enable(overflow_o && bLED),
        .ledr(ledr)
    );

    hex_controller hex_ctrl_inst(
        .clk_i(clk_i),
        .reset_ni(reset_ni),
        .enable(overflow_o && bHEX),
        .col_i(col_i),
        .direction(direction)
    );

    deplasare_hex hex_inst(
        .row_i(direction), // HIGH când urcă, LOW când coboară
        .col_i(col_i),
        .seg7_o(seg7_o)
    );

    // ========================
    // Conectare HEX-uri
    // ========================
    assign HEX5 = seg7_o[5];
    assign HEX4 = seg7_o[4];
    assign HEX3 = seg7_o[3];
    assign HEX2 = seg7_o[2];
    assign HEX1 = seg7_o[1];
    assign HEX0 = seg7_o[0];
	 
	 //assign HEX5 = (col_i == 5) ? seg7_o[5] : 8'b00000000;
    //assign HEX4 = (col_i == 4) ? seg7_o[4] : 8'b00000000;
    //assign HEX3 = (col_i == 3) ? seg7_o[3] : 8'b00000000;
    //assign HEX2 = (col_i == 2) ? seg7_o[2] : 8'b00000000;
    //assign HEX1 = (col_i == 1) ? seg7_o[1] : 8'b00000000;
    //assign HEX0 = (col_i == 0) ? seg7_o[0] : 8'b00000000;
	 
	 //assign HEX5 = (col_i == 5) ? ~seg7_o[5] : 8'b11111111;
	 //assign HEX4 = (col_i == 4) ? ~seg7_o[4] : 8'b11111111;
	 //assign HEX3 = (col_i == 3) ? ~seg7_o[3] : 8'b11111111;
	 //assign HEX2 = (col_i == 2) ? ~seg7_o[2] : 8'b11111111;
	 //assign HEX1 = (col_i == 1) ? ~seg7_o[1] : 8'b11111111;
	 //assign HEX0 = (col_i == 0) ? ~seg7_o[0] : 8'b11111111;

endmodule
