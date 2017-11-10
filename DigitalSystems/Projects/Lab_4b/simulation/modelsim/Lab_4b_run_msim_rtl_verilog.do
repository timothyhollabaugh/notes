transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+/home/tim/Rowan/DigitalSystems/Projects/Lab_4b {/home/tim/Rowan/DigitalSystems/Projects/Lab_4b/seven_seg.v}
vlog -vlog01compat -work work +incdir+/home/tim/Rowan/DigitalSystems/Projects/Lab_4b {/home/tim/Rowan/DigitalSystems/Projects/Lab_4b/Lab_4b.v}

vlog -vlog01compat -work work +incdir+/home/tim/Rowan/DigitalSystems/Projects/Lab_4b {/home/tim/Rowan/DigitalSystems/Projects/Lab_4b/Test.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneiii_ver -L rtl_work -L work -voptargs="+acc"  Test

add wave *
view structure
view signals
run -all
