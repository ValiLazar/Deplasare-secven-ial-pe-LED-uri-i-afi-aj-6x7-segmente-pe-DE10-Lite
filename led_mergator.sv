module led_mergator #(
    parameter LED_COUNT = 10
)(
    input clk_i,
    input reset_ni,
    input enable,
    output reg [LED_COUNT-1:0] ledr   // LED-urile care vor fi afișate
);

reg directionLED;   
reg [LED_COUNT-1:0] next_ledr;   

always @(posedge clk_i or negedge reset_ni) begin
    if (!reset_ni) begin    
        directionLED <= 1;   
        ledr <= 0;
        next_ledr <= 0;
    end else if (enable) begin    
        if (directionLED) begin    //stanga
            if (ledr == 0)      
                next_ledr = 1;    
            else if (ledr[LED_COUNT-1])   
                directionLED <= 0;
            else
                next_ledr = ledr << 1;    
        end else begin
            if (ledr == 0)    //dreapta
                next_ledr = 1 << (LED_COUNT-1);
            else if (ledr[0])
                directionLED <= 1;
            else
                next_ledr = ledr >> 1;
        end
        ledr <= next_ledr;  // actualizare
    end
end

endmodule
