#!/bin/bash
mkdir -p compareResults/graphs
gnuplot -e "" GNUgraphs.plt
firefox graphs.html
