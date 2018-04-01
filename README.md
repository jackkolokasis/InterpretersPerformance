#   Project hy446                            
  Problem statement: Interpreters introduce a high number of indirect branches.
  According to [1] branch predictors at around 2000, were not able to predict accurately 
  those type of branches. In our project we are going to examine if this statement holds
  also for today's branch predictors.  
  [1]  M. Anton Ertl , David Gregg, The Structure and Performance of Efficient Interpreters.

#  Interpreted Languages to be tested are (possibly):
  1. JavaScript : https://www.javascript.com/
  2. Java       : https://www.java.com/en/
  3. Python     : https://www.python.org/	
  4. C#         : https://docs.microsoft.com/en-us/dotnet/csharp/ 
  5. Ruby	: https://www.ruby-lang.org/en/


#  Graphs for our evaluation

  1. Prediction Accuracy: Miss Predict rate of different interpreters over branch predictors
  2. Effect on execution time : Execution time of different interpreters over branch predictors

#  Architectures to be tested 
  1. Intel (sith)
  2. ARM   (hydra)

#  HW counters 
  PAPI :
  	http://icl.cs.utk.edu/projects/papi/wiki/PAPIC:Low_Level
  	https://www.cs.uoregon.edu/research/tau/docs/newguide/bk03ch01s04.html

