#!/bin/bash 
reset

gnuplot -persist <<-EOFMarker

    set terminal postscript color

    set xlabel "Observability" font ", 30"
    set ylabel "Accuracy/Spread" font ", 30"

    set ytics font ", 20"
    set xtics font ", 20"

    set key font ",18"
    set key top left

    set out "bar_graph.eps"

    set yrange [0:100]
    set style data histogram
    set style histogram cluster gap 1
    set style fill solid
    set boxwidth 0.9
    set xtics format ""
    set grid ytics

    plot "bar_graph.txt" using 2:xtic(1) title "Goal Completion with Exhaust" linecolor "red", \
                '' using 3 title "Goal Completion with h^m" linecolor "blue", \
                '' using 4 title "Goal Completion with RHW" linecolor "green", \
                '' using 5 title "Goal Completion with Zhu/Givan" linecolor "black", \
                '' using 6 title "Uniqueness with Exhaust" linecolor "pink", \
                '' using 7 title "Uniqueness with h^m" linecolor "dark-gray", \
                '' using 8 title "Uniqueness with RHW" linecolor "yellow", \
                '' using 9 title "Uniqueness with Zhu/Givan" linecolor "orange"
EOFMarker