
# we will cover following topics :
#      Built-in Function
#      User-defined Function
#      Calling a Function
#      Calling a Function without an Argument
#      Calling a Function with Argument Values (by position and by name)
#      Calling a Function with Default Argument
#      Lazy Evaluation of Function
#      Function closure
#      lexical scoping
#
######## ---------------------------------------------------------------------########


##Built-in Function

# Create a sequence of numbers from 32 to 44.
print(seq(32,44))

# Find mean of numbers from 25 to 82.
print(mean(25:82))

# Find sum of numbers frm 41 to 68.
print(sum(41:68))


##User-defined Function

# Create a function to print squares of numbers in sequence.


new.function <- function(x) {
                               for(i in 1:x) {
                                                   print(i^2)
                                              }
                           }	


# Calling a Function :Call the function new.function.
new.function(7)


##Calling a Function with an Argument

new.function <- function(x,z) {
                              for(i in x:z) {
                                                    y <- i^2
                                                   print(y)
                                             }
                            }

# Call the function new.function supplying 6 as an argument.

new.function(2)




##Calling a Function with an Argument

new.function <- function(v) {
  for(i in v) {
    
    y <- i^2
    print(y)
  }
}
z
# Call the function new.function supplying 6 as an argument.

new.function(c(2:6, 9,11))

## Calling a Function with Argument Values (by position and by name)

# Create a function with arguments.
new.function <- function(a,b,c) {
                                     result <- a * b + c
                                     print(result)
                                }

# Call the function by position of arguments.
new.function(5,3,11)
  

# Call the function by names of the arguments.
new.function(a = 11, b = 5, c = 3)

new.function(5, 3, a = 11)




##Calling a Function with Default Argument

new.function <- function(a = 3, b = 6) {
                                             result <- a * b
                                             print(result)
                                        }

# Call the function without giving any argument.
new.function()
  
# Call the function with giving new values of the argument.
new.function(9,5)



##Lazy Evaluation of Function
#Arguments to functions are evaluated lazily, which means so they are evaluated only when needed by the function body.
  
# Create a function with arguments.

new.function <- function(a, b) {
                                   print(a^2)
                                   print(a)
                                   #print(b)
                              }

# Evaluate the function without supplying one of the arguments.
new.function(6)



 

###----------------------------------------End of Function--------------###

#writing your own operators by function
#anything that in between  %%, can be work as operators.



"+" <- function(a,b) return(a*b)


3 %ab% 5




###---------------------Lexical scope and function closures ------------###
 
 x<- function(a)
             {
                  y <- function(b)
                         {
                            z <- function(c)
                                  {
                                      a*b*c
                                  }
                        z
                     }
              y
    }

 k<- x(10)
 k

 p <- k(20)
 p
 
 q <- p(3)
 q



 
 
#A Function that Returns a Function
make.add.to =   function(x) {
  add.x.to = function(u) x + u
  add.x.to
}

add.10.to = make.add.to(30)
add.10.to(60)
  


# Scoping
# . The scoping rules of a language describe how the values
# of variables are determined.
# . R uses block-structured scope, similar to languages like
# Algol-60 and Pascal and Scheme.
# . If a function f is defined within a function g, the
# variables in f are visible in g, unless they are shadowed
# by a local variable.


# R lexical scoping means that free variables in a function 
# (i.e. variables that are used in a function but not defined 
#  in the function) are looked up in the parent environment 
# of the function, as opposed to the environment of the caller.

# 
# Variable Capture and Closures
# . In the previous example, the variable x came into
# existence when the outer function make.add.to was
# called.
# . This variable continues to exist after make.add.to
# returns because it is required for the value returned by
# make.add.to to make sense.
# . The outer functions local variable x has been captured
# by the function returned as a value.
# . The variable x is, in a sense "enclosed" within the
# function returned by make.add.to.
# . Functions that enclose data in this way are called
# closures.



# Captured Variables are Private
# . Each time make.add.to is called, a new x variable is
# created.
add.10.to = make.add.to(10)
add.20.to = make.add.to(20)
add.10.to(100)
add.20.to(100)
# 
# . This means that each function returned by
# make.add.to has its own private x variable.
# 