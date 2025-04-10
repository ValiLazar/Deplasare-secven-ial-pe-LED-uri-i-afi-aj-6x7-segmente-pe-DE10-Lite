 module model_hex_7seg #(
 bit COMMON_ANODE = 1'b1   
 ) (
 input row_i ,
 input en_i ,
 output [7:0] seg7_o
 );

 localparam HIGH_CIRCLE = 8'b0_1100011;   // sus
 localparam LOW_CIRCLE = 8'b0_1011100;    // jos
 localparam OFF = 8'b0_0000000;           // oprit

	// ===============================================
	// LOGICA DE CONTROL AFISARE 7 SEGMENTE MODEL CERC
	// ===============================================
 
 always_comb begin
 if (en_i)
	if (row_i)
		seg7_o = HIGH_CIRCLE;
	else
		seg7_o = LOW_CIRCLE;
	else
		seg7_o = OFF;
 if (COMMON_ANODE)
		seg7_o = ~seg7_o;
 end

 endmodule
 