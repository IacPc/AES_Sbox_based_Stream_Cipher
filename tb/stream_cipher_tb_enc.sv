// -----------------------------------------------------------------------------
// Testbench of AES Sbox based stream cipher module
// -----------------------------------------------------------------------------

// -----------------------------------------------------------------------------
// Testbench for file encryption
// -----------------------------------------------------------------------------
module stream_cipher_tb_enc;

  reg clk = 1'b0;
  always #5 clk = !clk;

  reg rst_n = 1'b0;
  event reset_deassertion;

  initial begin
    #12.8 rst_n = 1'b1;
    -> reset_deassertion;
  end

  reg 	     din_valid;
  reg  [7:0] symmetric_key;
  reg  [7:0] txt_in_char;
  wire [7:0] txt_out_char;
  wire       dout_ready;

  aes_sbox_stream_cipher CIPHER (
     .clk                       (clk)
    ,.rst_n                     (rst_n)
    ,.din_valid                 (din_valid)
    ,.simmetric_key             (symmetric_key)
    ,.txt_in_char               (txt_in_char)
    ,.txt_out_char              (txt_out_char)
    ,.dout_ready                (dout_ready)
  );

  localparam UPPERCASE_A_CHAR = 8'h41;
  localparam UPPERCASE_Z_CHAR = 8'h5A;
  localparam LOWERCASE_A_CHAR = 8'h61;
  localparam LOWERCASE_Z_CHAR = 8'h7A;
  localparam INPUTFILE = "input0.txt";
  localparam ENCRIPTEDFILE = "enc0.txt";
  localparam DECRIPTEDFILE = "dec0.txt";

  int FP_PTXT;
  int FP_CTXT;
  string char;
  reg [7:0] CTXT [$];
  reg [7:0] PTXT [$];

  initial begin
    @(reset_deassertion);

    @(posedge clk);
    FP_PTXT = $fopen("../db/test/input0.txt", "r");
    $write("Encrypting file 'input0.txt' to 'ouput0.txt' ...");

    while($fscanf(FP_PTXT, "%c", char) == 1) begin
      txt_in_char = int'(char);
      din_valid = int'(1);
      symmetric_key = 8'h12;
      @(posedge clk);
      if(
        ((txt_in_char >= UPPERCASE_A_CHAR ) && (txt_in_char <= UPPERCASE_Z_CHAR)) ||
        ((txt_in_char >= LOWERCASE_A_CHAR ) && (txt_in_char <= LOWERCASE_Z_CHAR)) 
      ) begin
        CTXT.push_back(txt_out_char);
        $display("%b", txt_out_char);
      end
      else
        CTXT.push_back(txt_in_char);
    end

    din_valid = int'(0);
    @(posedge clk);
    $fclose(FP_PTXT);

    FP_CTXT = $fopen("../db/test/enc0.txt", "wb");
    foreach(CTXT[i])
    $fwrite(FP_CTXT, "%c", CTXT[i]);
    $fclose(FP_CTXT);

    $display("Encryption completed");
/*
    @(posedge clk);
    FP_CTXT = $fopen("../db/test/enc0.txt" , "r");
    $write("Decrypting file 'enc0.txt' to 'dec0.txt'... ");

    while($fscanf(FP_CTXT, "%c", char) == 1) begin
      txt_in_char = int'(char);
      din_valid = int'(1);
      symmetric_key = int'(1);
      @(posedge clk);
      if(
        ((txt_in_char >= UPPERCASE_A_CHAR ) && (txt_in_char <= UPPERCASE_Z_CHAR)) ||
        ((txt_in_char >= LOWERCASE_A_CHAR ) && (txt_in_char <= LOWERCASE_Z_CHAR))
      ) begin
        PTXT.push_back(txt_out_char);
        $display("%c", txt_out_char);
      end
      else
        PTXT.push_back(txt_in_char);
    end

    din_valid = int'(0);
    @(posedge clk);

    $fclose(FP_CTXT);

    FP_PTXT = $fopen("../db/test/enc0.txt" , "w");
    foreach(PTXT[i])
      $fwrite(FP_PTXT, "%c", PTXT[i]);
    $fclose(FP_PTXT);

    $display("Decryption completed");
*/
    $stop;
  end

endmodule
// -----------------------------------------------------------------------------

