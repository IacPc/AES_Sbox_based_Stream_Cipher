module aes_sbox_stream_cipher (
   input            clk
  ,input            rst_n	  // reset signal, active low
  ,input            din_valid     //1'b1 used to notify input character validity, normally 1'b0 
  ,input      [7:0] simmetric_key 
  ,input      [7:0] txt_in_char
  ,output reg [7:0] txt_out_char
  ,output reg [0:0] dout_ready	  //1'b1 used to notify input character validity, normally 1'b0
);

  // ---------------------------------------------------------------------------
  // State Variables
  // ---------------------------------------------------------------------------
  
  localparam S0 = 2'b00;
  localparam S1_INIT = 2'b01;
  localparam S1 = 2'b11;
  localparam S2 = 2'b10;

  // ---------------------------------------------------------------------------
  // Logic wires driving inner circuits
  // ---------------------------------------------------------------------------
  
  wire [7:0] sbox_out;
  wire [7:0] sbox_in;
  wire [7:0] xor_out;
  wire [7:0] txt_xor_in;

  // ---------------------------------------------------------------------------
  // Registers
  // ---------------------------------------------------------------------------
  
  reg [7:0] counter_out;  //key register
  reg [7:0] txt_in;
  reg [1:0] star;         //status register


  sbox_lut SBOX(
    .lut_in  (sbox_in)
   ,.lut_out (sbox_out)
  );
  
  // ---------------------------------------------------------------------------
  // Logic Design
  // ---------------------------------------------------------------------------
  
  assign txt_xor_in = txt_in;
  assign sbox_in = counter_out;
  assign xor_out = sbox_out ^ txt_xor_in;

  always @ (posedge clk or negedge rst_n)
    if(!rst_n) begin
      dout_ready <= 1'b0;
      star <= S0; 
      txt_in <= 8'h00;
      counter_out <= 8'h00;
      txt_out_char <= 8'h00;
    end
    else begin
      case(star)
          S0: 
            begin
              star <= S1_INIT;
              dout_ready  <= 1'b0;
              txt_in <= 8'h00;
              counter_out <= 8'h00;
              txt_out_char <= 8'h00;
            end
          S1_INIT: 
            begin
              star <= (din_valid == 1'b1) ? S2 : S1_INIT;
              dout_ready  <= 1'b0;
              txt_in <= (din_valid == 1'b1) ? txt_in_char : 8'h00;
              counter_out <= (din_valid == 1'b1) ? simmetric_key : 8'h00;
              txt_out_char <= 8'h00;
            end    
          S1: 
            begin
              star <= (din_valid == 1'b1) ? S2 : S1;
              dout_ready  <= 1'b0;
              txt_in <= (din_valid == 1'b1) ? txt_in_char : 8'h00;
              counter_out <= (din_valid == 1'b1) ? counter_out + 8'h01 : counter_out;
              txt_out_char <= 8'h00;
            end
          S2: 
            begin
              star <= (din_valid == 1'b1) ? S2 : S1;
              dout_ready  <= 1'b1;
              txt_in <= (din_valid == 1'b1) ? txt_in_char : 8'h00;
              counter_out <= (din_valid == 1'b1) ? counter_out + 8'h01 : counter_out;
              txt_out_char <= xor_out;
            end       
      endcase // star
  
    end  
      
endmodule


