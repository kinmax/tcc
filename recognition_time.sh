#!/usr/bin/env gnuplot

reset

#set term pdf font "Helvetica,16" enhanced
set terminal postscript color

#set title "Recognition Time" font ", 40"
set xlabel "Observation Length" font ", 30"
set ylabel "Recognition Time (s)" font ", 30"

set ytics font ", 20"
set xtics font ", 20"

set key font ",18"
set key top left

set out "missing-recognition_time.eps"

plot 'recognition_time.txt' using 1:2 title 'Goal Completion with Exhaust' with linesp smooth sbezier lc "blue" lw 5,\
	'recognition_time.txt' using 1:3 title 'Goal Completion with h^m' with linesp smooth sbezier lc "red" lw 5,\
	'recognition_time.txt' using 1:4 title 'Goal Completion with RHW' with linesp smooth sbezier lc "black" lw 5,\
	'recognition_time.txt' using 1:5 title 'Goal Completion with Zhu/Givan' with linesp smooth sbezier lc "dark-gray" lw 5,\
	'recognition_time.txt' using 1:6 title 'Uniqueness with Exhaust' with linesp smooth sbezier lc "yellow" lw 5,\
	'recognition_time.txt' using 1:7 title 'Uniqueness with h^m' with linesp smooth sbezier lc "green" lw 5,\
	'recognition_time.txt' using 1:8 title 'Uniqueness with RHW' with linesp smooth sbezier lc "pink" lw 5,\
	'recognition_time.txt' using 1:9 title 'Uniqueness with Zhu/Givan' with linesp smooth sbezier lc "orange" lw 5