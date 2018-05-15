#!/bin/bash
mkdir -p compareResults/graphs
gnuplot -e "" GNUgraphs.plt
firefox graphs.html

inkscape compareResults/graphs/java_box_amd.svg --export-pdf=java_box_amd.pdf
inkscape compareResults/graphs/java_box_core2.svg --export-pdf=java_box_core2.pdf
inkscape compareResults/graphs/java_box_haswell.svg --export-pdf=java_box_haswell.pdf
inkscape compareResults/graphs/java_box_ivy_bridge.svg --export-pdf=java_box_ivy_bridge.pdf
inkscape compareResults/graphs/java_box_nehalem..svg --export-pdf=java_box_nehalem.pdf
inkscape compareResults/graphs/java_MPKI.svg --export-pdf=java_MPKI.pdf
inkscape compareResults/graphs/javascript_box_amd.svg --export-pdf=javascript_box_amd.pdf
inkscape compareResults/graphs/javascript_box_core2.svg --export-pdf=javascript_box_core2.pdf
inkscape compareResults/graphs/javascript_box_haswell.svg --export-pdf=javascript_box_haswell.pdf
inkscape compareResults/graphs/javascript_box_ivy_bridge.svg --export-pdf=javascript_box_ivy_bridge.pdf
inkscape compareResults/graphs/javascript_box_nehalem.svg --export-pdf=javascript_box_nehalem.pdf
inkscape compareResults/graphs/javascript_MPKI.svg --export-pdf=javascript_MPKI.pdf
inkscape compareResults/graphs/python_box_amd.svg --export-pdf=python_box_amd.pdf
inkscape compareResults/graphs/python_box_core2.svg --export-pdf=python_box_core2.pdf
inkscape compareResults/graphs/python_box_haswell.svg --export-pdf=python_box_haswell.pdf
inkscape compareResults/graphs/python_box_ivy_bridge.svg --export-pdf=python_box_ivy_bridge.pdf
inkscape compareResults/graphs/python_box_nehalem.svg --export-pdf=python_box_nehalem.pdf
inkscape compareResults/graphs/python_MPKI.svg --export-pdf=python_MPKI.pdf

cp compareResults/graphs/*.pdf ../presentation/figures/  
