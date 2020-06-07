### Vector 


#defining a variable
  v <- 2


#defining a vector

V <- 2,3

V <-  2 & 3








  v <- c(1,2,3,4,5) #We can apply a comparison of a single number to an entire vector
  v < 2
  v == 3
  v + 2
  
  v1 <- c(7,8,11)    #We can also do element by element comparisons for two vectors:
  v2 <- c(10,20,30)  
  
  v1 + v2           #Vector comparison
  v1 < v2



### R Data Types

  n <- 2.2        #Decimal (floating point values) are part of the numeric class in R        #Natural (whole) numbers are known as integers and are also part of the numeric class
  k <- 8
  
  class (n)       #Checking Data Type Classes
  class (k)       #Checking Data Type Classes
  Class (N)       # ????  Why there is Error here.
  
  typeof(n)
  n
  class(n)

  TRUE
  FALSE
  T
  F
  
  A <- TRUE       
  T <- FLASE       # ????   What is the difference between these statement.
  T <- FALSE  
  T
  TRUE <- "F"
  
  f <- FALSE
  T
  
  
  
  F
  f
  
  class(T)
  class(f)       ##Boolean values (True and False) are part of the logical class. In R these are written in All Caps.
  
  
  char <- "Hello World!"       #Text/string values are known as characters in R. You use quotation marks to create a text character string:
  char

  c <- 'Hello World!'   # Text values with single quotes
  c
  
                  #  ????   What is the differnce between above statment.
  
  class (char)    #Checking Data Type Classes  
  class (c)       #Checking Data Type Classes
  


####  Variables

  variable.names <- 100
  
  bank.account <- 100
  deposit <- 10
  bank.account <- bank.account + deposit
  bank.account




####   Working with R- Data Types

  vector("logical",2) 
  
  vector("integer",2)
  
  vector("numeric",2)
  
  vector("double",2)
  
  vector("character",2)
  
  vector("complex",2)
  
  
  
  
  
  

  nvec <- c(1,2,3,4,5)      # Using c() to create a vector of numeric elements
  class(nvec)
  
  cvec <- c('U','S','A')    # Vector of characters
  class(cvec)
  
  
  lvec <- c(TRUE,FALSE)     # Vector of logical values
  lvec
  class(lvec)

#Assigment Practice

  v <- c(FALSE,1)
  v
  #class(v)
  
  
  v <- c('A',1)
  v
  #class(v)


# ???? ----- What is the problem with above statement.

#c(72,71,68,73,69,75,71)
## Working with Vectors

  temps <- c(1,2,3,4,5,6,7)
  temps
  names(temps) <- c('Mon','Tue','Wed','Thu','Fri','Sat','Sun')   #We can use the names() function to assign names to each element in our vector.
  temps
  
  days <- c('Mon','Tue','Wed','Thu','Fri','Sat','Sun')
  temps2 <- c(1,2,3,4,5,6,7)
  names(temps2) <- days   ##We can use the names() function to assign names to each element in our vector.
  temps2



  v1 <- c(1,2,3)
  v2 <- c(11,12,13,14,15,16)
  
  v1+v2    #Adding Vectors
  
  v1-v1    #Subtracting Vectors
  v1-v2
  
  v1*v2    #Multiplying Vectors
  
  v1/v2    #Dividing Vectors
  
  sum(v1)    #Functions with Vectors
  
  v <- c(12,45,100,2)
  sd(v)    # Standard Deviation
  
  max(v)    # Maximum Element
  
  min(v)    #Minimum Element
  
  prod(v1)  # Product of elements 
  prod(v2)  # Product of elements
  
  ## Vector Indexing and Slicing
  
  v1 <- c(100,200,300)
  v2 <- c('a','b','c')
  
  v1
  v2
       length(v1)

  v1[2]    # Grab second element
  v2[2]    # Grab second element
  
  
  ## Multiple Indexing -We can grab multiple items from a vector by passing a vector of index positions inside the square brackets. 
  
  v1[c(1,2)]
  v2[c(2,3)]
  v2[c(1,3)]



## Slicing - vector[start_index:stop_index] - we can use a colon (:) to indicate a slice of a vector.

  v <- c(1,2,3,4,5,6,7,8,9,10)
  v[2:4]
  v[10:7]
  
  v[c(1:3, 5,7:9)]

## Indexing with Names

  # # v <- c(1,2,3,4)
  # names(v) <- c('a','b','c','d')
  # v
  # v['a'] 
  # v[c('a','c','d')]               #We can use those names along with the indexing brackets to grab individual elements from the array!
  # v[c('a':'c','d')] # Or pass in a vector of names we want to grab: # Notice how we can call out of order!
  # 


## Comparison Operators and Selection  
  v <- c(6,7,8,9)
  v
  v[v>7]
  v>7      ## ???? ---- What are supposed to be the out put and why
  
  v[v>7]
  filter <- v>7    #We could also assign names to these logical vectors and pass them as well,
  filter
  v[!filter]



##Lets create confusion

  a=c(1,2)
  typeof(a)
  class(a)
  
  a=c(2,"1")
  typeof(a)
  class(a)
  a           # ???? - What would be the expected output.

            # What is difference between typeof and class.



#### Important Notes :
  a=c(1,2)
  class(a)
  
  b=as.character(a)
  b                     #The typeof() method that we saw, determines the internal storage type of an object. You can explicitly convert elements of a vector from one type to another using the as.XXX() function.
  class (b)

#Subsetting  

  a <- c(11,22,33,44,55,66,77,88,99)
  a[3]
  a[[5]]
  
  a[1:2]
  a[[3:4]]        #[ ] can be used to retrieve a subset of the vector. It returns another list. Even if you want to retrieve a single element, it retrieves a list. ‘[[]]’ can be used to retrieve a single element. It cannot return more than one element.
  
  1:6
  seq(1,10,2)
                #a=c('a','b','c','d','e')
  a[3]            
  a[c(1,4)]       #We can retrieve a subset by specifying multiple indexes
  
  #a[seq(1,6,2)]     #We can subset using a rang
  # x <- seq(11,999,11)
  # length(x)
  
  a[-3]           # We can give it a negative index to 'exclude' that element.this excludes the third element. 
  
  a[5/2]          #You could also give it a mathematical expression
  
  a[1-3]          # It will be considered as aritmatic operation and the vlaue at index postion 2 will be deleted as the resultant index position would be -2.
  
  a[c(1,0)]      #A missing value in index is converted to a missing value in the output
  
  a[c(-2,-4)]      #you can't include both negative and positive numbers only 0's may be mixed with negative subscripts
  
  a[c(0,-2)]
  
  a[c(-2,1)]




######--------------Exercise Time -----------------#####




####  Working With  Matrix
#We've learned about vectors which allow us to store indexed elements. 
#A matrix will allow us to have a 2-dimensional data structure which contains elements consisting of the same data type.

# 1:10

v <- 1:10
v

matrix(v)             #use the matrix() function. We can pass in a vector into the matrix:


matrix(v, nrow = 2)      #Here we have a two-dimensional matrix which is 10 rows by 1 column. Now what if we want to specify the number of rows? We can pass the parameter/argument into the matrix function called nrow which stands for number of rows:


matrix(v, ncol= 2) 


matrix(1:12,byrow = FALSE,nrow=4)   #Now we have a 2 by 5 matrix. Notice that the nrow argument allows this to happen. But how do we decide the fill order? We could have filed columns first (as we did above) or filled out the rows first insequential order. The byrow argument allows you to specify whether or not you want to fill out the matrix by rows or by columns. 

matrix(1:12, byrow=TRUE, nrow=4)    #


#controling by col.
matrix(1:12, byrow=TRUE, ncol=4)

matrix(1:14, byrow=TRUE, ncol=4, nrow = 4)

#Creating Matrices from Vectors

# We can combine vectors to later input them into a matrix. 
#For example imagine the following vectors below of stock prices:not real prices

goog <- c(450,451,452,445,468)
msft <- c(230,231,232,236,228)

stocks <- c(goog,msft)

stock.matrix <- matrix(stocks,byrow=TRUE,nrow=2)

stock.matrix

#Naming Matrices

days <- c('Mon','Tue','Wed','Thu','Fri')

st.names <- c('GOOG','MSFT')

colnames(stock.matrix) <- days
rownames(stock.matrix) <- st.names

stock.matrix

##  Binding columns and rows

FB <- c(111,112,113,120,145)
tech.stocks <- rbind(stock.matrix,FB)
tech.stocks

avg <- rowMeans(tech.stocks)
avg

tech.stocks <- cbind(tech.stocks,avg)
tech.stocks


# Matrices to matrices operation

FB <- c(111,112,113,114,110)
FB <- matrix(FB, nrow = 1)
rownames(FB) <- 'FB'
tech.stocks <- rbind(stock.matrix,FB)

#tech.stocks

avg <- rowMeans(tech.stocks)
avg <- matrix(avg)
colnames(avg) <- 'AVG'
tech.stocks <- cbind(tech.stocks,avg)
tech.stocks


##Matrix Arithmetic

mat <- matrix(1:6, nrow =3)
mat1 <- matrix(10:15, nrow =4)

mat+mat
mat+mat1

mat <- matrix(1:25,byrow=TRUE,nrow=5)
mat

2*mat     # Multiplication

1/mat     # Division (reciprocal)
 
mat/2     # Division

mat ^ 2   # Power

mat > 17    # Comparison operators with matrices


mat + mat   # Matrix Arithmetic with multiple matrices
mat + mat1

mat - mat
mat - mat1

mat / mat   #  Matrix Arithmetic
mat / mat1

mat ^ mat   #  Warning, big numbers!
mat ^ mat1

mat*mat     #  Warning, big numbers!
mat*mat1



mat%*%mat

mat%*%t(mat)


##  Matrix multiplication

mat2 <- matrix(1:9, nrow=3)     

mat2

mat2 %*% mat2      # True Matrix Multiplication


##  Matrix Operations


colSums(stock.matrix)   #We can perform functions across the columns and rows, such as colSum:

rowSums(stock.matrix)   #We can perform functions across the columns and rows, such as row:

rowMeans(stock.matrix) #We can also do other mathematical operations


##  Matrix Selection and Indexing
mat <- matrix(11:35, nrow=5, byrow = TRUE) 


mat[1,]  # Grab first row

mat[,1]  #Grab first column

mat[1:3, ] # Grab first 3 rows

mat[1:2,1:3]  # Grab top left rectangle of: 1,2,3 and 11,12,13

mat[,9:10]   # Grab last two columns

mat[2:3,5:6]  # Grab a center square of: # 15,16 and # 25,26

diag(mat)

#diag(1,4,5)

#mat[row(mat)==col(mat)]

#diag(mat[-4,-5])

lower.tri(mat)
upper.tri(mat, diag = TRUE)
mat[lower.tri(mat)]

# dim(diag(3))
# diag(1, 4, 4) # guess what?
# all(diag(1:3) == {m <- matrix(0,3,3); diag(m) <- 1:3; m})
# diag(c(1i,2i))
# diag(TRUE, 3)  

# A <- mat
# A[row(A) == (col(A))]
# 
#   t(mat)[, ncol(mat):1] 
#   t(mat)[nrow(mat):1, ]
# diag(mat[,ncol(mat):1])
# diag(mat[nrow(mat):1, ])


#rowsum(iris[,-5], group =iris$Species )

mat <- matrix(1:25, nrow = 5, byrow = TRUE)



## Factor and Categorical variables

animal <- c('d','c','d','c','c')
 
factor.ani <- factor(animal)

factor.ani      ## Will show levels as well on RStudio or R Console : We can see that we have two levels, 'd' and 'c'. In R there are two distinct types of categorical variables, a ordinal categorical variable and a nominal categorical variable .

summary(factor.ani)            #Nominal categorical variables don't have any order, such as dogs and cats (there is no order to them). Versus Ordinal categorical variables (as the name implies) do have an order. For example, if you had the vector:

ord.cat <- c('cold','med','hot')   #You could begin to assign in order to these variables, such as: cold < med < hot

factor.ani <- factor(ord.cat)

temps <- c('hot','cold','med','cold','med','hot','hot','cold','hot','hot')
fact.temp <- factor(temps,ordered=TRUE, levels=c('cold','med','hot'))
fact.temp

summary(factor(temps))
summary(fact.temp)   #This information is useful when used along with the summary() function which is an amazingly convenient function for quickly getting information from a matrix or vector






####  Working With Dataframe  


rm(mtcars)

data()   
mtcars
View(mtcars)
str(mtcars)

View(PlantGrowth)
str(PlantGrowth)

str(airquality)
View(iris3)
str(iris)

USPersonalExpenditure # US personal expense

women   # Women 

data()     #listing all datasets

data(mtcars)
View(airquality)

summary(mtcars)
summary(iris)
summary(airquality)

mtcars
str(mtcars)
summary(airquality)

head(airquality)          #

tail(airquality)

str(states)
summary (states)

str(mtcars)

data.frame()
## Creating Data frames

days <- c('mon','tue','wed','thu','fri')
temp <- c(22.2,21,23,24.3,25)
rain <- c(TRUE, TRUE, FALSE, FALSE, TRUE)  

df <- data.frame(days,temp,rain)      #We can create data frames using the data.frame() function and pass vectors as arguments, which will then convert the vectors into columns of the data frame. 
df
str(df)      # Check structure
summary(df)  # Check Summary


class(df)


z <- df[1,]
is.data.frame(df[1,])
is.vector(df[1,])
## Data Frame Selection and Indexing


df[1,]  # Everything from first row

df[,1]  #Everything from first column

df[5,]  # Grab Friday data

##  Selecting using column names

x<- df[,'rain']   # All rain values
x

y<- df['rain']
y

df[1:3,c('days','temp')]  # First 3 rows for days and temps


df$days   # If you want all the values of a particular column you can use the dollar sign directly after the dataframe as follows: df.name$column.name

df$days


df['rain']  # You can also use bracket notation to return a data frame format of the same information:

df['days']

##  Filtering with a subset condition   -We can use the subset() function to grab a subset of values from our data frame based off some condition


subset(df,(rain==TRUE & temp >23))



subset(df,(temp >23 & rain==TRUE))

df$temp >23

df[df$temp >23,]

df[(temp>23 & rain==TRUE),]


df <- mtcars



subset(mtcars, (mpg>24 & am==1 & gear==3))

mtcars[(mtcars$mpg>23 & mtcars$am==1 & mtcars$gear==4),]
df <- mtcars

attach(df)

df[(mpg>20 & cyl==4 & gear==3),]

df[mpg==max(mpg),]



sorted.temp <- order(df['mpg'], decreasing = FALSE)  # Odering a Data Frame - We can sort the order of our data frame by using the order function. 
                                                      #You pass in the column you want to sort by into the order() function, then you use that vector to select from the dataframe. 
df[sorted.temp,]


desc.temp <- order(-df['mpg'])    #so we are just asking for those index elements in that order (by default ascending, we can pass a negative sign to do descending order):
df[desc.temp,]

# 
# year <- rep(2010:2019, 36)
# month <- rep(1:12,30)
# days <- rep(1:30, 12)
# length(year)
# 
# df <- data.frame(year,month,days)
# View(df)
# 
# x <- df[df$year==2010,]
# View(x)

# sort.temp <- order(df$temp, df$days)     #We could have also used the other column selection methods:
# df <- df[sort.temp,]


st <- order(mtcars$mpg, mtcars$cyl)
mtcars[st,]


##  Overview of Data Frame Operations

#empty <- data.frame()     # creating empty data frame

c1 <- 1:10                # vector of integers

c2 <- letters[1:10]       # vector of strings

df <- data.frame(x=c1,y=c2)

df


colnames(mtcars)

## Getting Information about Data Frame

nrow(df)                  # Row and columns counts
ncol(df)

colnames(df)             # Column Names

rownames(df)            # Row names (may just return index)

rownames(mtcars)
colnames(mtcars)
##  Referencing Cells, we can think of the basics as using two sets of brackets for a single cell, and a single set of brackets for multiple cells.

df <- mtcars[1:10,]

vec <- df[[5, 2]]       # get cell by [[row,col]] num

newdf <- df[1:5, 1:2]   # get multiplt cells in new df

newdf <- df[[1:5, 1:2]]

df[4:7, 'mpg'] <- 'c'  # reassign a single cell

df[4, ] <- 'c'
 
str(df)



rowdf <- df[1, ]          # Referencing Rows  # returns a data frame (and not a vector!)

rowdf             

# vrow <- as.numeric(as.vector(df[1,]))             # to get a row as a vector, use following
# vrow


cars <- mtcars
head(cars)             # Referencing Columns - Most column references return a vector

colv1 <- cars$mpg      # returns a vector
colv1

colv2 <- cars[,'mpg']   # returns vector
colv2

colv3<- cars[, c(1,2)]      # a is int or string
colv3

colv4 <- cars[[3]]     # returns a vector
colv4

#is.vector(mpgdf)

mpgdf <- cars['mpg']   # Ways of Returning Data Frames #returns 1 col df
head(mpgdf)

mpgdf2 <- cars[1:3]     # returns 1 col df
head(mpgdf2)

cars$mpg[3]


##  Adding Rows 

c1 <- 1:10                # vector of integers

c2 <- letters[1:10]       # vector of strings

df <- data.frame(x=c1,y=c2)

df2 <- data.frame(x=2000,y='new' )    # Both arguments are DFs)
df2

dfnew <- rbind(df,df2)  # use rbind to bind a new row!
dfnew


df1 <- data.frame(x=1:10, y=letters[1:10])
df2 <- data.frame(x=1:14, y=letters[1:14])
df5 <- data.frame(p=1:5, q=letters[1:5])

df3 <- cbind(df1, df2)
df4 <- rbind(df2, df1)
df6 <- cbind(df1, df5)

##  Adding Columns
df1 <- df


df <- mtcars[,1:4]

# df$X <- 1:16
# df[,'y']<- 1:16
# 
# df['z'] <- 16:1
# 
# df[["A"]] <- 1:32
# 
# vec <- 32:1
# 
# cbind(df,vec)


df1$newcol9 <- rep('abb', (nrow(df1)-5))     

df1

# NA column
df1
df1[, 'p'] <- df1$x*2         # copy a col

df1$z <- df1$x*3
df1

df1[['col1.times.2']] <- (1:10) * 2     # Can also use equations!
df1

df5 
df6

df5$z <- df6
  
cbind(df5, df6)



df3 <- cbind(df, df$col.name.1)
df3

df<-mtcars
df$hp[22]<-NA


##  Setting Column Names


colnames(df)[c(1,4)] <- c("Milage", "hppp")


colnames(df)[] <- 1:8



colnames(df)[2] <- 'SECOND COLUMN NEW NAME'         # Rename second column
df

colnames(df)[c(2,3)] <- c('A', 'B')
 
# colnames(df) <- c('col.name.1', 'col.name.2', 'newcol', 'copy.of.col2' ,'col1.times.2')
# df


colnames(df1)  <- letters[1:9]                                # Column Names


mtcars[c(((nrow(mtcars)/2)-3) :((nrow(mtcars)/2)+3)),]

## Selecting Multiple Rows

df <- df[1:10, ] # Same as head(df, 10)

df[8/4,]
df[-2, ]

df[,-2 ]
df[1-3]

# Conditional Selection
sub1 <- df[ (df$col.name.1 > 8 & df$col1.times.2 > 10), ]
sub1

sub2 <- subset(df, col.name.1 > 8 & col1.times.2 > 10)
sub2


z<-df$x>5
 
df1[z,]

df1[(df1$x  >5),]

df[,]

##  Selecting Multiple Columns

df[, c(1, 2, 3)]              #Grab cols 1 2 3
df[, c('col.name.1', 'col1.times.2')]   # by name
df[, -1]                # keep all but first column
df[, -c(1, 3)]             # drop cols 1 and 3


##  Dealing with Missing Data

x<-is.na(airquality) # detect anywhere in df
x

y <- complete.cases(airquality)
y

airquality[x,]

any(is.na(df$col.name.1)) # anywhere in col

df <- df[!is.na(df), ] # delete selected missing data rows

df1[is.na(df1),] <- 0 # works on whole df  # replace NAs with something else


df$col[is.na(df$col)] <- 999 # For a selected column

df


df1$y[c(8,9)] <- NA

df1[is.na(df1)] <- 'i'


##---------------------End DF--------------##


#List :  R Lists Basics

# Create a vector
v <- c(1,2,3,4,5)

# Create a matrix
m <- matrix(1:10,nrow=2)

# Create a data frame
df <- mtcars

li <- list(v,m,df)   #We can use the list() to combine all the data structures:

str(li)

li <- list(vec = v,mat = m, df = df)

str(li) 


li$mat[9]

li[[c(2)]][2,3]

li[[2]][9]

class(li[[1]])

#l <- list(1:10 , df)

li[-2]

li$df[6,2]

li$df$height[7]

li[3]



li$sample_mat

class(li$sample_mat)

# Single brackets
li[3] # By index

# By name
li['vec']

class(li['vec'])

# Notice the type!
class(li[['mat']])


# Use double brackets to actually grab the items
li[['sample_vec']]


# Can also use $ notation
li$sample_vec

li[['sample_mat']][2,3] # Second set of indexing

li['sample_df']$height

li$sample_df$height

 
li$sample_df$height[10]

##  Combining lists

double_list <- c(li,li)

double_list

 dl <- list(li, li)

 str(double_list)

str(dl)

double_list$height

double_list[]


k <- list(v, m, df, li)
str(k)

x<-list( sample_list = li, newlist = li, df = df)

x$sample_list$df$weight[9]

#### Built-in function in R

v <- c(-1,0,1,2,3,4,5) 
v

sum(v)

mean(v)

round(23.1231)

round(23.1231234,2)

ceiling(23.12312)

sqrt(5)



##-----------------------------End List Basics---------------##



## Logical Operators  - AND - & OR - | NOT - !


x <- 10   # Imagine the variable x

x < 20  

x > 5

x < 20 & x > 5       #Use of and operators

(x < 20) & (x>5)    #We can also add parenthesis for readability and to make sure the order of comparisons is what we expect:

(x < 20) & (x>5) & (x == 10)


x==2 & x > 1


x==2 | x > 1       # Use of OR operator

x==1 | x==12


(10==1)

!(10==1)           # Use of NOT operator

!!(10==1)         # We can stack them (pretty uncommon, but possible)



## Logical Operators with Vectors

A <- c(TRUE,FALSE,TRUE)
B <- c(TRUE,TRUE,TRUE)
C <- c(FALSE, TRUE,TRUE)

B & A
C & A

B | A

C && B       #To compare first elements use && or ||

B[2] && C[3]

B || A

B || C


# & and && indicate logical AND and | and || indicate logical OR. The shorter form performs 
# elementwise comparisons in much the same way as arithmetic operators. The longer form 
# evaluates left to right examining only the first element of each vector.




#### Array Funtions ####

# Create two vectors of different lengths.

v1 <- c(2,9,3)
v2 <- c(10,16,17,13,11,15)
v3 <- c(25,30)

# Take these vectors as input to the array.

result <- array(c(v1,v2,v3),dim = c(3,3,2))
result
str(result)

#?array

# We will create two vectors of different lengths.

# column.names <- c("COL1","COL2","COL3")
# row.names <- c("ROW1","ROW2")
# matrix.names <- c("Matrix1","Matrix2")


# column.names <- c("c1","c2","c3")
# row.names <- c("r1","r2")
# matrix.names <- c("Matrix1","Matrix2")
# 

col.names <- c("c1","c2","c3")
row.names <- c("r1","r2", "r3")
matrix.names <- c("Matrix1","Matrix2")

li <- list(row.names,col.names,matrix.names)


dimnames(result)<-li

result <- array(c(v1,v2,v3),dim = c(3,3,2), dimnames = li)

str(result)

# Now, we will take these vectors as input to the array.

#result[10:15]

# Print the third row of the second matrix of the array.

result[,3,]

# Print the element in the 1st row and 3rd column of the 1st matrix.

result[1,3,1]

# Print the 2nd Matrix.
result[,,2]

x <- result[2,,]

y <- result[,2,]

rbind(x,y)

x <- result[,,2]
y <- result[,,1]

x+y

##Manipulating Array Elements

v3 <- c(1,2,3)
v4 <- c(3,4,5,6,7,8)
array1 <- array(c(v3,v4),dim = c(3,3,2))

v5 <- c(3,2,1)
v6 <- c(8,7,6,5,4,3)
array2 <- array(c(v5,v6),dim = c(2,2,2))

array1
array2

# create matrices from these arrays.
matrix1 <- array1[,,2]
matrix2 <- array2[,,2]

result <- matrix1+matrix2
result


# Use apply to calculate the sum of the rows across all the matrices.
# We will be using the apply()function for calculations in an array in R.
# 
# Syntax
# 
# apply(x, margin, fun)
# 
# Following is the description of the parameters used ???
# 
# x is an array. 
# a margin is the name of the dataset used.
# fun is the function to be applied to the elements of the array.

apply(result, c(1), sum)






##-----------------------------End R Basics------------------------##






