#We'll cover some of the most useful functions in dplyr, tidyr and Mass
# 
# We'll be covering the following common built-in functions:
#    seq(): Create sequences
#    sort(): Sort a vector
#    rev(): Reverse elements in object
#    str(): Show the structure of an object
#    append(): Merge objects together (works on vectors and lists)
# Data Types  & Data Type Conversion
#    is.*(): Check the class of an R object
#    as.*(): Convert R objects
#We'll be covering the following functions from dplyr:
#    filter() (and slice())
#    arrange()
#    select() (and rename())
#    distinct()
#    mutate() (and transmute())
#    summarise()
#    sample_n() and sample_frac()
#
# We'll be covering the following functions from tidyr:
#    gather()
#    spread()
#    separate()
#    unite()
#    
# We'll be covering the following functions from reShape, reShape2:
#    cbind()
#    rbind()
#    merge()  Type of Joins
#    melt()
#    cast()
#####---------------------------------------------------------------------####
# install.packages('dplyr')
# install.packages('tidyr')
# install.packages('MASS')
# install.packages('reshape')
# install.packages('reshape2')
# 
# Run it using
# library(dplyr)
# library(tidyr)
# library(MASS)
# library(reshape)
# library(reshape2)
#library(nycflights13)


# seq(start,end,step size)
seq(0, 10, by = 3)

seq(from = 4.5, to = 3.0, by = -0.5)

seq(from = -2.7, to = 1.3, length.out = 5)


#sort(x, decreasing = FALSE, na.last = NA, .)
v <- c(1,4,6,7,2,13,2)
sort(v)

sort(v,decreasing = TRUE)


# Reverse elements in object
v2 <- c(1,2,3,4,5)
rev(v2)

#Show the structure of an object
str(v)

c(v,v2)

append(v,v2)
?append

append(v, v2, after = 3)

sort(append(v,v2))


# Data Types  & Data Type Conversion
# is.*(): Check the class of an R object
# as.*(): Convert R objects


v <- c(1,2,3)
is.vector(v)

# checking data type
is.list(v)

#converting to other data type
x <- as.list(v)

is.list(x)

y <- as.matrix(v)

is.matrix(y)



##Guide to using dplyr
# Just take a dataset
library(dplyr)
library(nycflights13)

str(flights)
View(flights)
summary(flights)

dim(flights)    ## Notice how large the data frame is:


#filter() -we can select all flights on November 3rd that were from American Airlines (AA) with:
head(filter(flights,month==11,day==3,carrier=='AA'))


# This is a lot simpler than the normal way to do this with a dataframe:
head(flights[flights$month == 11 & flights$day == 3 & flights$carrier == 'AA', ]) 


#slice() -We can select rows by position using slice()
slice(flights, 1:15)

#flights[c(1:15, 20,21)]
#slice(flights, c(1:15, 20,21))

# arrange()- arrange() works similarly to filter() except that instead of filtering or selecting rows, it reorders them. It takes a data frame, and a set of column names (or more complicated expressions) to order by. If you provide more than one column name, each additional column will be used to break ties in the values of preceding columns:
head(arrange(flights,year,month,day,arr_time))

## You can add desc() to arrange in descending order:
head(arrange(flights,desc(dep_delay)))   

#View(flights)

# select()-- Often you work with large datasets with many columns but only a few are actually of interest to you. select() allows you to rapidly zoom in on a useful subset using operations that usually only work on numeric variable positions:
head(select(flights,carrier))


#rename() -You can use rename() to rename columns, note this is not "in-place" you'll need to reassign the renamed data structures.
head(rename(flights,airline_car = carrier))

x <- head(select(flights,carrier, year))
x
Y <- rename(x, new_year = year)



#levels(as.factor(flights$carrier))
   # distinct() -A common use of select() is to find the values of a set of variables. This is particularly useful in conjunction with the distinct() verb which only returns the unique values in a table.
distinct(select(flights,carrier))


# mutate() -- Besides selecting sets of existing columns, it also often useful to add new columns that are functions of existing columns. This is the job of mutate():
head(mutate(flights, new_col = arr_delay-dep_delay))

str(head(mutate(flights, new_col = arr_delay-dep_delay)))


flights[!colnames(flights) %in% c("carrier", "arr_time")]

# transmute() Use transmute if you only want the new columns:
head(transmute(flights, new_col = arr_delay-dep_delay))


#summarise() - You can use summarise() to quickly collapse data frames into single rows using functions that aggregate results. Remember to use na.rm=TRUE to remove NA values.
summarise(flights,avg_air_time=mean(air_time,na.rm=TRUE), 
          avg_arr_delay =sum(arr_delay,na.rm=TRUE), 
          avg_dep_delay =mean(dep_delay,na.rm=TRUE))

str(flights)
# You can use sample_n() and sample_frac() to take a random sample of rows: use sample_n() for a fixed number and sample_frac() for a fixed fraction.
sample_n(flights,1000)

# .005% of the data
sample_frac(flights,0.00005) # USE replace=TRUE for bootstrap sampling

# it is primitive function
# sample(flights, 4)
# sample(1:nrow(flights), 50)
sample(1:nrow(flights), 0.5*nrow(flights))
flights[sample(1:nrow(flights), 50),]


####    Guide to using tidyr
# 
# Installing tidyr
# install.packages('tidyr',repos = 'http://cran.us.r-project.org')
# library(tidyr)
# library(data.table)
#
#Let's create some fake data that needs to be cleaned using tidyr

comp <- c(1,1,1,2,2,2,3,3,3)
yr <- c(1998,1999,2000,1998,1999,2000,1998,1999,2000)
q1 <- runif(9, min=0, max=100)
q2 <- runif(9, min=0, max=100)
q3 <- runif(9, min=0, max=100)
q4 <- runif(9, min=0, max=100)

df <- data.frame(comp=comp, year=yr, Qtr1 = q1, Qtr2 = q2, Qtr3 = q3, Qtr4 = q4)
df

library(tidyr)

#Gather() and Spread()

# gather()
# # The gather() function will collapse multiple columns into key-pair values. 
# The data frame above is considered wide since the time variable (represented as quarters) is 
# structured such that each quarter represents a variable. To re-structure the time component as 
# an individual variable, we can gather each quarter within one column variable and also gather 
# the values associated with each quarter in a second column variable.


# Using Pipe Operator
#head(df %>% gather(Quarter,Revenue,Qtr1:Qtr4))

# With just the function
x <- gather(df,quarter,revenue,Qtr1:Qtr4)


# spread()- This is the complement of gather(), which is why its called spread():+


spread(x,variable,value)


# Separate and Unite
# separate()
# Given either regular expression or a vector of character positions, separate() turns a single character column into multiple columns.
# 

df <- data.frame(x = c("a.x-y", "b-y", "c_z.k", "g-h"))
df

separate(df, x, c("fname", "lname", "qname"))

#df %>% separate(x, c("ABC", "XYZ"))

p <- separate(df, x, c("fname", "lname"))

unite_(p, "Name", c("fname", "lname"), sep = '_')


# unite()
# Unite is a convenience function to paste together multiple columns into one.

#x <- df %>% separate(x, c("ABC", "XYZ"))
unite_(p, "New", c("fname", "lname"), sep = '.')


head(mtcars)
unite_(mtcars, "vs.am", c("vs","am"),sep = '.')



####    Guide to using MASS
# 
# Installing MASS
# install.packages('MASS',repos = 'http://cran.us.r-project.org')
# library(MASS)
# library(data.table)
#
#Let's create some fake data that needs to be cleaned using tidyr

 
# Create vector objects.
fan <- c("Bajaj","Usha","Orient","Crompton")
color <- c("blue","blue","white","black")
rpm <- c(320,330,390,400)

# Combine above three vectors into one data frame.
fan_detail1 <- data.frame(fan,color,rpm)


# Create another data frame with similar columns
fan_detail2 <- data.frame(fan = c("indo","Solar"),
                          colr = c("Purple","blue"),
                          rpm = c("320","330"),
                          stringsAsFactors = FALSE)


# Combine rows form both the data frames.
fan_details <- rbind(fan_detail1,fan_detail2)


# Combine rows form both the data frames.
fan_details <- cbind(fan_detail1,fan_detail2)


#Using Merge function

merged.fans <- merge (x= fan_detail1, y = fan_detail2, by = "rpm")
 



merged.fans <- merge (x= fan_detail1, y = fan_detail2,
                      by = c("color","rpm"))
                     


merged.fans <- merge (x= fan_detail1, y = fan_detail2,
                      by.x = c("color","rpm"),
                      by.y = c("colr", "rpm"))


merged.fans <- merge (x= fan_detail1, y = fan_detail2,
                      by.x = c("color"),
                      by.y = c("color"))

# Type of Joins
# 
# a. Natural join or Inner join in R
# To keep only rows that match from the data frames, specify the argument all=FALSE
# 
# b. Full outer join in R
# To keep all rows from both data frames, specify all=TRUE
# 
# c. Left outer join in R
# To include all the rows of your data frame x and only those from y that match, specify all.x=TRUE
# 
# d. Right outer join in R
# To include all the rows of your data frame y and only those from x that match, specify all.y=TRUE

merged.fans <- merge (x= fan_detail1, y = fan_detail2,
                      by.x = c("rpm"),
                      by.y = c("rpm"), all.x= FALSE, all.y = TRUE )


# Melting and Casting
# One of the most interesting aspects of R programming is 
#about changing the shape of the data 
#in multiple steps to get a desired shape. 
#The functions used to do this are called melt() and cast().
# 
# We consider the dataset called ships present in the library called "MASS".
library(reshape)
library(reshape2)
library(MASS)
ships
str(ships)
molten.ships <- melt(ships, id = c("type","year"))

?melt


# Cast the Molten Data
# We can cast the molten data into a new form 
#where the aggregate of each type of ship for each year is created. 
# It is done using the cast() function.

recasted.ship <- cast(molten.ships, type+year~variable,mean)
print(recasted.ship)

View(ships)
View(recasted.ship)





# print today's date
today <- Sys.Date()
format(today, format="%d %m %Y")

# convert date info in format 'mm/dd/yyyy'
 strDates <- c("01-05-1965", "08-07-1975")
 dates <- as.Date(strDates, "%d-%m-%Y")
 

format(dates, format="%b %d %y")

format(as.Date(strDates, "%m-%d-%Y"), "%B/%d/%Y")
# 
# mydates <- as.Date(c("2007-06-22", "2004-02-13"))

# convert dates to character data
strDates <- as.character(dates)


###----------------------------End of Built-in Function---------------------###

