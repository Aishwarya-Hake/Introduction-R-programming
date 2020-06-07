
### Important Note to Windows Users:

##R gets confused if you use a path in your code like:
# c:\mydocuments\myfile.txt  - This is because R sees "\" as an escape character. 
#Instead, use:
#c:\\my documents\\myfile.txt
#c:/mydocuments/myfile.txt        - On linux 


### Getting the help

help.start()        # general help
help()              # help about function help
help(View)        # Help about nay specific functionAll Panels



#   ? & ?? --- What is the difference between two operators.

?View
RSiteSearch("getwd") # search for help in help manuals and archived mailing lists

### The Workspace

getwd()             # print the current working directory - cwd
list.dirs()         # Get the list of all working directory
setwd("E:/Training/Training")      # change to mydirectory
ls()                # list the objects in the current workspace


# Working With History

#history()           # display last 25 commands
history(max.show=Inf) # display all previous commands



savehistory(file="myfile") # save your command history  default is ".Rhistory" 
loadhistory(file="myfile") # recall your command history  default is ".Rhistory"

q()                 # quit R. You will be prompted to save the workspace.


###Packages

.libPaths()         # get library location 
library()           # see all packages installed 
search()            # see packages currently loaded




### Operators

x <- 5             # Assigment oprerators
x

x = 6              # Assigment operators
x

x <<- 4
x

6 -> x
x



#   ???? --- What is the difference between two assigmnet operators

### Arithmetic with R

1+2               #Addition
5-3               #Subtraction
1/2               #Division
2^3               #Exponents
5 %% 2            #Modulo
(100 * 2) + (50 / 2)  #Order of Operations

### Logical/Comparison Operators with R

5 > 6             #Greater Than
6 > 5             #Greater Than
6 >= 6            #Greater Than or Equal to
3 < 2             #Less Than and 
2 <= 2            #Less than or Equal To
var <- 1          #Be very careful with comparison operators and negative numbers! 
var               #Use spacing to keep things clear. An example of a dangerous situation:
var < -2          
var <- 2          # Accidentally reassigning var!
var               #Value will get reassigned
5 != 2            #Not Equal
4 == 3             #Equal
