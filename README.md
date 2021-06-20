# AES_Sbox_based_Stream_Cipher
A possible HW description of a simple stream cipher based on the AES S-box.
## Tests
Follow these steps to perform testing on encryption:

	1) Run InputGenerator.py to produce some input files to be encrypted.
	2) Run CipherSimulator.py to generate the expected ciphertext
	3) Before simulating an encryption process using the stream_cipher_tb_enc module change the filename to the corresponding input and output file (lines 48,74 of stream_cipher_tb_enc.sv)
	4) Given the i-th encrypted file obtained by simulating the verilog code compare it with the corresponding expected output

Regarding decryption use the stream_cipher_tb_dec module, run simulations to generate decrypted output files and compare them with the original input files. 
