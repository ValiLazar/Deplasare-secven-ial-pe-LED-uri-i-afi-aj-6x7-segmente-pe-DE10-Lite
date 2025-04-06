 module deplasare_hex #(
	int DISPLAY_COUNT = 6 ,
	bit COMMON_ANODE = 1'b1,   // 1 = comună anodă, 0 = comună catodă
	int COL_WIDTH = $clog2(DISPLAY_COUNT)
 ) 
 (
	input row_i ,   // HIGH când urcă, LOW când coboară
	input [COL_WIDTH-1 : 0] col_i ,    // Poziția de afișare a display-ului
	output [DISPLAY_COUNT-1 : 0][7:0] seg7_o   // Segmentul afișat
 );

	reg [DISPLAY_COUNT-1 : 0] col_en;   

	assign col_en = 1 << col_i;   
// Generare a modulelor de afișaje 7-segment
genvar i;
generate
	for (i=0; i<DISPLAY_COUNT; i++) begin: SEG7
		model_hex_7seg #(
			.COMMON_ANODE ( COMMON_ANODE ))
	   single_display_inst (
			.row_i ( row_i ),
			.en_i ( col_en[i] ),
			.seg7_o ( seg7_o[i] )
 );
 end
 endgenerate

 endmodule
 