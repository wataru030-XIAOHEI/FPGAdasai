onbreak resume
onerror resume
vsim -novopt work.filter_tb
add wave sim:/filter_tb/u_filter_ammod/clk
add wave sim:/filter_tb/u_filter_ammod/clk_enable
add wave sim:/filter_tb/u_filter_ammod/reset
add wave sim:/filter_tb/u_filter_ammod/filter_in
add wave sim:/filter_tb/u_filter_ammod/filter_out
add wave sim:/filter_tb/filter_out_ref
run -all
