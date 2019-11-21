#!/bin/bash 
reset

gnuplot -persist <<-EOFMarker

    set terminal postscript color

    set xlabel "Algorithms" font ", 17"
    set ylabel "Landmark Percentage" font ", 17"

    set ytics font ", 20"
    set xtics font ", 20"

    set key font ",18"
    set key top right

    set out "percentage_graph_noisy.eps"

    set yrange [0:100]
    set style data histogram
    set style histogram cluster gap 0
    set style fill solid
    set boxwidth 0.9
    set xtics format ""
    set grid ytics

    plot "percentage_graph_noisy.txt" using 1 title "Exhaust" linecolor "red", \
                '' using 2 title "h^m" linecolor "blue", \
                '' using 3 title "RHW" linecolor "green", \
                '' using 4 title "Zhu/Givan" linecolor "orange", \
                '' using 5 title "Hoffmann" linecolor "dark-grey"
EOFMarker