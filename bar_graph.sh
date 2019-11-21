#!/bin/bash 
reset

gnuplot -persist <<-EOFMarker

    set terminal postscript color

    set xlabel "Observability" font ", 17"
    set ylabel "Accuracy/Spread" font ", 17"

    set ytics font ", 20"
    set xtics font ", 20"

    set key font ",18"
    set key top left

    set out "bar_graph_uniqueness_noisy.eps"

    set yrange [0:100]
    set style data histogram
    set style histogram cluster gap 1
    set style fill solid
    set boxwidth 0.9
    set xtics format ""
    set grid ytics

    # plot "bar_graph.txt" using 2:xtic(1) title "Exhaust" linecolor "red", \
    #             '' using 3 title "h^m" linecolor "blue", \
    #             '' using 4 title "RHW" linecolor "green", \
    #             '' using 5 title "Zhu/Givan" linecolor "orange", \
    #             '' using 6 title "Hoffmann" linecolor "dark-grey"

    # plot "bar_graph_noisy.txt" using 2:xtic(1) title "Exhaust" linecolor "red" fs solid 0.5, \
    #             '' using 3 title "h^m" linecolor "blue" fs solid 0.5, \
    #             '' using 4 title "RHW" linecolor "green" fs solid 0.5, \
    #             '' using 5 title "Zhu/Givan" linecolor "orange" fs solid 0.5, \
    #             '' using 6 title "Hoffmann" linecolor "dark-grey" fs solid 0.5

    plot "bar_graph_noisy.txt" using 2:xtic(1) title "Exhaust" linecolor "red" fs pattern 2, \
                '' using 3 title "h^m" linecolor "blue" fs pattern 2, \
                '' using 4 title "RHW" linecolor "green" fs pattern 2, \
                '' using 5 title "Zhu/Givan" linecolor "orange" fs pattern 2, \
                '' using 6 title "Hoffmann" linecolor "dark-grey" fs pattern 2
EOFMarker