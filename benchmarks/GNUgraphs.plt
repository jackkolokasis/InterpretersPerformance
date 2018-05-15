################################ MPKI #####################################
######################## histogramm for python ##############################
set key vertical maxrows 4 samplen 1 right top inside font",15"
set title "Python MPKI for all branch predictors"
set key autotitle columnhead
set key noenhanced
set title noenhanced
set terminal svg size 1100,600 enhanced font "Helvetica,20"
set output "compareResults/graphs/python_MPKI.svg"
set yrange [*:*]
set xrange [*:*]
set auto x
yellow = "#FFFF00"; purple = "#55505C"; blue = "#0000FF" ; ocean = "#7FC6A4"; teal ="#008080";
red = "#B22222"; 
set style line 1 dashtype 1 lw 1 linecolor rgb teal
set style line 2 dashtype 1 lw 1 linecolor rgb purple
set style line 3 dashtype 1 lw 1 linecolor rgb blue
set style line 4 dashtype 1 lw 1 linecolor rgb ocean
set style line 5 dashtype 1 lw 1 linecolor rgb red
set ylabel "MPKI" offset 2,0,0
set xlabel "Benchmarks" offset 0,3,0
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
plot'compareResults/inputs/python_allArchs.csv' using 2:xtic(1) ti col ls 5, '' u 4 ti col ls 2, '' u 6 ti col ls 3, '' u 8 ti col ls 4, '' u 10 ti col ls 1

######################## histogramm for java ##############################
set key vertical maxrows 4 samplen 1 right top inside font",15"
set title "Java MPKI for all branch predictors"
set key autotitle columnhead
set key noenhanced
set title noenhanced
set terminal svg size 1100,600 enhanced font "Helvetica,20"
set output "compareResults/graphs/java_MPKI.svg"
set yrange [0:40]
set xrange [*:*]
set auto x
yellow = "#FFFF00"; purple = "#55505C"; blue = "#0000FF" ; ocean = "#7FC6A4"; teal ="#008080";
red = "#B22222"; 
set style line 1 dashtype 1 lw 1 linecolor rgb teal
set style line 2 dashtype 1 lw 1 linecolor rgb purple
set style line 3 dashtype 1 lw 1 linecolor rgb blue
set style line 4 dashtype 1 lw 1 linecolor rgb ocean
set style line 5 dashtype 1 lw 1 linecolor rgb red
set ylabel "MPKI" offset 2,0,0
set xlabel "Benchmarks" offset 0,3,0
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
plot'compareResults/inputs/java_allArchs.csv' using 2:xtic(1) ti col ls 5, '' u 4 ti col ls 2, '' u 6 ti col ls 3, '' u 8 ti col ls 4, '' u 10 ti col ls 1

######################## histogramm for javascript ##############################
set key vertical maxrows 4 samplen 1 right top inside font",15"
set title "Javascript MPKI for all branch predictors"
set key autotitle columnhead
set key noenhanced
set title noenhanced
set terminal svg size 1100,600 enhanced font "Helvetica,20"
set output "compareResults/graphs/javascript_MPKI.svg"
set yrange [*:*]
set xrange [*:*]
set auto x
yellow = "#FFFF00"; purple = "#55505C"; blue = "#0000FF" ; ocean = "#7FC6A4"; teal ="#008080";
red = "#B22222"; 
set style line 1 dashtype 1 lw 1 linecolor rgb teal
set style line 2 dashtype 1 lw 1 linecolor rgb purple
set style line 3 dashtype 1 lw 1 linecolor rgb blue
set style line 4 dashtype 1 lw 1 linecolor rgb ocean
set style line 5 dashtype 1 lw 1 linecolor rgb red
set ylabel "MPKI" offset 2,0,0
set xlabel "Benchmarks" offset 0,3,0
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
plot'compareResults/inputs/javascript_allArchs.csv' using 2:xtic(1) ti col ls 5, '' u 4 ti col ls 2, '' u 6 ti col ls 3, '' u 8 ti col ls 4, '' u 10 ti col ls 1


######################## Core2 box plot for python ##############################
set key vertical maxrows 4 samplen 1 right top inside font",15"
set title "Core2: MPKI for all Python benchmarks"
set key autotitle columnhead
set key noenhanced
set title noenhanced
set terminal svg size 1100,600 enhanced font "Helvetica,20

set border 2 front lt black linewidth 1.000 dashtype solid
set boxwidth 0.15 absolute
set output "compareResults/graphs/python_box_core2.svg"
set style fill solid 0.25 border lt -1
unset key
set pointsize 0.2
set xlabel "Benchmarks" offset 0,2,0
set style data boxplot
set xtics   ("2to3" 1,"chaos" 1.2, "deltablue" 1.4, "fannkuch" 1.6, "float" 1.8, "go" 2.0, "hexiom" 2.2, "json_dumps" 2.4, "json_loads" 2.6, "logging" 2.8, "mdp" 3.0, "mc" 3.2, "nbody" 3.4, "nqueens" 3.6, "pathl" 3.8, "piddig" 4.0, "pyflate" 4.2,"pystart" 4.4, "raytrace" 4.6, "regcom" 4.8) 
set ytics border in scale 1,0.5 nomirror autojustify
set xtics border in scale 0,0 nomirror autojustify
set xtics  norangelimit

set yrange [ 0.00000 : * ] noreverse nowriteback
plot 'compareResults/inputs/boxplot_python_core2.csv' using (1):1, '' using (1.2):2, '' using (1.4):3, '' using (1.6):4, '' using (1.8):5, '' using (2.0):6, '' using (2.2):7, '' using (2.4):8, '' using (2.6):9, '' using (2.8):10, '' using (3.0):11, '' using (3.2):12, '' using (3.4):13, '' using (3.6):14, '' using (3.8):15, '' using (4.0):16, '' using (4.2):17, '' using (4.4):18, '' using (4.6):19, '' using (4.8):20 

######################## Nehalem box plot for python ##############################
set key vertical maxrows 4 samplen 1 right top inside font",15"
set title "Nehalem: MPKI for all Python benchmarks"
set key autotitle columnhead
set key noenhanced
set title noenhanced
set terminal svg size 1100,600 enhanced font "Helvetica,20

set border 2 front lt black linewidth 1.000 dashtype solid
set boxwidth 0.15 absolute
set output "compareResults/graphs/python_box_nehalem.svg"
set style fill solid 0.25 border lt -1
unset key
set pointsize 0.2
set xlabel "Benchmarks" offset 0,2,0
set style data boxplot
set xtics   ("2to3" 1,"chaos" 1.2, "deltablue" 1.4, "fannkuch" 1.6, "float" 1.8, "go" 2.0, "hexiom" 2.2, "json_dumps" 2.4, "json_loads" 2.6, "logging" 2.8, "mdp" 3.0, "mc" 3.2, "nbody" 3.4, "nqueens" 3.6, "pathl" 3.8, "piddig" 4.0, "pyflate" 4.2,"pystart" 4.4, "raytrace" 4.6, "regcom" 4.8) 
set ytics border in scale 1,0.5 nomirror autojustify
set xtics border in scale 0,0 nomirror autojustify
set xtics  norangelimit

set yrange [ 0.00000 : * ] noreverse nowriteback
plot 'compareResults/inputs/boxplot_python_nehalem.csv' using (1):1, '' using (1.2):2, '' using (1.4):3, '' using (1.6):4, '' using (1.8):5, '' using (2.0):6, '' using (2.2):7, '' using (2.4):8, '' using (2.6):9, '' using (2.8):10, '' using (3.0):11, '' using (3.2):12, '' using (3.4):13, '' using (3.6):14, '' using (3.8):15, '' using (4.0):16, '' using (4.2):17, '' using (4.4):18, '' using (4.6):19, '' using (4.8):20

######################## Ivy Bridge box plot for python ##############################
set key vertical maxrows 4 samplen 1 right top inside font",15"
set title "Ivy Bridge: MPKI for all Python benchmarks"
set key autotitle columnhead
set key noenhanced
set title noenhanced
set terminal svg size 1100,600 enhanced font "Helvetica,20

set border 2 front lt black linewidth 1.000 dashtype solid
set boxwidth 0.15 absolute
set output "compareResults/graphs/python_box_ivy_bridge.svg"
set style fill solid 0.25 border lt -1
unset key
set pointsize 0.2
set xlabel "Benchmarks" offset 0,2,0
set style data boxplot
set xtics   ("2to3" 1,"chaos" 1.2, "deltablue" 1.4, "fannkuch" 1.6, "float" 1.8, "go" 2.0, "hexiom" 2.2, "json_dumps" 2.4, "json_loads" 2.6, "logging" 2.8, "mdp" 3.0, "mc" 3.2, "nbody" 3.4, "nqueens" 3.6, "pathl" 3.8, "piddig" 4.0, "pyflate" 4.2,"pystart" 4.4, "raytrace" 4.6, "regcom" 4.8) 
set ytics border in scale 1,0.5 nomirror autojustify
set xtics border in scale 0,0 nomirror autojustify
set xtics  norangelimit

set yrange [ 0.00000 : * ] noreverse nowriteback
plot 'compareResults/inputs/boxplot_python_ivy_bridge.csv' using (1):1, '' using (1.2):2, '' using (1.4):3, '' using (1.6):4, '' using (1.8):5, '' using (2.0):6, '' using (2.2):7, '' using (2.4):8, '' using (2.6):9, '' using (2.8):10, '' using (3.0):11, '' using (3.2):12, '' using (3.4):13, '' using (3.6):14, '' using (3.8):15, '' using (4.0):16, '' using (4.2):17, '' using (4.4):18, '' using (4.6):19, '' using (4.8):20 

######################## Haswell box plot for python ##############################
set key vertical maxrows 4 samplen 1 right top inside font",15"
set title "Haswell: MPKI for all Python benchmarks"
set key autotitle columnhead
set key noenhanced
set title noenhanced
set terminal svg size 1100,600 enhanced font "Helvetica,20

set border 2 front lt black linewidth 1.000 dashtype solid
set boxwidth 0.15 absolute
set output "compareResults/graphs/python_box_haswell.svg"
set style fill solid 0.25 border lt -1
unset key
set pointsize 0.2
set xlabel "Benchmarks" offset 0,2,0
set style data boxplot
set xtics   ("2to3" 1,"chaos" 1.2, "deltablue" 1.4, "fannkuch" 1.6, "float" 1.8, "go" 2.0, "hexiom" 2.2, "json_dumps" 2.4, "json_loads" 2.6, "logging" 2.8, "mdp" 3.0, "mc" 3.2, "nbody" 3.4, "nqueens" 3.6, "pathl" 3.8, "piddig" 4.0, "pyflate" 4.2,"pystart" 4.4, "raytrace" 4.6, "regcom" 4.8) 
set ytics border in scale 1,0.5 nomirror autojustify
set xtics border in scale 0,0 nomirror autojustify
set xtics  norangelimit

set yrange [ 0.00000 : * ] noreverse nowriteback
plot 'compareResults/inputs/boxplot_python_haswell.csv' using (1):1, '' using (1.2):2, '' using (1.4):3, '' using (1.6):4, '' using (1.8):5, '' using (2.0):6, '' using (2.2):7, '' using (2.4):8, '' using (2.6):9, '' using (2.8):10, '' using (3.0):11, '' using (3.2):12, '' using (3.4):13, '' using (3.6):14, '' using (3.8):15, '' using (4.0):16, '' using (4.2):17, '' using (4.4):18, '' using (4.6):19, '' using (4.8):20 

######################## AMD box plot for python ##############################
set key vertical maxrows 4 samplen 1 right top inside font",15"
set title "AMD: MPKI for all Python benchmarks"
set key autotitle columnhead
set key noenhanced
set title noenhanced
set terminal svg size 1100,600 enhanced font "Helvetica,20

set border 2 front lt black linewidth 1.000 dashtype solid
set boxwidth 0.15 absolute
set output "compareResults/graphs/python_box_amd.svg"
set style fill solid 0.25 border lt -1
unset key
set pointsize 0.2
set xlabel "Benchmarks" offset 0,2,0
set style data boxplot
set xtics   ("2to3" 1,"chaos" 1.2, "deltablue" 1.4, "fannkuch" 1.6, "float" 1.8, "go" 2.0, "hexiom" 2.2, "json_dumps" 2.4, "json_loads" 2.6, "logging" 2.8, "mdp" 3.0, "mc" 3.2, "nbody" 3.4, "nqueens" 3.6, "pathl" 3.8, "piddig" 4.0, "pyflate" 4.2,"pystart" 4.4, "raytrace" 4.6, "regcom" 4.8) 
set ytics border in scale 1,0.5 nomirror autojustify
set xtics border in scale 0,0 nomirror autojustify
set xtics  norangelimit

set yrange [ 0.00000 : * ] noreverse nowriteback
plot 'compareResults/inputs/boxplot_python_amd.csv' using (1):1, '' using (1.2):2, '' using (1.4):3, '' using (1.6):4, '' using (1.8):5, '' using (2.0):6, '' using (2.2):7, '' using (2.4):8, '' using (2.6):9, '' using (2.8):10, '' using (3.0):11, '' using (3.2):12, '' using (3.4):13, '' using (3.6):14, '' using (3.8):15, '' using (4.0):16, '' using (4.2):17, '' using (4.4):18, '' using (4.6):19, '' using (4.8):20 

##############################################################################
######################## Core2 box plot for Java ##############################
set key vertical maxrows 4 samplen 1 right top inside font",15"
set title "Core2: MPKI for all Java benchmarks"
set key autotitle columnhead
set key noenhanced
set title noenhanced
set terminal svg size 1100,600 enhanced font "Helvetica,20

set border 2 front lt black linewidth 1.000 dashtype solid
set boxwidth 0.15 absolute
set output "compareResults/graphs/java_box_core2.svg"
set style fill solid 0.25 border lt -1
unset key
set pointsize 0.2
set xlabel "Benchmarks" offset 0,2,0
set style data boxplot
set xtics   ("avrora" 1,"batik" 1.2, "eclipse" 1.4, "fop" 1.6, "h2" 1.8, "jython" 2.0, "luindex" 2.2, "lusearch" 2.4, "pmd" 2.6, "sunflow" 2.8, "tomcat" 3.0, "tradebeans" 3.2, "tradesoap" 3.4, "xalan" 3.6) 
set ytics border in scale 1,0.5 nomirror autojustify
set xtics border in scale 0,0 nomirror autojustify
set xtics  norangelimit

set yrange [ 0.00000 : * ] noreverse nowriteback
plot 'compareResults/inputs/boxplot_java_core2.csv' using (1):1, '' using (1.2):2, '' using (1.4):3, '' using (1.6):4, '' using (1.8):5, '' using (2.0):6, '' using (2.2):7, '' using (2.4):8, '' using (2.6):9, '' using (2.8):10, '' using (3.0):11, '' using (3.2):12, '' using (3.4):13, '' using (3.6):14

######################## Nehaled box plot for Java ##############################
set key vertical maxrows 4 samplen 1 right top inside font",15"
set title "Nehalem: MPKI for all Java benchmarks"
set key autotitle columnhead
set key noenhanced
set title noenhanced
set terminal svg size 1100,600 enhanced font "Helvetica,20

set border 2 front lt black linewidth 1.000 dashtype solid
set boxwidth 0.15 absolute
set output "compareResults/graphs/java_box_nehalem.svg"
set style fill solid 0.25 border lt -1
unset key
set pointsize 0.2
set xlabel "Benchmarks" offset 0,2,0
set style data boxplot
set xtics   ("avrora" 1,"batik" 1.2, "eclipse" 1.4, "fop" 1.6, "h2" 1.8, "jython" 2.0, "luindex" 2.2, "lusearch" 2.4, "pmd" 2.6, "sunflow" 2.8, "tomcat" 3.0, "tradebeans" 3.2, "tradesoap" 3.4, "xalan" 3.6) 
set ytics border in scale 1,0.5 nomirror autojustify
set xtics border in scale 0,0 nomirror autojustify
set xtics  norangelimit

set yrange [ 0.00000 : * ] noreverse nowriteback
plot 'compareResults/inputs/boxplot_java_nehalem.csv' using (1):1, '' using (1.2):2, '' using (1.4):3, '' using (1.6):4, '' using (1.8):5, '' using (2.0):6, '' using (2.2):7, '' using (2.4):8, '' using (2.6):9, '' using (2.8):10, '' using (3.0):11, '' using (3.2):12, '' using (3.4):13, '' using (3.6):14

######################## Ivy Bridge box plot for Java ##############################
set key vertical maxrows 4 samplen 1 right top inside font",15"
set title "Ivy Bridge: MPKI for all Java benchmarks"
set key autotitle columnhead
set key noenhanced
set title noenhanced
set terminal svg size 1100,600 enhanced font "Helvetica,20

set border 2 front lt black linewidth 1.000 dashtype solid
set boxwidth 0.15 absolute
set output "compareResults/graphs/java_box_ivy_bridge.svg"
set style fill solid 0.25 border lt -1
unset key
set pointsize 0.2
set xlabel "Benchmarks" offset 0,2,0
set style data boxplot
set xtics   ("avrora" 1,"batik" 1.2, "eclipse" 1.4, "fop" 1.6, "h2" 1.8, "jython" 2.0, "luindex" 2.2, "lusearch" 2.4, "pmd" 2.6, "sunflow" 2.8, "tomcat" 3.0, "tradebeans" 3.2, "tradesoap" 3.4, "xalan" 3.6) 
set ytics border in scale 1,0.5 nomirror autojustify
set xtics border in scale 0,0 nomirror autojustify
set xtics  norangelimit

set yrange [ 0.00000 : * ] noreverse nowriteback
plot 'compareResults/inputs/boxplot_java_ivy_bridge.csv' using (1):1, '' using (1.2):2, '' using (1.4):3, '' using (1.6):4, '' using (1.8):5, '' using (2.0):6, '' using (2.2):7, '' using (2.4):8, '' using (2.6):9, '' using (2.8):10, '' using (3.0):11, '' using (3.2):12, '' using (3.4):13, '' using (3.6):14

######################## Core2 box plot for Java ##############################
set key vertical maxrows 4 samplen 1 right top inside font",15"
set title "Haswell: MPKI for all Java benchmarks"
set key autotitle columnhead
set key noenhanced
set title noenhanced
set terminal svg size 1100,600 enhanced font "Helvetica,20

set border 2 front lt black linewidth 1.000 dashtype solid
set boxwidth 0.15 absolute
set output "compareResults/graphs/java_box_haswell.svg"
set style fill solid 0.25 border lt -1
unset key
set pointsize 0.2
set xlabel "Benchmarks" offset 0,2,0
set style data boxplot
set xtics   ("avrora" 1,"batik" 1.2, "eclipse" 1.4, "fop" 1.6, "h2" 1.8, "jython" 2.0, "luindex" 2.2, "lusearch" 2.4, "pmd" 2.6, "sunflow" 2.8, "tomcat" 3.0, "tradebeans" 3.2, "tradesoap" 3.4, "xalan" 3.6) 
set ytics border in scale 1,0.5 nomirror autojustify
set xtics border in scale 0,0 nomirror autojustify
set xtics  norangelimit

set yrange [ 0.00000 : * ] noreverse nowriteback
plot 'compareResults/inputs/boxplot_java_haswell.csv' using (1):1, '' using (1.2):2, '' using (1.4):3, '' using (1.6):4, '' using (1.8):5, '' using (2.0):6, '' using (2.2):7, '' using (2.4):8, '' using (2.6):9, '' using (2.8):10, '' using (3.0):11, '' using (3.2):12, '' using (3.4):13, '' using (3.6):14

######################## AMD box plot for Java ##############################
set key vertical maxrows 4 samplen 1 right top inside font",15"
set title "AMD: MPKI for all Java benchmarks"
set key autotitle columnhead
set key noenhanced
set title noenhanced
set terminal svg size 1100,600 enhanced font "Helvetica,20

set border 2 front lt black linewidth 1.000 dashtype solid
set boxwidth 0.15 absolute
set output "compareResults/graphs/java_box_amd.svg"
set style fill solid 0.25 border lt -1
unset key
set pointsize 0.2
set xlabel "Benchmarks" offset 0,2,0
set style data boxplot
set xtics   ("avrora" 1,"batik" 1.2, "eclipse" 1.4, "fop" 1.6, "h2" 1.8, "jython" 2.0, "luindex" 2.2, "lusearch" 2.4, "pmd" 2.6, "sunflow" 2.8, "tomcat" 3.0, "tradebeans" 3.2, "tradesoap" 3.4, "xalan" 3.6) 
set ytics border in scale 1,0.5 nomirror autojustify
set xtics border in scale 0,0 nomirror autojustify
set xtics  norangelimit

set yrange [ 0.00000 : * ] noreverse nowriteback
plot 'compareResults/inputs/boxplot_java_amd.csv' using (1):1, '' using (1.2):2, '' using (1.4):3, '' using (1.6):4, '' using (1.8):5, '' using (2.0):6, '' using (2.2):7, '' using (2.4):8, '' using (2.6):9, '' using (2.8):10, '' using (3.0):11, '' using (3.2):12, '' using (3.4):13, '' using (3.6):14
########################################################################

######################## Core2 box plot for JavaScript ##############################
set key vertical maxrows 4 samplen 1 right top inside font",15"
set title "Core2: MPKI for all Javascript benchmarks"
set key autotitle columnhead
set key noenhanced
set title noenhanced
set terminal svg size 1100,600 enhanced font "Helvetica,20

set border 2 front lt black linewidth 1.000 dashtype solid
set boxwidth 0.15 absolute
set output "compareResults/graphs/javascript_box_core2.svg"
set style fill solid 0.25 border lt -1
unset key
set pointsize 0.2
set xlabel "Benchmarks" offset 0,2,0
set style data boxplot
set xtics   ("box2d" 1,"codeload" 1.2, "crypto" 1.4, "deltablue" 1.6, "earleyboyer" 1.8, "gbemu" 2.0, "navier-str" 2.2, "raytrace" 2.4, "regexp" 2.6, "richards" 2.8, "splay" 3.0, "typescript" 3.2, "zlib" 3.4) 
set ytics border in scale 1,0.5 nomirror autojustify
set xtics border in scale 0,0 nomirror autojustify
set xtics  norangelimit

set yrange [ 0.00000 : * ] noreverse nowriteback
plot 'compareResults/inputs/boxplot_javascript_core2.csv' using (1):1, '' using (1.2):2, '' using (1.4):3, '' using (1.6):4, '' using (1.8):5, '' using (2.0):6, '' using (2.2):7, '' using (2.4):8, '' using (2.6):9, '' using (2.8):10, '' using (3.0):11, '' using (3.2):12, '' using (3.4):13

######################## Nehalem box plot for JavaScript ##############################
set key vertical maxrows 4 samplen 1 right top inside font",15"
set title "Nehalem: MPKI for all Javascript benchmarks"
set key autotitle columnhead
set key noenhanced
set title noenhanced
set terminal svg size 1100,600 enhanced font "Helvetica,20

set border 2 front lt black linewidth 1.000 dashtype solid
set boxwidth 0.15 absolute
set output "compareResults/graphs/javascript_box_nehalem.svg"
set style fill solid 0.25 border lt -1
unset key
set pointsize 0.2
set xlabel "Benchmarks" offset 0,2,0
set style data boxplot
set xtics   ("box2d" 1,"codeload" 1.2, "crypto" 1.4, "deltablue" 1.6, "earleyboyer" 1.8, "gbemu" 2.0, "navier-str" 2.2, "raytrace" 2.4, "regexp" 2.6, "richards" 2.8, "splay" 3.0, "typescript" 3.2, "zlib" 3.4) 
set ytics border in scale 1,0.5 nomirror autojustify
set xtics border in scale 0,0 nomirror autojustify
set xtics  norangelimit

set yrange [ 0.00000 : * ] noreverse nowriteback
plot 'compareResults/inputs/boxplot_javascript_nehalem.csv' using (1):1, '' using (1.2):2, '' using (1.4):3, '' using (1.6):4, '' using (1.8):5, '' using (2.0):6, '' using (2.2):7, '' using (2.4):8, '' using (2.6):9, '' using (2.8):10, '' using (3.0):11, '' using (3.2):12, '' using (3.4):13

######################## Ivy Bridge box plot for JavaScript ##############################
set key vertical maxrows 4 samplen 1 right top inside font",15"
set title "Ivy Bridge: MPKI for all Javascript benchmarks"
set key autotitle columnhead
set key noenhanced
set title noenhanced
set terminal svg size 1100,600 enhanced font "Helvetica,20

set border 2 front lt black linewidth 1.000 dashtype solid
set boxwidth 0.15 absolute
set output "compareResults/graphs/javascript_box_ivy_bridge.svg"
set style fill solid 0.25 border lt -1
unset key
set pointsize 0.2
set xlabel "Benchmarks" offset 0,2,0
set style data boxplot
set xtics   ("box2d" 1,"codeload" 1.2, "crypto" 1.4, "deltablue" 1.6, "earleyboyer" 1.8, "gbemu" 2.0, "navier-str" 2.2, "raytrace" 2.4, "regexp" 2.6, "richards" 2.8, "splay" 3.0, "typescript" 3.2, "zlib" 3.4) 
set ytics border in scale 1,0.5 nomirror autojustify
set xtics border in scale 0,0 nomirror autojustify
set xtics  norangelimit

set yrange [ 0.00000 : * ] noreverse nowriteback
plot 'compareResults/inputs/boxplot_javascript_ivy_bridge.csv' using (1):1, '' using (1.2):2, '' using (1.4):3, '' using (1.6):4, '' using (1.8):5, '' using (2.0):6, '' using (2.2):7, '' using (2.4):8, '' using (2.6):9, '' using (2.8):10, '' using (3.0):11, '' using (3.2):12, '' using (3.4):13

######################## Haswell box plot for JavaScript ##############################
set key vertical maxrows 4 samplen 1 right top inside font",15"
set title "Haswell: MPKI for all Javascript benchmarks"
set key autotitle columnhead
set key noenhanced
set title noenhanced
set terminal svg size 1100,600 enhanced font "Helvetica,20

set border 2 front lt black linewidth 1.000 dashtype solid
set boxwidth 0.15 absolute
set output "compareResults/graphs/javascript_box_haswell.svg"
set style fill solid 0.25 border lt -1
unset key
set pointsize 0.2
set xlabel "Benchmarks" offset 0,2,0
set style data boxplot
set xtics   ("box2d" 1,"codeload" 1.2, "crypto" 1.4, "deltablue" 1.6, "earleyboyer" 1.8, "gbemu" 2.0, "navier-str" 2.2, "raytrace" 2.4, "regexp" 2.6, "richards" 2.8, "splay" 3.0, "typescript" 3.2, "zlib" 3.4) 
set ytics border in scale 1,0.5 nomirror autojustify
set xtics border in scale 0,0 nomirror autojustify
set xtics  norangelimit

set yrange [ 0.00000 : * ] noreverse nowriteback
plot 'compareResults/inputs/boxplot_javascript_haswell.csv' using (1):1, '' using (1.2):2, '' using (1.4):3, '' using (1.6):4, '' using (1.8):5, '' using (2.0):6, '' using (2.2):7, '' using (2.4):8, '' using (2.6):9, '' using (2.8):10, '' using (3.0):11, '' using (3.2):12, '' using (3.4):13


######################## AMD box plot for JavaScript ##############################
set key vertical maxrows 4 samplen 1 right top inside font",15"
set title "AMD: MPKI for all Javascript benchmarks"
set key autotitle columnhead
set key noenhanced
set title noenhanced
set terminal svg size 1100,600 enhanced font "Helvetica,20

set border 2 front lt black linewidth 1.000 dashtype solid
set boxwidth 0.15 absolute
set output "compareResults/graphs/javascript_box_amd.svg"
set style fill solid 0.25 border lt -1
unset key
set pointsize 0.2
set xlabel "Benchmarks" offset 0,2,0
set style data boxplot
set xtics   ("box2d" 1,"codeload" 1.2, "crypto" 1.4, "deltablue" 1.6, "earleyboyer" 1.8, "gbemu" 2.0, "navier-str" 2.2, "raytrace" 2.4, "regexp" 2.6, "richards" 2.8, "splay" 3.0, "typescript" 3.2, "zlib" 3.4) 
set ytics border in scale 1,0.5 nomirror autojustify
set xtics border in scale 0,0 nomirror autojustify
set xtics  norangelimit

set yrange [ 0.00000 : * ] noreverse nowriteback
plot 'compareResults/inputs/boxplot_javascript_amd.csv' using (1):1, '' using (1.2):2, '' using (1.4):3, '' using (1.6):4, '' using (1.8):5, '' using (2.0):6, '' using (2.2):7, '' using (2.4):8, '' using (2.6):9, '' using (2.8):10, '' using (3.0):11, '' using (3.2):12, '' using (3.4):13


