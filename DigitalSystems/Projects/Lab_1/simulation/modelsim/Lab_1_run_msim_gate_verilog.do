transcript on
if {[file exists gate_work]} {
	vdel -lib gate_work -all
}
vlib gate_work
vmap work gate_work

vlog -vlog01compat -work work +incdir+. {Lab_1_6_1200mv_85c_slow.vo}

vlog -vlog01compat -work work +incdir+/home/tim/Rowan/DigitalSystems/Projects/Lab_1 {/home/tim/Rowan/DigitalSystems/Projects/Lab_1/lab_1_testbench.v}

vsim -t 1ps +transport_int_delays +transport_path_delays -L altera_ver -L cycloneiii_ver -L gate_work -L work -voptargs="+acc"  lab_1_testbench

add wave *
view structure
view signals
run -all
