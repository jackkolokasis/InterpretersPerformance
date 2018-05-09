######################## histogramm for python ##############################
set key vertical maxrows 4 samplen 1 right top inside font",15"
set title "Python MPKI for all branch predictors"
set key autotitle columnhead
set key noenhanced
set title noenhanced
set terminal svg size 1100,600 enhanced font "Helvetica,20"
set output "compareResults/graphs/python.svg"
set yrange [*:*]
set xrange [*:*]
set auto x
yellow = "#FFFF00"; purple = "#55505C"; blue = "#0000FF" ; ocean = "#7FC6A4"; teal ="#008080";
red = "#B22222"; 
set style line 1 dashtype 1 lw 1 linecolor rgb yellow
set style line 2 dashtype 1 lw 1 linecolor rgb purple
set style line 3 dashtype 1 lw 1 linecolor rgb blue
set style line 4 dashtype 1 lw 1 linecolor rgb ocean
set style line 5 dashtype 1 lw 1 linecolor rgb red
set ylabel "MPKI"
set xlabel "Benchmarks"
set xtics font ", 15"
set ytics font ", 15"
set style data histogram
set style histogram cluster gap 1
set style fill solid
set xtics border in scale 0,0 nomirror rotate by -45  autojustify
set xtics norangelimit
set border 3
set xtics auto
set xtics noenhanced
set ytics auto
set grid ytics lc rgb "#bbbbbb" lw 1 lt 1
set grid xtics lc rgb "#bbbbbb" lw 1 lt 1
plot'compareResults/inputs/pythonAllRes.csv' using 2:xtic(1) ti col ls 5, '' u 3 ti col ls 2, '' u 4 ti col ls 3, '' u 5 ti col ls 4


