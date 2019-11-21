#!/bin/bash 

reset

gnuplot -persist <<-EOFMarker

	#set term pdf font "Helvetica,16" enhanced
	set terminal postscript color

	#set title "Recognition Time" font ", 40"
	set xlabel "Observation Length" font ", 17"
	set ylabel "Recognition Time (s)" font ", 17"

	set ytics font ", 20"
	set xtics font ", 20"

	set key font ",18"
	set key top left

	set out "recognition_time_uniqueness_noisy.eps"

	plot 'recognition_time_noisy.txt' using 1:2 title 'Exhaust' with linesp smooth sbezier lc "red" lw 8,\
		'' using 1:3 title 'h^m' with linesp smooth sbezier lc "blue" lw 8,\
		'' using 1:4 title 'RHW' with linesp smooth sbezier lc "green" lw 8,\
		'' using 1:5 title 'Zhu/Givan' with linesp smooth sbezier lc "orange" lw 8,\
		'' using 1:6 title 'Hoffmann' with linesp smooth sbezier lc "dark-grey" lw 8

	# plot 'recognition_time_noisy.txt' using 1:2 title 'Exhaust' with linesp smooth sbezier lc "dark-red" lw 8,\
	# 	'' using 1:3 title 'h^m' with linesp smooth sbezier lc "dark-blue" lw 8,\
	# 	'' using 1:4 title 'RHW' with linesp smooth sbezier lc "dark-green" lw 8,\
	# 	'' using 1:5 title 'Zhu/Givan' with linesp smooth sbezier lc "dark-orange" lw 8,\
	# 	'' using 1:6 title 'Hoffmann' with linesp smooth sbezier lc "#424242" lw 8

EOFMarker