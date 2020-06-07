#### ------------------------ Control Structures  ----------------####

# There are eight control Structures in R listed below:
# if
# if-else
# for
# nested loops
# while
# repeat and break
# next
# return


####  if, else, else if Statements

# Use case- let's say we have two variables, hot and temp. Imagine that hot starts off as FALSE and temp is some number in degrees. 
#If the temp is greater than 80 than we want to assign hot==TRUE.

hot <- FALSE
temp <- 32


if (temp > 36)
     {
          hot <- TRUE
  
     }

print (hot)


# Reset temp

temp <- 100

if (temp > 80)
     {
          hot <- TRUE
  
     }

print (hot)



## Use of Else

temp <- 34

if (temp > 36)
     {
           print("Hot outside!")
     } else {
          
           print("Its not too hot today!")
     }


## Use of elseif
 
temp <- 50               # take example of 33 & 50

if (temp > 80)
     {           print("Hot outside!")
     
     } else if(temp < 80 & temp >= 50){
          
          print('Nice outside!')
          
     } else if(temp <= 50 & temp > 32){
          print("Its cooler outside!")
          
     } else{
          print("Its really cold outside!")
     }



####   for loops

#For loop over a vector

vec <- c(11,12,13,14,15,17,19,21)

#vec <- 1:100

for (x in vec) {
                
        if(x%%2 == 0){
    
                    print(x)
                  }
   
               }




#The other way would be to loop a numbered amount of times and then use indexing to continually 
#grab from the vector:
v <- 10:60
for (i in 1:length(v)){
                              
  
   if(i==1 |(v[i]%%3==0)){
        
       cat("Value at",i,"location is", v[i])

      }
} 


## For loop over a list

vec <- c(1,2,3,4,5)
li<- list(vec, women)

for (x in li)  {
                 print(x)
               }



#with index values.
for (i in 1:length(li)) 
  {
                           #    print(li[i]) # Remember to use double brackets!
     if(i==2){                    
        print(li[[i]][,'height'])
}
  }


# for( x in li[[i]][,'height'])
# {
#   if(x%%2==0)
#     print(x)
# }


#For loop with a matrix

mat <- matrix(1:25,nrow=5)
mat
for (x in mat ){
                    print(x)
                }




# Nested  for loops


for (row in 1:nrow(mat)){
     
     for (col in 1:ncol(mat)){
          
      if((col == 2|col==3)&(row==4|row==5))
       {
          print(mat[row,col])
       }
        #print(paste('The element at row:',row,'and col:',col,'is',mat[row,col]))
     }
}


# for loop with function

for(i in seq_along(month.abb))
{  
   if(i%%2==0 & i!=12){
     print(month.abb[i])
   }
}



### while loops

#Here's a real quick side note on printing variables along with strings:


print('Just a string')

#var <- 'a variable'
#cat('My variable is: ',var)

var <- 25
rm(x)
x <- cat('My number is:',var)

print('Just a string', var)

x<- paste('My number is:',var)


#|-------------------------------------------------------------

#while loop

x <- 0

while(x < 10){
  
  cat('x is currently: ',x)
  #print(' x is still less than 10, adding 1 to x')
  
 # add one to x
  x <- x+2
}



v <- seq(21,99,2)
x<- 1

while(x <= length(v))
  {
   if(v[x]== 69){ 
                  cat(v[x], "Vlaue is at postion", x)
    
                 }
     x<-x+1
}


while(v[x]!=69)
  {
  x <- x+1
  }

print(x)





## Lets add if statment to this 

x <- 0

while(x < 10){
  
  cat('x is currently: ',x)
  print(' x is still less than 10, adding 1 to x')
  
  # add one to x
  x <- x+1
  if(x==7){
    print("x is equal to 10! Terminating loop")
  }
}


# Use of break stmt

x <- 0

while(x < 10){
  
  #cat('x is currently: ',x)
 
  # add one to x
  x <- x+1
  if(x==7){
    print("x is equal to 7!")
    break
    print("I will also print, woohoo!")
  }
}



#use of break & Next 



### or Break and Next in for loop;

m <- matrix(14:25, 2)
for (i in seq(nrow(m))) {
          for (j in seq(ncol(m))) {
          
           if (m[i, j] > 21) {
               print(m[i, j])
               break
          }
          if (m[[i, j]] > 17 &  m[[i, j]] < 20){
            next
            print(m[i, j]) 
            
           
          }
     }
}


mat <- matrix(14:25, 2)

for (row in 1:nrow(mat)){
  
  for (col in 1:ncol(mat)){
    
        if(mat[row,col] > 21)
        {
            print(mat[row,col])
            break
        }
    
      if(mat[row,col] > 17 & mat[row,col] <20)
      {
        next
        print(mat[row,col])
      
      }
    
    }
}


# use of repeat funtion
#The repeat loop is an infinite loop and always used in association with break statement.

x<- 5

repeat {
     
     print(x)
      x <- x+1
      if (x > 7){ break }
}


#use of Stop and warning function.

x <- 1

repeat {
      
      print(x)
     if (x > 4){ warning('The no. must be less than 4')}
     if (x > 5){ stop('The no. must be less than 5')}
    
    x <- x+1
}


 
# use of return

check <- function(x) {
     if (x > 0) {
          result <- "Positive"
     } else if (x < 0) {
          result <- "Negative"
     } else {
          result <- "Zero"
     } 
     return(result)
}

# calling a function.

x<-check (0)
x
 


