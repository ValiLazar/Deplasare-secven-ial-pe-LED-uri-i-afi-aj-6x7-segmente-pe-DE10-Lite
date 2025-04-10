 module deplasare_hex #(
	int DISPLAY_COUNT = 6 ,
	bit COMMON_ANODE = 1'b1,  // comună anodă
	int COL_WIDTH = $clog2(DISPLAY_COUNT)
 )
 (
	input row_i ,   // HIGH când dirction = 1, LOW când direction = 0
	input [COL_WIDTH-1 : 0] col_i ,    // Poziția de afișare a display-ului
	output [DISPLAY_COUNT-1 : 0][7:0] seg7_o   // Segmentul afișat
 );

	reg [DISPLAY_COUNT-1 : 0] col_en;   

	assign col_en = 1 << col_i;   

	// ===============================================
	// CONTROL DEPLASARE AFISAJE 7 SEGMENTE MODEL CERC
	// ===============================================
	
	genvar i;
	generate
		for (i=0; i<DISPLAY_COUNT; i++) begin: SEG7
			model_hex_7seg #(
				.COMMON_ANODE ( COMMON_ANODE ))
			single_display_inst (
				.row_i ( row_i ),
				.en_i ( col_en[i] ),
			.	seg7_o ( seg7_o[i] )
			);
		end
	endgenerate

 endmodule
 