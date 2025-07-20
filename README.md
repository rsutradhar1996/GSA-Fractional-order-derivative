# GSA-Fractional-order-derivative
First  run the file Run_and_Plot.m. (first section only)  This matlab script calls the m-file parameter.m and Model_FDE.m (written in first section).

After 1000 simulation (will be shown on Command Window), the second section calculates the prcc values at t=800^th day and produces the scatter plots.  
The m-file PRCC_Cal_Scatter_PLot.m calculates the PRCC values and P-values and generate scatter plots. 

The third section calculates the prcc values at t=600^th day and produces the hexagonal diagrams. 
The m-file PRCC_Cal_Hex_PLot.m calculates the PRCC values and P-values and generate hexagonal plots. 

The fourth section compute the PRCC and P-value at time point t=1,2,3,...,1000. 

After that the m-files long_term_prcc.m and long_term_pvalue.m  to see the long term behaviour of PRCC values and P-values. 

Next, run  Matrixplot.m to generate the matrix representation of PRCC values at t=800^th day. One can choose differnt time point. 

Next, run  Radarchartcircular.m to generate the radar chart diagram of PRCC values at t=800^th day. One can choose differnt time point. 

Next, run  Parallel_coordinate.m to generate the parallel coordinate diagram of PRCC values at t=800^th day. One can choose differnt time point. 


