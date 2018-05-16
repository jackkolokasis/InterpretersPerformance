# Evaluating the Performance of Interpreters Over Various Branch Predictors 

Interpreters introduced a high number of indirect branches. In this
project we analyze the performance of three popular interpreters
(Python, Java, JavaScript) over various branch predictors. All the
hardware counters data collected using OProfile, an open source
project that includes a statistical profiler for Linux systems,
capable of profiling all running code at low overhead.
(http://oprofile.sourceforge.net/news/)

## Getting Started
These instructions will get you a copy of the project up and running
on your local machine for development and testing purposes. See
deployment for notes on how to deploy the project on a live system.

### Prerequisites
You need to install:

OProfile (Ubuntu 16.10)
```
    $ sudo apt-get install oprofile
```
OProfile (Centos 7)
```
    $ sudo yum install oprofile
```
Install Python3.6 (Ubuntu 16.10)
```
    $ sudo apt-get update
    $ sudo apt-get install python3.6
```

Install Python3.6 (Centos 7)
```
    $ sudo yum -y install python36u
```

Install python-pip 
```
	$ wget https://bootstrap.pypa.io/get-pip.py
	$ sudo python3.6 get-pip.py
```

Operf
```
    $ sudo python3.6 -m pip install perf	
```
Install Rhino (Ubuntu 16.10)
```
    $ sudo apt-get install rhino
```
Install Rhino (Centos 7)
```
    $ yum install rhino
```

## Running the tests
All the tests must run inside bechmarks directory
```
    $ cd benchmarks/
```
Run the benchmarks
```
    $ ./1.runNTimes.sh
```
Parse the results
```
    $ ./2.parseResutls.sh
```
Plot the results
```
    $ cd benchmarks/
    $ ./3.runGNUGraphs.sh
```

##  Interpreted Languages :
    1. JavaScript : https://www.javascript.com/
    2. Java       : https://www.java.com/en/
    3. Python     : https://ww.python.org/	


## Hardware Architectures 
    1. Intel Core 2 Duo
    2. Intel Nehalem(2008)
    3. Intel Ivy Bridge(2012)
    4. Intel Haswell(2013)
    5. AMD64 family15h

## Benchmarks
    1. JavaScript    : https://github.com/chromium/octane
    2. Java          : https://www.spec.org/jvm2008/
    3. Python        : https://github.com/python/performance

