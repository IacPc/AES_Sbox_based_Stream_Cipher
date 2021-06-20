onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /stream_cipher_tb_enc/clk
add wave -noupdate /stream_cipher_tb_enc/rst_n
add wave -noupdate /stream_cipher_tb_enc/CIPHER/star
add wave -noupdate /stream_cipher_tb_enc/din_valid
add wave -noupdate -radix hexadecimal /stream_cipher_tb_enc/symmetric_key
add wave -noupdate -radix ascii /stream_cipher_tb_enc/txt_in_char
add wave -noupdate -radix ascii /stream_cipher_tb_enc/CIPHER/txt_in
add wave -noupdate /stream_cipher_tb_enc/dout_ready
add wave -noupdate -radix hexadecimal /stream_cipher_tb_enc/txt_out_char
TreeUpdate [SetDefaultTree]
WaveRestoreCursors
quietly wave cursor active 0
configure wave -namecolwidth 259
configure wave -valuecolwidth 58
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {179 ps}
