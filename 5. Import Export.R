
library(readr)
library(readxl)
# library(rjson)
# library(RMySQL)
# library(jsonlite)
library(xlsx)

####Intro Theory.

# The R base function read.table() is a general function that can be used to read a file in table format.
# The data will be imported as a data frame.
# Note that, depending on the format of your file, several variants of read.table() 
# are available to make your life easier, including read.csv(), read.csv2(), 
# read.delim() and read.delim2().

# read.csv(): for reading "comma separated value" files (".csv").
# read.csv2(): variant used in countries that use a comma "," as decimal point and a semicolon ";" as field separators.
# read.delim(): for reading "tab-separated value" files (".txt"). By default, point (".") is used as decimal points.
# read.delim2(): for reading "tab-separated value" 


#Get the user inputs from keyboard.

 #for numeric input
 z <- scan()
 z
 
 #for categorical input
 x <- readline()
 x
 
# for multiple line input
  y <- read.table("test.txt", sep = "\t")
  y
  

  x <- read.table("mtcars.txt", header = TRUE, sep = "",
                  dec = ".")
  View(x)
  
  
###Reading a local file with primitive functions.

# #Checking semicolon_seperated.txt, tab_seperated_values.txt, test.txt
# 
# data <- read.table("import/tab.txt",sep = "\t", header = TRUE)
# 
# data <- read.delim("mtcars.txt", header = FALSE, sep = ",", quote = "\"", dec = ".", fill = TRUE, comment.char = "")

class(data)
str(data)
View(data)


#Now write a text files.
write.table(mtcars, "mtcars.txt")


# Read a txt file wth type of the file.
my_data <- read.table(file.choose())

str(data)
View(data)


#Fast Reading of Data From TXT|CSV Files into R: readr package

# Compared to R base functions, readr functions are:
#   
#   much faster (X10),
#   have a helpful progress bar if loading is going to take a while and
#   all functions work exactly the same way.

ex <- read.csv(file.choose())

ex <- read.csv("C:/Training/Sat Class/50_Startups.csv", header = FALSE, 
               sep = ",", dec = ";")

View(ex)

library(readr)
X50_Startups <- read_csv("C:/Training/Sat Class/50_Startups.csv")
View(X50_Startups)

# Check structure
str(ex)
# Check column names
colnames(ex)
#df <- data.frame(ex)
head(ex)
#structure
str(ex)
#class label.
class(ex)

## Exporting Data to CSV
write.csv(mtcars, "mtcars1.csv")


#from readr libarary

#library(readr)
x <- read_csv("50_Startups.csv")
View(x)





####  Excel Files with R
# Load the readxl package
library(readxl)

df <- read_excel('boston1.xls')

str(df)
View(df)

# list the sheets of the excel file
excel_sheets('boston1.xls')


# Call info from the sheets using read_excel 
df <- read_excel('boston1.xls',sheet='test2')
str(df)
head(df)
View(df)
summary(df)



sum(df['Value'])       #Now you can perform operations on it just like a normal R data frame:
str(df)
summary(df)

entire_workbook <- lapply(excel_sheets('boston1.xls'), 
                          read_excel, 
                          path = 'boston1.xls')


str(entire_workbook)
entire_workbook[[1]]

### Writing to Excel
#install.packages('xlsx',repos="http://cran.rstudio.com/")

library(xlsx)

df <- data.frame(matrix(1:10))

write.xlsx(df, "output.xlsx")


write.xlsx(mtcars, "mtcars.xlsx")


read_excel('output.xlsx')
write.csv(df, file='some.file1.csv') 


#imorting and exporting with json
library('rjson')
library('jsonlite')

# Give the input file name to the function.
  result <- fromJSON(file.choose())

 
  View(result)
  class(result)

# writing to json.
  write_json(mtcars, "mtcars.json")
  
#converting into jst a json file
x<- toJSON(mtcars, "import/newcars.json")

x <- mtcars[mtcars$mpg>30,]

####  SQL with R
#install.packages("RMySQL")
library(RMySQL)

mydb = dbConnect(MySQL(), user='root', password='', 
                 dbname='test', host='localhost')



dbListTables(mydb) #This will return a list of the tables in our connection

df <- entire_workbook[[2]]

dbWriteTable(mydb, name='abc', value=women[1:10,])

?dbWriteTable

dbListFields(mydb, 'ABC') #This will return a list of the fields in some_table.

var <- 'UPDATE abc SET height =12345 WHERE height =118'

#Running Queries
rs = dbSendQuery(mydb, var)
rs
data = fetch(rs, n=-1)
View(data)






#Making tables:
aq<-airquality


drp <- 'DROP TABLE if EXISTS boston'

#dbWriteTable(mydb, name='boston', value=df)

#Retrieving data from MySQL:
rs = dbSendQuery(mydb, drp)
data = fetch(rs, n=-1) #The n in the function specifies the number of records to retrieve, using n=-1 retrieves all pending records.



