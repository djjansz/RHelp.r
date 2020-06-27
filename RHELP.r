#### RHELP - getting help in R  ###
# ?: Displays the Help file for a specific function. For example, 
?data.frame  #displays the Help file for the data.frame() function.
# ??: Searches for a word (or pattern) in the Help files. 
# The following code returns the names of functions that contain the word list in either the function names or their descriptions.
??list 
# RSiteSearch(): Performs an online search of the R functions, package vignettes and the R-help mail archives. 
# The following code does a search at this website for the search term “linear models.”
RSiteSearch('linear models') 
install.packages("sos") 
library(sos)
# Use the findFn function in the sos package to search functions with the name actuarial in them
findFn("actuarial") 
help.start()            #A web-based set of help pages (try the link to "An Introduction to R")
help(sqrt)              #Show details of the "sqrt" and similar functions
?sqrt                   #A shortcut to do the same thing
example(sqrt)           #run the examples on the bottom of the help page for "sqrt"
help.search("maximum")  #gives a list of functions involving the word "maximum", but oddly, "max" is not in there!
library() 
search()
# install.packages("sp")
library(sp)
help(package = "sp")
packageDescription("sp") # Short description
library(help=sp)
ls("package:sp") # List functions
lsf.str("package:sp") # List functions with parameters
str(read.csv) # Function and parameters
help(SpatialPoints) # Get help for functions
list.files(system.file(package="sp")) # List system files for package
file.show(system.file("ChangeLog", package="sp")) # Open some system file
vignette(package="sp") # List vignettes (optional suplemental documentation)
vignette("intro_sp",package="sp") # Open vignette
edit(vignette("intro_sp",package="sp")) # Get R code from vignette and display in new window (cool)
demo(package = .packages(all.available = TRUE)) # List all available demos
demo(package = "sp") # List demo for chosen package
demo(gallery) # Run Demo
RSiteSearch("sp") # Search R site for string
example(read.csv) # How to list functions with examples?
data(package="sp") # Get list of available datasets for package

#### ROBJECTS - working with R objects - vectors, arrays, lists, matricies and data frames #### 
DF <- data.frame(index=1:12, date=rep(c(Sys.Date()-1, Sys.Date()), 6), group=c("A","B","C"), value=round(rnorm(12),2))
	  p_vector = c(0,0.5,0.75,0.95) 
class(DF)
typeof(DF)
names(DF)  # names

# Create some objects for use in a simulation and examine them further
# Simulate a BVN with unit stdev and cov=0.5 Using the Cholesky factor
h = function(x) { return( x[1]*x[2] ) }
algorithm = " Simulating the Bivariate Normal using the Cholesky factor "
M = 500;
X = rnorm(2)  # random initial value for X
sigma = 1  # proposal scaling
x1list = x2list = hlistCov = rep(0,M)  # for keeping track of values
L<-matrix(c(0,.8660254,1,0.5),nrow=2,ncol=2)
L%*%t(L)   # show that the Cholesky factor is correct
for (i in 1:M) {
    Z<-rbind(rnorm(1),rnorm(1))
    X = L%*%Z
    x1list[i] = X[1];
    x2list[i] = X[2];
    hlistCov[i] = h(X)  
}
# Show that the covariance is close to 0.5 for this simulated bvn dist
mean(hlistCov)
# Show the types of objects used in the above simulation
class(h)
typeof(h)
class(L)
typeof(L)
class(M)
typeof(M)
class(hlistCov)
typeof(hlistCov)
length(hlistCov) # number of elements or components
str(hlistCov)    # structure
ls()       # list current objects

# Examples from: http://www.statmethods.net/input/datatypes.html
# 1. Vectors 
a <- c(1,2,5.3,6,-2,4) # numeric vector
b <- c("one","two","three") # character vector
c <- c(TRUE,TRUE,TRUE,FALSE,TRUE,FALSE) #logical vector
# Refer to elements of a vector using subscripts.
a[c(2,4)] # 2nd and 4th elements of vectors
# 2. Matricies
# generates 5 x 4 numeric matrix 
y<-matrix(1:20, nrow=5,ncol=4)
# another example
cells <- c(1,26,24,68)
rnames <- c("R1", "R2")
cnames <- c("C1", "C2") 
mymatrix <- matrix(cells, nrow=2, ncol=2, byrow=TRUE,
  dimnames=list(rnames, cnames))
x[,4] # 4th column of matrix
x[3,] # 3rd row of matrix 
x[2:4,1:3] # rows 2,3,4 of columns 1,2,3
# 3. Arrays - Arrays are similar to matrices but can have more than two dimensions. See help(array) for details.
# 4. Data Frames - A data frame is more general than a matrix, in that different columns can have different modes (numeric, character, factor, etc.). This is similar to SAS and SPSS datasets.
d <- c(1,2,3,4)
e <- c("red", "white", "red", NA)
f <- c(TRUE,TRUE,TRUE,FALSE)
mydata <- data.frame(d,e,f)
names(mydata) <- c("ID","Color","Passed") # variable names
myframe[3:5] # columns 3,4,5 of data frame
myframe[c("ID","Age")] # columns ID and Age from data frame
myframe$X1 # variable x1 in the data frames
# 5. Lists - An ordered collection of objects (components). A list allows you to gather a variety of (possibly unrelated) objects under one name.
# example of a list with 4 components - 
# a string, a numeric vector, a matrix, and a scaler 
w <- list(name="Fred", mynumbers=a, mymatrix=y, age=5.3)
# example of a list containing two lists 
v <- c(list1,list2)
# 6. factors - Tell R that a variable is nominal by making it a factor. The factor stores the nominal values as a vector of integers in the range [ 1... k ] (where k is the number of unique values in the nominal variable), 
# and an internal vector of character strings (the original values) mapped to these integers
# variable gender with 20 "male" entries and 
# 30 "female" entries 
gender <- c(rep("male",20), rep("female", 30)) 
gender <- factor(gender) 
# stores gender as 20 1s and 30 2s and associates
# 1=female, 2=male internally (alphabetically)
# R now treats gender as a nominal variable 
summary(gender)
# An ordered factor is used to represent an ordinal variable.
# variable rating coded as "large", "medium", "small'
rating <- ordered(rating)
# recodes rating to 1,2,3 and associates
# 1=large, 2=medium, 3=small internally
# R now treats rating as ordinal


#### RPACKAGES - Usefule Packages #### 

# RExcel and the R Commander - Integrating R and Excel
install.packages("Rcmdr")
library(Rcmdr)
install.packages("RExcelInstaller")
library(RExcelInstaller)
install.packages("rscproxy")
library(rscproxy)
install.packages("rcom")
library(rcom)
install.packages("gdata")
library(gdata) 
# The Rattle GUI for data mining (may not work on 32-bit systems)
install.packages("rattle")
library(rattle)
rattle()
rattleInfo()
install.packages("actuar")
install.packages("VGAM")
install.packages("moments")
install.packages("cubature")
install.packages("mcsm")
install.packages("ggplot2")
library(mcsm)
library(ggplot2)
library(actuar)
library(actuar) # load the actuar library - used for loss distribution functions - help(package="actuar") to see the functions or data(package="actuar") to see the datasets
library(moments) # the moments package has functions to calculate moments, central moments, cumulants and other sample statistics
library(VGAM)
library(cubature)

set.seed(1410) # Make the sample reproducible
randLogistic <-rlogis(n=100000, location = 0, scale = 0.55133)
randNorm <- rnorm(n=100000)
randDeviates <- data.frame(randLogistic, randNorm)  # combine two vectors into a dataframe
# Standard Logistic and Standard Normal
# Varying the bin width on a histogram
# Three variations on the histogram.
# 1.  A frequency polygon;
# 2. a scatterplot with both size and height mapped to frequency;
# 3. a heatmap representing frequency with colour.
# Varying the bin width on a histogram of the logistic distribution
qplot(randLogistic, geom = "histogram", binwidth = 1, xlim=c(-5,5),ylim=c(0,25000),main="100,000 Simulations of the Standard Logistic Distribution (binwidth = 1)")
qplot(randLogistic, geom = "histogram", binwidth = 0.1,xlim=c(-5,5),ylim=c(0,3000), main="100,000 Simulations of the Standard Logistic Distribution (binwidth = 0.1)")
# Three variations on the histogram - The Random Logistic Graphs
d <- ggplot(randDeviates, aes(randLogistic)) + xlim(-5, 5)+ ylim(0,3000)
d + stat_bin(aes(ymax = ..count..), binwidth = 0.1, geom = "area")
d + stat_bin(aes(size = ..density..), binwidth = 0.1, geom = "point", position="identity")
d + stat_bin(aes(y=1, fill = ..count..), binwidth = 0.1, geom = "tile", position="identity") + scale_y_continuous("")

# Varying the bin width on a histogram of the normal distribution
qplot(randNorm, geom = "histogram", binwidth = 1,xlim=c(-5,5),ylim=c(0,25000),main="100,000 Simulations of the Standard Normal Distribution (binwidth = 1)")
qplot(randNorm, geom = "histogram", binwidth = 0.1,xlim=c(-5,5),ylim=c(0,3000),main="100,000 Simulations of the Standard Normal Distribution (binwidth = 0.1)")
# Three variations on the histogram - the Random Normal Graphs
d <- ggplot(randDeviates, aes(randNorm)) + xlim(-5, 5) + ylim(0,3000)
d + stat_bin(aes(ymax = ..count..), binwidth = 0.1, geom = "area")
d + stat_bin(aes(size = ..density..), binwidth = 0.1, geom = "point", position="identity")
d + stat_bin(aes(y=1, fill = ..count..), binwidth = 0.1, geom = "tile", position="identity") + scale_y_continuous("")
#THE LOGISTIC vs. the NORMAL
library(actuar)
x1 <- c(2)
mu_ = 0
sigma_ = 1
location_ = 0
scale_ = 0.55133
# plot original data (at y-value = ylevel), and the y-axis black line:
#plot(x1,xlab=" ", ylab=" ",main=" ", xlim = c(0.00001,5),ylim=c(0,1),type="n",
#col.axis="black",
#col.lab="black",
#col.main="black")
#title(xlab="x ",col.lab="black")
#title(ylab="density",col.lab="black")
#title(col.lab="black",      
#      main="The Pareto Distribution",outer=FALSE)
plot(x1,xlim = c(-3,3),ylim=c(0,0.45),xlab=" ", ylab=" ",main=" ")
title(xlab="x ",col.lab="black")
title(ylab="density",col.lab="black")
title(col.lab="black",      
      main="The Normal pdf vs. the Logistic pdf",outer=FALSE)
# define the function used to draw the normal pdf
truedens1 = function(x) { return(dnorm(x, mean = mu_, sd = sigma_, log = FALSE)) }
# define the function used to draw the logistic pdf
truedens2 = function(x) { return(dlogis(x, location = location_, scale = scale_, log = FALSE)) }
# draw the density line 
curve(truedens1, -3, 3, add=TRUE, col="black")
curve(truedens2, -3, 3, add=TRUE, col="red")
legend("topright",legend=c("dnorm(x,mean=0,sd = 1)","dlogis(x,location=0,scale=0.55133)"),
lty=1,lwd=2,pch=21,col=c("black","red"),
ncol=1,bty="n",cex=0.8,
text.col=c("black","red"),
inset=0.01)


# SECTION    COMMENT DESCRIPTION
# Purpose    To calculate the VaR, CTE and TCV (as well as their varinaces) for a distribution
# Inputs     Distributional parameters - different for each probability distribution, n - the number of samples, B - the number of regenerations,
#            p-vector - a vector of probabilities used to find the VaR
# Assumes    That there are B regenerations of samples of size n from the same probability distribution (similar to bootstrapping, only regenerating
#	     a sample and recalculating the estimators instead of resampling from the same sample
# Returns    The skewness, kurtosis, VaR_mean, VaR_median, VaR_75, VaR_95, CTE_mean, CTE_50, CTE_75, CTE_95, 
#            TCV_mean (downside semideviation), TCV_median, TCV_75, TCV_95 as well as the variance for each of these measures



# THE LEGEND
# The suffix x denotes a sample statistic
# The suffix f denotes a closed form formula 
# The suffix i denotes an integral
# Note (memory rhyme/mnemonic device) the x side is the quantile, the percent side is the percentile (to mind one's p's and q's)
# For all distribution functions in the R programming language
#	1. Quantile functions begin with the prefix q and take a percentile p as the first argument, and they return the x value (i.e. qdist(p)=xp )
# 	2. Percentile functions begin with the prefix p and take a quantile q as the first argument, and they return a percent value (i.e. pdist(q=xp)=p )
# Thought: 1. the percentile of the median is 50% (by definition) and 2. the quantile of the mean is the arithmetic average (by definition)
# Percentile Vectors (p-vector's) contain percent values (PercentileAvg,50%,75%,95%)
# Value at Risk vectors (VaR-vect's) contain x-values (Avg,Median,VaR75,VaR95)
# Conditional Tail Expectation vectors (CTE-vect's) contain conditional expectations (CTEAvg,CTEMedian,CTE75,CTE95)
# Tail Conditional Variance vectors (TCV-vect's) contain conditional variances (TCVavg,TCVMedian,TCV75,TCV95)

#install.packages("actuar")
#install.packages("moments")
#install.packages("PerformaceAnalytics") # this function is used to install a package not found in the library
library(PerformaceAnalytics) # load the PerformanceAnalytics package which has SemiVariance, DownsideDeviance and other functions for mathematical finance
library(actuar) # load the actuar library - used for loss distribution functions - help(package="actuar") to see the functions or data(package="actuar") to see the datasets
library(moments) # the moments package has functions to calculate moments, central moments, cumulants and other sample statistics
lowerSupport = 0; upperSupport = 10000
numSamples = 10000; numQuantiles = 4                    # There are 4 percentiles/quantiles being examined: the percentile of the mean, the 50th percentile, the 75th percentile and the 95th percentile
startCount = 1; endCount = numQuantiles 			  
p_vector = c(0,0.5,0.75,0.95)      # declare/initialize a vector for the percentiles (percent values)
B = 500; n=numSamples
EmptyVector = rep(0,B); EmptyVector2 = rep(0,numQuantiles); EmptyMatrix = matrix(rep(0,B*numQuantiles),ncol=numQuantiles)
mean_xList = EmptyVector; median_xList = EmptyVector; var_xList = EmptyVector;
skewness_xList = EmptyVector; exKurtosis_xList = EmptyVector; range_xList = EmptyVector; min_xList = EmptyVector; max_xList = EmptyVector
VaR_vect_xList = EmptyMatrix; CTE_vect_xList = EmptyMatrix; TCV_vect_xList = EmptyMatrix
DistnParams = "  rnorm(n=10000,mean = 0, sd = 1)  regenerated B=500 times "


# Run the regeneration (similar to bootstrapping), with B regenerations of n samples each.
for (b in 1:B) {
    y <- rnorm(n=numSamples,mean = 0, sd = 1)   		# the formalArgs n, shape and scale are for the number of random deviates)
    x = sort(y)		                               		# the simulated sample all sorted
    mean_x = mean(x);  var_x = var(x);  length_x = length(x);      			       
    mean_xList[b] = mean(x);
    median_xList[b] = median(x);
    var_xList[b] = var(x);
    min_xList[b] = min(x);					# min(x) = the first order statistic, the smallest observation in the sample
    max_xList[b] = max(x);					# max(x) = the nth order statistic, the largest observation in the sample
    skewness_xList[b] = skewness(x);				# skewness_x <- moment(x,order=3,central=TRUE)/moment(x,order=2,central=TRUE)^1.5
    exKurtosis_xList[b] = kurtosis(x)-3;			# kurtosis_x <- moment(x,order=4,central=TRUE)/moment(x,order=2,central=TRUE)^2
    range_xList[b] = max(x) - min(x);
    var_xList[b] = var_x;
    Percentile_avg_x = length(x[x<mean(x)])/length(x);  	# the percentile of the mean (aka the percentile of the average)
    p_vector_x = p_vector;	                       		# declare/initialize a vector for the percentiles (percent values) of the simulated sample
    p_vector_x[1] = Percentile_avg_x;                   	# set the first element in the p-vecor to the percentile of the mean of the simulated sample 
    indexPt = rep(0,endCount);                          	# Index for the positions in the vector of the percentiles (the p-vectors corresponding order statistic index)

    # This vector is used to index elements of the sorted simulated sample						   
    indexPt = EmptyVector2;
    count = 1;
    for (count in startCount:endCount) {
	indexPt[count] = ceiling(p_vector_x[count]*length_x)
    }

    # While loop statement to create the vector containing (AvgX,MedianX,VaR75,VaR95)
    VaR_vect_x = EmptyVector2; 
    count = 1;
    while (count<=endCount) {
      if (count==1) 
	VaR_vect_x[count] = mean_x 	      # set the first element in the vector to the mean (arithmetic average) of the simulated sample
      else if (numSamples%%2 != 0)  {      
	VaR_vect_x[count] = x[indexPt[count]]   # the quantile just one data point for a dataset with an odd number of observations
      }                        
      else	{						
	VaR_vect_x[count] = (x[indexPt[count]]+x[(indexPt[count]+1)])/2 # the median is the average of the two middle data points for a dataset with an even number of observations
      }
      VaR_vect_xList[b,count] = VaR_vect_x[count]  # an array of VaR's with dimension Bx4
      count=count+1
    }
    
   
    # For loop to create the vecotr of Conditional Tail Expectations (CTE@AvgX,CTE@MedianX,CTE@VaR75X,CTE@VaR95X) = (TVaRAvgX,TVaR50, TVaR75,TVaR95)
    CTE_vect_x = EmptyVector2;     
    count = 1;
    for (count in (startCount):endCount) {      
	CTE_vect_x[count] = mean(x[x>VaR_vect_x[count]])   # the quantile just one data point for a dataset with an odd number of observations
	CTE_vect_xList[b,count] = CTE_vect_x[count]  # an array of VaR's with dimension Bx4                      						
    }

    # For loop to create a vector of Tail Conditional Variances (TCV@AvgX,TCV@MedianX,TCV@VaR75X,TCV@VaR95X) 
    TCV_vect_x = EmptyVector2;
    count = 1;
    for (count in (startCount):endCount) {      
	  y <- x[x>VaR_vect_x[count]]
	  TCV_vect_x[count] = sum((y-mean_x)^2)/length(y)   # the quantile just one data point for a dataset with an odd number of observations 
	  TCV_vect_xList[b,count] = TCV_vect_x[count]  # an array of VaR's with dimension Bx4                          						
    }
}

# In an effort to improve the accuracy of these estimators, and to calcuate the variance of these estimators,
# the program regenerates n random deviates B times (in a similar fashion to bootstrapping an estimator)
# Then, the average and variance of the estimators for each of the B samples (of size n) is calculated
# This process is identical to the bootstrapping process, however, the same sample is not being resampled from
# rather, the random number generator is used to generate a new sample each time. 
avg_mean = mean(mean_xList); se_mean = sd(mean_xList)/sqrt(length(mean_xList));
avg_median = mean(median_xList); se_median = sd(median_xList)/sqrt(length(median_xList));
avg_var = mean(var_xList); se_var = sd(var_xList)/sqrt(length(var_xList));
avg_min = mean(min_xList); se_min = sd(min_xList)/sqrt(length(min_xList));
avg_max = mean(max_xList); se_max = sd(max_xList)/sqrt(length(max_xList));
avg_range = mean(range_xList); se_range = sd(range_xList)/sqrt(length(range_xList));
avg_skewness = mean(skewness_xList); se_skewness = sd(skewness_xList)/sqrt(length(skewness_xList));
avg_exKurtosis = mean(exKurtosis_xList); se_exKurtosis = sd(exKurtosis_xList)/sqrt(length(exKurtosis_xList));   


# Initialize vectors to hold the VaR, CTE, and TCV values (4 quantiles for each) as well as their variances
# Six vectors are initialized here, the semi-colon is used to separate the commands
avgVaR = EmptyVector2; seVaR = EmptyVector2; avgCTE = EmptyVector2; seCTE = EmptyVector2; avgTCV = EmptyVector2; seTCV = EmptyVector2

for (count in (startCount):endCount) { 
  avgVaR[count] = mean(VaR_vect_xList[,count])
  seVaR[count] = sd(VaR_vect_xList[,count])/sqrt(length(VaR_vect_xList[,count]))
  avgCTE[count] = mean(CTE_vect_xList[,count])
  seCTE[count] = sd(CTE_vect_xList[,count])/sqrt(length(CTE_vect_xList[,count]))
  avgTCV[count] = mean(TCV_vect_xList[,count])
  seTCV[count] = sd(TCV_vect_xList[,count])/sqrt(length(TCV_vect_xList[,count]))
}



# ===================================================================================================================================================================
# SIMULATED SAMPLE STATISTICS - OUTPUT TO THE CONSOLE WINDOW
# ===================================================================================================================================================================


# Create a table that will display some common distributional measures and their standard error
avgMeasures <- rbind(round(avg_mean,4), round(avg_median,4), round(avg_min,4), round(avg_max,4), round(avg_range,4), round(avg_var,4), round(avg_skewness,4), round(avg_exKurtosis,4))
seMeasures <- rbind(round(se_mean,4), round(se_median,4),round(se_min,4),round(se_max,4),round(se_range,4), round(se_var,4), round(se_skewness,4), round(se_exKurtosis,4))
measures <- cbind(avgMeasures, seMeasures)
table <- data.frame(measures)
dimnames(table) <- list(c("Mean","Median","Min","Max","Range","Variance", "Skewness", "Excess Kurtosis"),c("   Avg Measure", "   SE Measure"))
attr(table, "row.names")
# Create a table that will display the common risk metrics: VaR, CTE and TCV
tailEx <- rbind(round(avgVaR,4), round(avgCTE,4), round(avgTCV,4))
table2 <- data.frame(tailEx)
dimnames(table2) <- list(c("VaR","CTE", "TCV"),c(" Mean   ", "   50   ","   75   ", "   95   "))
# Create a table that will display the standard error of the risk metrics
seTailEx <- rbind(round(seVaR,4), round(seCTE,4), round(seTCV,4))
table3 <- data.frame(seTailEx)
dimnames(table3) <- list(c("SE(VaR)","SE(CTE)", "SE(TCV)"),c(" Mean   ", "   50   ","   75   ", "   95   "))
# Output the tables to the console window
avgMeasureTable <-structure(table, heading = c("\nSimulated Metrics for: ", DistnParams,"\n"),class = c("anova", "data.frame"))
avgTailExTable <-structure(table2, heading = c("\nSimulated Tail Expectations for: ", DistnParams,"\n"),class = c("anova", "data.frame"))
stdErrTailExTable <-structure(table3, heading = c("\nStandard Error of the Simulated Tail Expectations for: ", DistnParams,"\n"),class = c("anova", "data.frame"))
avgMeasureTable; avgTailExTable; stdErrTailExTable



# ===================================================================================================================================================================
# EXPECTED VALUES OF THE PARAMETRIC MODEL - FORMULAIC APPROACH (Using formulas for the CTE of a normal distribution derived in E.A. Valdez, 2004)
# ===================================================================================================================================================================
Percentile_mean_f = 0.50
p_vector_f = c(Percentile_mean_f ,0.50,0.75,0.95)
mean_f =  0
median_f = 0
sd_f = 1


VaR_vect_f = rep(0,endCount)
z_q = rep(0,endCount)
CTE_vect_f = rep(0,endCount)
TCV_vect_f = rep(0,endCount)

for (j in startCount:endCount) {
  VaR_vect_f[j] = qnorm(p_vector_f[j],mean = Norm_mean, sd = Norm_sd)
  z_q[j] = qnorm(p_vector_f[j])
  CTE_vect_f[j] = Norm_mean + dnorm(z_q[j])/(1-pnorm(z_q[j]))*Norm_sd
  TCV_vect_f[j] = (1 + dnorm(z_q[j])/(1-pnorm(z_q[j]))*z_q[j])*Norm_sd^2
}

# STATISTICS OF THE PARAMETRIC MODEL - OUTPUT TO THE CONSOLE WINDOW
cat(" The Distribution and it's parameters:",DistnParams)

cat(" EXPECTED VALUES OF THE PARAMETRIC MODEL ")

cat("VaR_vect_f = [mean_f, median_f, VaR75_f, VaR95_f] = ", VaR_vect_f)

cat("CTE_vect_f = [CTE_mean_f,CTE_median_f, CTE_VaR75_f, CTE_VaR95_f] = ", CTE_vect_f)

cat("TCV_vect_f = [TCV_mean_f,TCV_median_f, TCV_VaR75_f, TCV_VaR95_f] = ", TCV_vect_f)

tailEx_actual <- rbind(round(VaR_vect_f,4), round(CTE_vect_f,4), round(TCV_vect_f,4))
table_actual <- data.frame(tailEx_actual)
dimnames(table_actual) <- list(c("VaR","CTE", "TCV"),c(" Mean   ", "   50   ","   75   ", "   95   "))
# Output the tables to the console window
actualMeasureTable <-structure(table_actual, heading = c("\nActual Metrics for the Standard Normal","\n"),class = c("anova", "data.frame"))

actualMeasureTable

# ============================================================================================================================================================
# EXPECTED AMOUNTS - INTEGRATION (integration to obtain moments and statistics of the distribution)
# ============================================================================================================================================================

lowerSupport = 0
upperSupport = 100000


# function to calculate the integral for the conditional tail expectation
CTE_integral = function(x) {
    (x-VaRp)*dnorm(x,mean = 0, sd = 1)  # xq + 1/(1-q)*integrate xq^infty (x-VaRq) f(x)dx
}

TCV_integral = function(x) {
  (x-Norm_mean)^2*dnorm(x,mean = 0, sd = 1)  # 1/(1-q)*integrate_xq^infty (x-mu)^2 f(x)dx
}


# Create the vector of the first 5 moments of the distribution (found through integration)
moments_i = rep(0,5)
k=0
for (j in 1:5) {
    k = j
    moment_integral = function(x) {
    x^k*dnorm(x,mean = Norm_mean, sd = Norm_sd) # integral for E[X^k] = int_0^inf x^k * f(x) dx
    }
    moments_i[j] = integrate(moment_integral,lowerSupport,upperSupport)[[1]]
}

# Calculate the mean, the percentile of the mean, and create the p-vector to be used to calculate the VaR's
mean_i = moments_i[1]
Norm_mean = 0
Percentile_mean_i = pnorm(Norm_mean,mean = Norm_mean, sd = 1)
p_vector_i = c(Percentile_mean_i ,0.50,0.75,0.95)


# Create and calculate vectors with the VaR's, CTE's and TCV's
VaRp_vect_i = rep(0,4)
CTEp_vect1 = rep(0,4)
CTEp_vect_i = rep(0,4)
TCVp_vect_i = rep(0,4)
for (j in 1:4) {
  VaRp_vect_i[j] = qnorm(p = p_vector_i[j],mean = 0, sd = 1)
  VaRp = VaRp_vect_i[j]
  CTEp_vect1[j] = integrate(CTE_integral,VaRp,10)[[1]]
  CTEp_vect_i[j]  = VaRp + 1/(1-p_vector_i[j])*CTEp_vect1[j]
  TCV_integration1 = integrate(TCV_integral,VaRp, 10)
  TCVp_vect_i[j] = 1/(1-p_vector_i[j])*TCV_integration1[[1]]
}


# STATISTICS OF THE PARAMETRIC MODEL - OUTPUT TO THE CONSOLE WINDOW
cat(" The Distribution and it's parameters:",DistnParams)

cat(" EXPECTED VALUES OF THE PARAMETRIC MODEL ")

cat("moments_i = [mean_i, E(X^2), E(X^3), E(X^4), E(X^5)] = ", moments_i)

cat("VaRp_vect_i = [mean_i, median_i, VaR75_i, VaR95_i] = ", VaRp_vect_i)

cat("CTEp_vect_i = [CTE_mean_i ,CTE_median_i , CTE_VaR75_i , CTE_VaR95_i] = ", CTEp_vect_i)

cat("TCVp_vect_i = [TCV_mean_i, TCV_median_i, TCV_VaR75_i, TCV_VaR95_i] = ", TCVp_vect_i)


# ============================================================================================================================================================
# GRAPHED and PLOTTED - THE STANDARD NORMAL DISTRIBUTION
# ============================================================================================================================================================

x<- rnorm(n=10000,mean = 0, sd = 1)

plot(density(x),xlim = c(-4,4),ylim=c(0,0.40),xlab=" ", ylab=" ",main="The Standard Normal Distribution")
brk = seq(length=151,from=0,by=0.10)
#hist(x,xlim = c(0,15),ylim=c(0,1),breaks = brk, prob=TRUE,col="black",border="white")
rug(x)
title(xlab="x ",col.lab="black")
title(ylab="density",col.lab="black")
title(col.lab="black",outer=FALSE)

mtext(expression(italic(f)~(bold(x))==frac(1,sqrt(2~pi)) 
                     ~phantom(0)~exp~bgroup("{",
	             list(-frac(x^2,2), 
	             ),"}")), side=3,adj=1) 

# define the true (mixture) density:
truedens1 = function(x) { return(dnorm(x,mean = 0, sd = 1)) }

# draw the density line 
curve(truedens1, -4, 4, add=TRUE, col="red")

legend("topright",legend=c("dnorm(x,mean = 0, sd = 1)","CTE75","CTE95","VaR75","VaR95","Built-in Density Estimator"),
lty=1,lwd=2,pch=21,col=c("red","green","purple","orange","blue","black"),
ncol=1,bty="n",cex=0.8,
text.col=c("red","green","purple","orange","blue","black"),
inset=0.01)

CTE_VaR75_i = CTEp_vect_i[3]
CTE_VaR95_i = CTEp_vect_i[4]
VaR75_i = VaRp_vect_i[3]
VaR95_i = VaRp_vect_i[4]
abline(v = CTE_VaR75_i, col = "green", lty=1)
abline(v = CTE_VaR95_i, col = "purple", lty=1)
abline(v = VaR75_i, col = "orange", lty=1)
abline(v = VaR95_i, col = "blue", lty=1)

# Graph 2 - the Q-Q
qqnorm(x,main="Q-Q Plot of the Normal Distribution",xlim = c(-3, 5), ylim = c(0, 15))
qqline(x)   # the closer the dots to the straight line, the closer the distribution is to a normal distribution

# Graph 3 - the box plot with notches at the median
boxplot(x,las=1,
main="Boxplot of the Normal Distribution",
varwidth=TRUE,
notch=TRUE,
xlim = c(0.5, 3.5), ylim = c(0, 15)) 



# ============================================================================================================================================================
# NORMAL vs. LOGISTIC
# ============================================================================================================================================================
# 100,000 simulations of a standard normal distribution and a logistic distribution with location = 0 and scale = 0.55
# The following program uses R's built-in psuedo-random number generator along with the ggplot2 package
# to graph the logistic and the normal (3 variations of the histogram are used: frequency bars, scatterplot points, and heatmaps)
#install.packages("ggplot2")
library(ggplot2)
randNorm <- rnorm(n=100000)
randLogistic <- rlogis(n=100000, location = 0, scale = 0.55133)  
randDeviates <- data.frame(randLogistic, randNorm)  # combine two vectors into a dataframe


# Varying the bin width on a histogram of the logistic distribution
qplot(randLogistic, geom = "histogram", binwidth = 1, xlim=c(-4,4),ylim=c(0,40000),main="100,000 Simulations of the Logistic Distribution (binwidth = 1)")
qplot(randLogistic, geom = "histogram", binwidth = 0.1,xlim=c(-4,4),ylim=c(0,5000), main="100,000 Simulations of the Logistic Distribution (binwidth = 0.1)")
# Three variations on the histogram - The Random Logistic Graphs
d <- ggplot(randDeviates, aes(randLogistic)) + xlim(-4, 4)+ ylim(0,5000)
d + stat_bin(aes(ymax = ..count..), binwidth = 0.1, geom = "area")
d + stat_bin(aes(size = ..density..), binwidth = 0.1, geom = "point", position="identity")
d + stat_bin(aes(y=1, fill = ..count..), binwidth = 0.1, geom = "tile", position="identity") + scale_y_continuous("")

# Varying the bin width on a histogram of the normal distribution
qplot(randNorm, geom = "histogram", binwidth = 1,xlim=c(-4,4),ylim=c(0,40000),main="100,000 Simulations of the Standard Normal Distribution (binwidth = 1)")
qplot(randNorm, geom = "histogram", binwidth = 0.1,xlim=c(-4,4),ylim=c(0,5000),main="100,000 Simulations of the Standard Normal Distribution (binwidth = 0.1)")
# Three variations on the histogram - the Random Normal Graphs
d <- ggplot(randDeviates, aes(randNorm)) + xlim(-4, 4) + ylim(0,5000)
d + stat_bin(aes(size = ..density..), binwidth = 0.1, geom = "point", position="identity")
d + stat_bin(aes(y=1, fill = ..count..), binwidth = 0.1, geom = "tile", position="identity") + scale_y_continuous("")


# ============================================================================================================================================================
#THE NORMAL, LOGISTIC & LAPLACE DISTRIBUTIONS
# ============================================================================================================================================================

library(actuar); library(VGAM);
x1 <- c(2);

plot(x1,xlim = c(-3,3),ylim=c(0,0.8),xlab=" ", ylab=" ",main=" ");
title(xlab="x ",col.lab="black");
title(ylab="density",col.lab="black");
title(col.lab="black", main="The Normal, Logistic and Laplace Distributions",outer=FALSE);

# define the functions used to draw the line graphs of the pdf's
truedens1 = function(x) { return(dnorm(x, mean = 0, sd = 1)) }
truedens2 = function(x) { return(dlogis(x, location = 0, scale = 0.55)) }
truedens3 = function(x) { return(dlaplace(x, location = 0, scale = 0.707)) }

# draw the density line 
curve(truedens1, -3, 3, add=TRUE, col="black")
curve(truedens2, -3, 3, add=TRUE, col="green")
curve(truedens3, -3, 3, add=TRUE, col="blue")


legend("topright",legend=c("dnorm(x,mean=0,sd = 1)","dlogis(x,location=0,scale=0.55)", "dlaplace(x,location=0,scale=0.707)"),
lty=1,lwd=2,pch=21,col=c("black","green","blue"),ncol=1,bty="n", 
cex=0.8, text.col=c("black","green","blue"),inset=0.01)



# ===================================================================================================================================================================
# OTHER POSSIBLE SIMULATED SAMPLE STATISTICS - ASSIGNMENT STATEMENTS FOR MEASURES OF CENTRAL TENDENCY, SPREAD AND SKEWNESS
# ===================================================================================================================================================================                 
k = 6			                           			# number of moments to display	
moments_x <- all.moments( x, order.max=k )         			# moments_x = [(moment(x,order =1), ....., moment(x,order=k)] =  [sum(x^0)/length(x), ...., sum(x^k)/length(x))
centralMoments_x <- all.moments( x, order.max=k , central = TRUE) 	# k-th central moment about the mean  x = [sum((x-mean(x))^0)/length(x), ...., sum((x-mean(x))^k/length(x)) 
downsideMean_x = mean(x[x>mean(x)])					# The average of values greater than the mean - should match CTE_vect[1]

objects()  # view the collection of objects currently stored in the workspace



d + stat_bin(aes(ymax = ..count..), binwidth = 0.1, geom = "area")

# Kernel Density Estimation
# Graphed and Plotted
# THE DATA - THE DAILY PERCENTAGE CHANGE IN THE S&P 500 STOCK MARKET INDEX
# This index was chosen as it encompasses the stock prices of 500 of the worlds largest multinational corporations


SnPFull<-read.csv("SnP_Full_LT3.csv")
SnPsince1950<-SnP[[1]]
# collect them into a single sample of 15418 data points:
n <- length(SnPsince1950)

# define the true (mixture) density:
truedens = function(x) { return( dnorm(x,.03,0.967)) }

# compute the centered interval density estimator:
centintdens = function(x) {
    sum = 0
    for (i in 1:n) {
	if (abs(SnPsince1950[i]-x) < h)
	    sum = sum + 1
    }
    return(sum / 2 / n / h)
}

# choose a kernel:
K = function(x) {dnorm(x)}

# compute the kernel density estimator:
kerdens = function(x) {
    sum = 0
    for (i in 1:n) {
	sum = sum + K((x-SnPsince1950[i])/h)
    }
    return(sum / n / h)
}

# plotting routine (avoiding problems of "plot" & "curve"):
plotfunction = function(ff, from=xlim[1], to=xlim[2], col="black",
	add=(dev.cur()!=1), xlim=c(0,1) ) {
    numpoints = 1000;
    xlist = ylist = NULL;
    ymin = +Inf;
    ymax = -Inf;
    for (i in 1:numpoints) {
        xval = from + (to-from) * i / numpoints;
        yval = ff(xval);
        xlist = c(xlist, xval);
        ylist = c(ylist, yval);
	if (yval < ymin)
	    ymin = yval;
	if (yval > ymax)
	    ymax = yval;
    }
    if (add==FALSE) {
	plot( c((from+to)/2, (ymin+ymax)/2), type='n',
		xlim=c(from,to), ylim=c(ymin,ymax), xlab="x",
		ylab=paste( deparse(substitute(ff)), "(x)", sep="" )
		);
    }
    lines(xlist, ylist, col=col);
}


# The S&P500 - Data From January 1950 to April 2011
# PLOTTED & GRAPHED

# compute the left and right ends of the graph, and the data dots' y level:
range = max(SnPsince1950)-min(SnPsince1950)
leftend = min(SnPsince1950) - 0.1*range
rightend = max(SnPsince1950) + 0.1*range
ylevel = -0.2
ydata <- rep(ylevel,n)

# plot original data (at y-value = ylevel), and the y-axis black line:
plot(SnPsince1950, ydata,xlab=" ", ylab=" ",main=" ", ylim=c(2*ylevel,1),type="n",
col.axis="blue",
col.lab="red",
col.main="darkblue")
title(xlab="Daily Percentage Change (%) in the S&P 500 ",col.lab="blue")
title(ylab="Probability Density",col.lab="blue")
title(main="The Daily Percentage Change in the S&P Since 1950",col.lab="blue")

lines(c(leftend,rightend), c(0,0), col="black")
x<-par("usr")
rect(x[1],x[3],x[2],x[4],col="lightgray ")
points(SnPsince1950, ydata, ylim=c(2*ylevel,1))

# plot histogram:
h=0.1; hist(SnPsince1950, col="white",border="black", xlab="Percentage Change", 
main="Daily Percentage Change in the S&P 500",breaks=200, freq=FALSE, add=TRUE)

# plot the estimated density in red N(.03,.97)
curve(truedens, leftend, rightend, add=TRUE, col="black")

# plot centered interval density:
h=0.1; plotfunction(centintdens, leftend, rightend, col="red")

# plot kernel density estimator:
h=0.1; curve(kerdens, leftend, rightend, add=TRUE, col="orange")

# try R's built-in density-estimation function:
zz = density(SnPsince1950) ; xR = zz$x ; yR = zz$y
lines(xR, yR, col="purple")

#Update R to the newest versoin
Install.packages(“installr”);
updateR();

#install useful packages
install.packages(c("data.table","devtools","dplyr","ggplot2","hash","scales","sqldf","ssh","tidyr","tidyverse"))
tinytex::install_tinytex()

#Determine the path of the installation directory and the home directory
R.home() #installation
path.expand("~") # home
.libPaths() #libraries

#R startup file – edit the .Rprofile.site file in the etc folder of the installation directory

#set a CRAN mirror and set graphics options
local({r<-getOption("repos")
r["CRAN"]<-"https://repo.miserver.it.umich.edu/cran/"
options(repos=r)}) 
options(tab.width = 2) ;options(width = 130);options(graphics.record=TRUE); 

#attach libraries and R source programs to the session and print an opening and closing note
.First <- function(){
 library(data.table);library(dplyr);library(ggplot2);library(hash);
 library(scales);library(sqldf);library(ssh);library(tidyr);library(tidyverse);
 cat("\n\n\nDave's R Session Opened on", date(), "\n")
 cat("The working directory is",getwd(), "\n")
 if(file.exists("c:/R/myfunc.r")){
        source("c:/R/myfunc.r")
                                pause(1)  }}
.Last <- function(){
 cat("\nGoodbye Dave ", date(), "\n")}
user_id=toupper(Sys.info()[["user"]])
save_location =  sprintf("C:/Users/%s/Desktop/", user_id)
setwd(save_location)
pw="54321"

###################################################################################################
##                      Graphing Simulated Data with Shiny                                       ##
###################################################################################################
library(dplyr);library(hash);library(shiny);library(sqldf)
ui <- fluidPage(
  selectInput(inputId="differential_var", label=NULL, choices=c("risk_class","territory"), selected = NULL, multiple = FALSE, selectize = TRUE, width = NULL, size = NULL),
  plotOutput("graph1")
) 
#server component
server <- function(input, output) {
	output$graph1 <-  renderPlot({
		runifdisc<-function(n, min=0, max=1) sample(min:max, n, replace=T)
		rb <- data.frame(index=1:90, term_eff_date=rep(c(Sys.Date()+ runifdisc(10,-365,0)),9),risk_class=sample( 1:4, 90, replace=TRUE, prob=c(0.1, 0.6, 0.25, 0.05) ),territory=rep(seq(from=7000,to=7400,by=50),10), policy_number=seq(from=5010,to=5900,by=10))
		rt<- data.frame(terr=seq(from=7000,to=7400,by=50),terr_differential=round(rnorm(n=9,mean=1,sd=.2),3))
		rb<- rb %>% left_join(.,rt,by=c("territory"="terr"))%>% mutate( territory_differential=ifelse(is.na(terr_differential),1,terr_differential)) %>% select(-c(terr_differential))
		rb <- rb %>% mutate( risk_class_differential = case_when(risk_class==1~rnorm (n=1,mean=1.1,sd=.25),risk_class==2~1,risk_class==3~rnorm (n=1,mean=.9,sd=.2),risk_class==4~rnorm (n=1,mean=1.4,sd=.3)),
							 base_rate = 800,
							 loss_cost=base_rate * risk_class_differential * territory_differential)
		var_selection=input$differential_var
		hash_var<-hash(c("risk_class","territory"),c("Risk Class","Rating Territory"))
		rb_summary<- rb %>% group_by_at(c(var_selection)) %>% summarise(avg_loss_cost=mean(loss_cost),exposures=n_distinct(policy_number))
		rb_summary
		x<-as.numeric(as.list(sqldf(sprintf("select %1$s from rb_summary",var_selection)))[[1]])
		y1<-as.list(sqldf("select avg_loss_cost from rb_summary"))[[1]]
		ylim1=ceiling(max(y1)*1.1/1000)*1000
		y2<-as.list(sqldf("select exposures from rb_summary"))[[1]]
		ylim2=max(y2)*1.5
		aspect_ratio=max(y1)/max(y2)
		varlabel<-hash_var[[var_selection]]
		label1 = "Expected Loss Cost and Exposures by "
		p<-ggplot(rb_summary, aes(x)) 
		p<-p+geom_col(aes(y=y2* (aspect_ratio = aspect_ratio)),fill="grey")
		p<-p+ geom_line(aes(y = y1,),size=1.1,linetype=2)
		p<-p+scale_y_continuous(labels = dollar,breaks = seq(0,ylim1,by=round(ylim1/10,0)),
								  sec.axis =  sec_axis(~./(aspect_ratio=aspect_ratio),name = "Earned Exposure",breaks = seq(0,ylim2,by = ylim2/4)))
		p<-p+ggtitle(label=paste0(label1=label1, varlabel)) 
		p<-p+ylab("Average Loss Cost")
		p<-p + scale_x_continuous(name=varlabel)
		p
	  }) #end of renderPlot()
  } #end of the server component
#run the shinyApp
shinyApp(ui = ui, server = server)


###################################################################################################
##  Simulate a Graph with Shiny - Each Selection Triggers a New Simulation and a New Plot        ##
###################################################################################################
library(dplyr);library(plotly);library(sqldf);library(hash);library(shiny)
runifdisc<-function(n, min=0, max=1) sample(min:max, n, replace=T)
ui <- fluidPage(
  selectInput(inputId="differential_var", label=NULL, choices=c("risk_class","territory"), selected = NULL, multiple = FALSE, selectize = TRUE, width = NULL, size = NULL),
  actionButton(inputId="refresh",label="Refresh"),
  fluidRow(column(width=5,offset=2,plotOutput("graph1"))),
  fluidRow(),
  fluidRow(verbatimTextOutput("stats1"))
) 

runifdisc<-function(n, min=0, max=1) sample(min:max, n, replace=T)

					 
#server component
server <- function(input, output) {

  rb<-eventReactive(input$refresh, {data.frame(index=1:90, term_eff_date=rep(c(Sys.Date()+ runifdisc(10,-365,0)),9),risk_class=sample( 1:4, 90, replace=TRUE, prob=c(0.1, 0.6, 0.25, 0.05) ),territory=rep(seq(from=7000,to=7400,by=50),10), policy_number=seq(from=5010,to=5900,by=10))%>% left_join(.,data.frame(terr=seq(from=7000,to=7400,by=50),terr_differential=round(rnorm(n=9,mean=1,sd=.2),3)),by=c("territory"="terr"))%>% 
  mutate( territory_differential=ifelse(is.na(terr_differential),1,terr_differential)) %>% select(-c(terr_differential)) %>%
  mutate( risk_class_differential = case_when(risk_class==1~rnorm (n=1,mean=1.1,sd=.25),risk_class==2~1,
  risk_class==3~rnorm (n=1,mean=.9,sd=.2),risk_class==4~rnorm (n=1,mean=1.4,sd=.3)),
                     base_rate = 800,
					 loss_cost=base_rate * risk_class_differential * territory_differential)})
 
  rb_summary <- reactive({ rb() %>% group_by_at(c(input$differential_var)) %>% summarise(avg_loss_cost=mean(loss_cost),exposures=n_distinct(policy_number))})
  
  output$stats1 <- renderPrint({
	summary(rb_summary()) 
	})

  output$graph1 <-  renderPlot({
    hash_var<-hash(c("risk_class","territory"),c("Risk Class","Rating Territory"))
    varlabel<-hash_var[[input$differential_var]]
    title <- paste0('Differential Comparison for ', varlabel  )
    xaxis <- list(title = varlabel, showgrid = TRUE)
    yaxis <- list(side = 'left', title = 'Differential', showgrid = TRUE, zeroline = TRUE, ticks="inside")
    yaxis2 <- list(side = 'right', overlaying = "y", title = 'Exposure %', showgrid = FALSE, zeroline = TRUE,tickformat = '.1%')
    legend <- list(orientation = 'h', borderwidth=1, xanchor="center", x =0.5)
    margin <- list(r=75)
    plot_ly(data = rb_summary(),x=rb_summary()[,1],y = rb_summary()$exposures, type = 'bar') %>% add_trace(y = rb_summary()$avg_loss_cost, type = 'scatter', mode = 'lines') %>%
      layout(title = title,
             xaxis = xaxis,
             yaxis = yaxis,
             yaxis2 = yaxis2,
             legend = legend,
             margin = margin)
    })

} #end of the server component
#run the shinyApp
#trace(server,browser,exit=browser)
shinyApp(ui = ui, server = server)

###################################################################################################
##                      Simulated Data with Shiny                                                ##
###################################################################################################
library(dplyr);library(plotly);library(sqldf);library(hash);library(shiny)

#user defined functions
runifdisc<-function(n, min=0, max=1) sample(min:max, n, replace=T)

generatePlotly <- function(inputdf, var1, var2,var_chosen){
  hash_var<-hash(c("risk_class","territory"),c("Risk Class","Rating Territory"))
  varlabel<-hash_var[[var_chosen]]

  title <- paste0('Differential Comparison for ', varlabel  )
  xaxis <- list(title = varlabel, showgrid = TRUE)
  yaxis <- list(side = 'left', title = 'Differential', showgrid = TRUE, zeroline = TRUE, ticks="inside")
  yaxis2 <- list(side = 'right', overlaying = "y", title = 'Exposure %', showgrid = FALSE, zeroline = TRUE,tickformat = '.1%')
  legend <- list(orientation = 'h', borderwidth=1, xanchor="center", x =0.5)
  margin <- list(r=75)
  plot_ly(data = inputdf,x=var1,y=var2 , type = 'bar') %>% add_trace(y = inputdf$avg_loss_cost, type = 'scatter', mode = 'lines') 
  # %>%
    # layout(title = title,
    #        xaxis = xaxis,
    #        yaxis = yaxis,
    #        yaxis2 = yaxis2,
    #        legend = legend,
    #        margin = margin)
}

#ui component
ui <- fluidPage(
  wellPanel(selectInput(inputId="differential_var", label=NULL, choices=c("risk_class","territory"), selected = NULL, multiple = FALSE, selectize = TRUE, width = NULL, size = NULL),
  actionButton(inputId="refresh",label="Refresh")),
  fluidRow(column(width=5,offset=2,plotlyOutput("graph1")))
  # 
  # fluidRow(),
  # fluidRow(verbatimTextOutput("stats1"))
) 

#server component
server <- function(input, output) {


  
  rb<-eventReactive(input$refresh, {data.frame(index=1:90, term_eff_date=rep(c(Sys.Date()+ runifdisc(10,-365,0)),9),risk_class=sample( 1:4, 90, replace=TRUE, prob=c(0.1, 0.6, 0.25, 0.05) ),territory=rep(seq(from=7000,to=7400,by=50),10), policy_number=seq(from=5010,to=5900,by=10))%>% left_join(.,data.frame(terr=seq(from=7000,to=7400,by=50),terr_differential=round(rnorm(n=9,mean=1,sd=.2),3)),by=c("territory"="terr"))%>% 
  mutate( territory_differential=ifelse(is.na(terr_differential),1,terr_differential)) %>% select(-c(terr_differential)) %>%
  mutate( risk_class_differential = case_when(risk_class==1~rnorm (n=1,mean=1.1,sd=.25),risk_class==2~1,
  risk_class==3~rnorm (n=1,mean=.9,sd=.2),risk_class==4~rnorm (n=1,mean=1.4,sd=.3)),
                     base_rate = 800,
					 loss_cost=base_rate * risk_class_differential * territory_differential)})
 
  rb_summary <- reactive({ rb() %>% group_by_at(c(rating_var1())) %>% summarise(avg_loss_cost=mean(loss_cost),exposures=n_distinct(policy_number))})
  rating_var1 <- reactive({if (input$differential_var=="") { return("")} else { return( input$differential_var) } })
  graph_x<-reactive({rb_summary() %>% select(c(rating_var1()))})
  graph_y<-reactive({rb_summary() %>% select(c("exposures"))  })
  
#   output$stats1 <- renderPrint({
# 	summary(rb_summary()) 
# 	})
  
  #Render the impacts plot on the UI
  output$graph1 <- renderPlotly({
    #only render (update) if the update actionButton is clicked, or if rerating occurs - but update actionButton must have been clicked at least once clicked
    if (input$refresh > 0 ) {
      isolate(
        generatePlotly(inputdf=rb_summary(), var1=rb_summary() %>% select(c(rating_var1())),var2= rb_summary() %>% select(c("exposures")) ,var_chosen=rating_var1())
      )
    } else {
      return()
    }
  })

} #end of the server component
#run the shinyApp
# trace(generatePlotly,browser,exit=browser)
shinyApp(ui = ui, server = server)

###################################################################################################
## TITLE:   SoDA Examples                                                                        ##
## AUTHOR:  Dave J                                                                               ##
## PURPOSE: To consolidate the examples from the book                                            ##
##          Software for Data Analysis: Programming with R                                       ##
## NOTES:   Pay attention to the setwd() below and change the working directory depending        ##
##          on which computer you are working on.                                                ##
##          Install the following packages before running this code:                             ##
##          install.packages(c("gam","ggfortify","HSAUR","SoDA"));                               ##
###################################################################################################
rm(list=ls(all=TRUE)) 
library(gam);library(ggfortify);library(HSAUR);library(SoDA);library(hash)
#data from pafko.com/tycho about the declination of Mars (the angle the planet makes with the equator)
setwd("C:/Users/SJF/OneDrive - Economical Insurance/Documents/Data")
#setwd("C:/R")
getwd()
mars<-read.csv("mars.csv",skip=5,as.is=TRUE)
#help(package = "gam")
data(clouds)
data(kyphosis)
class(kyphosis)
typeof(kyphosis)
names(kyphosis)
kyphosis[1:3,] # select the top three rows
#  Kyphosis Age Number Start
#1   absent  71      3     5
#2   absent 158      3    14
#3  present 128      4     5
n<-length(kyphosis$Age) #row count
# 81
kyphosis[1,]$Kyphosis # Unique values
#[1] absent
#Levels:
#[1] "absent"  "present"

packageDescription("gam") # Short description
#library(help=gam)
ls("package:gam") # List functions
lsf.str("package:gam") # List functions with parameters
list.files(system.file(package="gam")) # List system files for package
#demo(package = .packages(all.available = TRUE)) # List all available demos
#demo(package = "SoDA") # List demo for the SoDA package
demo(searchList) # Run Demo
#RSiteSearch("gam") # Search R site for string
#data(package="gam") # Get list of available datasets for package
# Data from an experiment investigating the use of massive amounts of silver iodide (100 to 1000 grams per cloud) in cloud seeding to increase rainfall. 
Declination<-mars$Declination
Date<-mars$Date
Date2<-mars[["Date"]]
Age<-kyphosis$Age
Number<-kyphosis$Number
plot(Date,Declination)
dev.off(2) #close the graphics device
quantile(Declination)
#?quantile
#fit a GAM:
fit1<-gam(Kyphosis~lo(Age)+lo(Number)+lo(Start), family=binomial, data=kyphosis)
summary(fit1)
# get the option for hte number of digits
getOption("digits")
options(digits=8)
formalArgs(jitter)
for(j in names(mars)) print(class(mars[,j]))
sapply(mars,class)
###################################################################################################
## FUNCTION OBJECTS AND FUNCTION CALLS                                                           ##
###################################################################################################
#pause(x) pauses for x seconds and prints the time to the window each second
pause <- function(sec) for (i in 1:sec)
{ cat(format(Sys.time(), "%X"),"\n")
  date_time<-Sys.time() #prints the time each second for x seconds
  while((as.numeric(Sys.time()) - as.numeric(date_time))<1){} 
}
#function to reverse a string
strReverse <- function(x)
{
  sapply(lapply(strsplit(x, NULL), rev), paste, collapse = "")
}
stopiferror <- function(cond) 
{  if (cond==1) 
	{message(deparse(substitute(cond)), " has an error")  
		 while (TRUE) {}
	}
}
#define some objects related to the Canadian provinces
provinces<-c("AB","BC","MB","NB","NL","NS","NU","NT","ON","PE","QC","SK","YT")
region_provinces<-hash(c("CW","AT","AB","ON"),c("'AB','NB','NS','ON','PE','QC'","'NB','NS','PE'","'AB'","'ON'"))
region_names<-hash(c("CW","AT","AB","ON"),c("Country Wide","Atlantics","Alberta","Ontario"))
#show the region name of CW
region_names[["CW"]]
#show the provinces in CW
region_provinces[["CW"]]
#computing an additive summary for all nodes of a binary tree
binaryCount<-function (nodes, leafValues) 
{
    nL <- length(leafValues)
    nN <- nrow(nodes)
    left <- nodes[, 1]
    right <- nodes[, 2]
    left <- ifelse(left < 0, -left, left + nL)
    right <- ifelse(right < 0, -right, right + nL)
    count <- c(leafValues, rep(NA, nN))
    while (any(is.na(count))) 
	#message(iter, ": ", sum(is.na(count)))
    count <- c(leafValues, count[left] + count[right])
    count[-seq(length = nL)]
}
###################################################################################################
#edit the pause function in a separate editor with the trace() function and the edit=TRUE optional argument
#trace(pause,edit=TRUE)
#trace on both the entry into the function and exit out of the function
#trace(pause,browser,exit=browser)
pause(2)
#trace-and-browse session with the function pause() - step through subexpressions with the "n" command
#trace(pause,browser)
#pause(2)
for(what in c("p","l","b")) 
{plot(Date,Declination,type=what)
pause(3)}
dev.off(2)
# Dotplot is a function in the Lattice package
find("dotplot")
library(lattice)
find("dotplot")
#package:lattice
library(mgcv) #package that also has the gam function
fit1<-mgcv::gam(Kyphosis~lo(Age)+lo(Number)+lo(Start), family=binomial, data=kyphosis) #specifies that the mgcv package's gam() function should be used and not the gam package's gam function with the :: operator
formula<-rainfall~seeding+(sne+cloudcover+prewetness+echomotion)+time
model<-lm(formula,data=clouds)
model

terms(formula)
lm(formula = formula, data = clouds)

#Coefficients:
#         (Intercept)            seedingyes                   sne  
#             6.82235               1.01320              -0.91086  
#          cloudcover            prewetness  echomotionstationary  
#             0.00565               1.84379               2.16799  
#                time  
#            -0.03212  
model2<-update(model,~ . - sne -seeding:sne) # update the (.) precending model by taking out two variables
plot(resid(model),resid(model2))
pause(2)
abline(0,1)
#identify(resid(model),resid(model2))
dev.off(2)

upd<-function(drop){
model2<-update(model,drop)
plot(resid(model),resid(model2))
abline(0,1)
model2
}
modelSne<-upd(~ . - sne - seeding:sne)
modelSne
pause(2)
modelCover<-upd(~ . - cloudcover - seeding:cloudcover)
modelCover
pause(2)
modelCover<-upd(~ . - echomotion - seeding:echomotion)
modelCover
pause(2)
dev.off(2)
#object that describes all of the terms implied by this model formula
terms(~ x0 * (x1+x2))
dropFormula<-function(original, drop) 
{
    factors <- attr(terms(as.formula(original)), "factors")
    row <- match(drop, rownames(factors))
    whichTerms <- factors[row, ] == 1
    labels <- colnames(factors)[whichTerms]
    text <- paste("~ . ", paste("-", labels, collapse = " "))
    eval(parse(text = text))
}
formula<-y~x0*(x1+x2)
terms(formula)
fMatrix<-attr(terms(formula),"factors")
fMatrix
fMatrix["x1",]
whichTerms<-fMatrix["x1",]==1
whichTerms
colnames(fMatrix)
colnames(fMatrix)[whichTerms]
dropModel<-function(model,drop){
    model2 <- update(model, dropFormula(model, drop))
    plot(resid(model), resid(model2), xlab = "Original Residuals", 
        ylab = paste("Residuals after dropping", drop))
    abline(0, 1)
    model2
}
# Original call to remove the sne variable from the linear model
modelSne<-upd(~ . - sne - seeding:sne)
modelSne
# After creating the dropFormula and dropModel function we can call the procedure in a more simple way
modelSne2<-dropModel(model,"sne")
modelSne2
pause(4)
###################################################################################################
## TRACING, EDITING, AND INTERACTIVE DEBUGGING                                                   ##
###################################################################################################
#call recover from the lowest relevant function call to debug interactively at the time of error
#options(error=recover)
#save allthe data in the calls that were active at the time the error occurred then call debugger later on
#options(error=dump.frames);
#debugger()
#send the function to the text editor
#trace(zapsmall,edit=TRUE)
#reassign zapsmall so that it will start with the browser and with the call to trace()
#trace(zapsmall,browser) 
#send the function to the text editor once again and notice the change in the function definition
#trace(zapsmall,edit=TRUE)
zapsmall(c(1.001,2.006,.006,.005),digits=2) #press "n" at each subexpression when in browse mode
#undo the open with browser behavior using the untrace() function
#untrace(zapsmall)
binaryCount <- function(nodes, leafValues) {
nL <- length(leafValues)
nN <- nrow(nodes)
left <- nodes[,1]; right <- nodes[, 2]
left <- ifelse(left<0, -left, left + nL)
right <- ifelse(right<0, -right , right + nL)
count <- c(leafValues, rep(NA, nN))
while(any(is.na(count)))
count <- c(leafValues, count[left] + count[right])
count[-seq(length=nL)]
}
# the binaryCount function uses the hclust example from the stats package
#example(hclust)
head(UScitiesD)
head(USArrests)
#nodeArea <- binaryCount(usTree@nodes, Area)
library(ggfortify)
autoplot(kmeans(USArrests, 3), data = USArrests, label = TRUE, label.size = 3)
pause(2)
devoff(3)
#Using the trace() function
#trace(aov,recover)
#trace(aov,exit=browser)
#trace(aov,browser,exit=browser)
#trace(.Fortran,recover)
#trace(aov,edit=TRUE)
#untrace(aov)
aov(yield ~ N + K + Error(block/(N + K)), data=npk)
###################################################################################################
## CONDITIONS: ERRORS AND WARNINGS                                                               ##
###################################################################################################
1+xyz
withCallingHandlers(1+xyz, error=function(e) cat("<error>"))
#define xyz and repeat
xyz=2
1+xyz
withCallingHandlers(1+xyz, error=function(e) cat("<error>"))
#remove all of the objects
rm(list=ls());
#xyz has not been defined and is used in the expr argument of the tryCatch handler function
1+xyz
tryCatch(1+xyz, error=function(e) cat("<you've got an error>\n"))
#define xyz and repeat
xyz=2
1+xyz
tryCatch(1+xyz)
# tryCatch.W.E taken from the demo(error.catching)
tryCatch.W.E <- function(expr){
W <- NULL
    w.handler <- function(w){ # warning handler
      W <<- w
       invokeRestart("muffleWarning")
     }
  list(value = withCallingHandlers(tryCatch(expr, error = function(e) e),warning = w.handler),warning = W)
}
log(2)
str( tryCatch.W.E( log( 2 ) ) )
log(-1)
str( tryCatch.W.E( log( -1) ) )
log("a")
str( tryCatch.W.E( log("a") ) )
###################################################################################################
## R PACKAGES: CREATE A PACKAGE AND THEN DELETE IT                                               ##
###################################################################################################
SoDA2Objects <- c("geoXY", "geoDist", "packageAdd")
package.skeleton("SoDA2", SoDA2Objects, path = "C:/R")
dir.create("C:/R/SoDA2/data")
mars<-read.csv("mars.csv",skip=5,as.is=TRUE)
dowNames <-c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday","Saturday")
save(mars,dowNames, list = character(),file = "C:/R/SoDA2/data/marsDOW.rda")
rm(list=ls(all=TRUE)) 
load("C:/R/SoDA2/data/marsDOW.rda")
head(mars)
dowNames
#delete the folder
unlink("C:/R/SoDA2", recursive=TRUE) 
#documentation on the class ts
class?ts 
#methods for the function show()
methods?show
#documention on the Matrix package
package?SoDA
#see examples from the documentation page on lm
example(lm)
#the evaluator will search the namespace when functions are called
search()
#show the location of the base R package
system.file()
#show the location of the SoDA package
system.file(package="SoDA")
#show the path of the chunks program in the perl subdirectory of the SoDA package
system.file("perl",c("chunks.perl"),package="SoDA")
#list the files and folders under the SoDA package's root directory
list.files(system.file(package="SoDA"))
