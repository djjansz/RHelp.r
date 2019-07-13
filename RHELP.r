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