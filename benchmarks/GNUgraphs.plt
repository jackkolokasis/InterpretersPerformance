set key vertical maxrows 4 samplen 1 right top inside font",15"
set title "Python MPKI for all branch predictors"
set key autotitle columnhead
set terminal svg size 1100,600 enhanced font "Helvetica,20"
set output "graphs/python.svg"
set yrange [*:*]
set xrange [*:*]
set auto x
 yellow = "#E9B44C"; purple = "#55505C"; blue = "#5BC0EB" ; ocean = "#7FC6A4"; notknown = "#D6F8D6"; pink ="#D61A46";
set style line 1 dashtype 1 lw 3 linecolor rgb yellow
set style line 2 dashtype 1 lw 3 linecolor rgb purple
set style line 3 dashtype 1 lw 3 linecolor rgb blue
set style line 4 dashtype 1 lw 3 linecolor rgb ocean
set ylabel "MPKI"
set xlabel "Benchmarks"
set xtics font ", 15"
set ytics font ", 15"
set style data histogram
set style histogram cluster gap 0.1
set style fill solid
set xtics border in scale 0,0 nomirror rotate by -45  autojustify
set xtics norangelimit
set xtics auto
set ytics auto
set grid ytics lc rgb "#bbbbbb" lw 1 lt 1
set grid xtics lc rgb "#bbbbbb" lw 1 lt 1
plot'compareResults/workloadFile.csv' using 2:xtic(1) ti col, '' u 3 ti col, '' u 4 ti co, '' u 5 ti co

