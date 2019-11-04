#!/usr/bin/env gnuplot

reset

#set term pdf font "Helvetica,16" enhanced
set terminal postscript color

#set title "Recognition Time" font ", 40"
set xlabel "Observation Length" font ", 30"
set ylabel "Recognition Time (s)" font ", 30"

set ytics font ", 20"
set xtics font ", 20"

set key font ",25"
set key top left

set out "missing-recognition_time.eps"

plot 'recognition_time.txt' using 1:2 title 'Exhaust' with linesp smooth sbezier lc "blue" lw 10,\
	'recognition_time.txt' using 1:3 title 'h^m' with linesp smooth sbezier lc "red" lw 10,\
	'recognition_time.txt' using 1:4 title 'RHW' with linesp smooth sbezier lc "black" lw 10,\
	'recognition_time.txt' using 1:5 title 'Zhu/Givan' with linesp smooth sbezier lc "dark-gray" lw 10