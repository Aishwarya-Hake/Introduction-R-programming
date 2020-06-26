library(rpart)  #CART Tree
library(rattle) # Detailed Tree ploting
library(rpart.plot) # Tree plot 
library(ggplot2)
library(rlist)
library(gridExtra)
library(grid)
library(corrplot)
#library(DAAG)
library(RColorBrewer)
library(pROC)
library(randomForest)
library(e1071)

#read data file
data= read.csv("Churn.csv", na.strings=c("","NA"))
View(data)

#checking structure & summary of the data
str(data)
summary(data)

#treating unique identifier columns
data <- data[,-1]

#credit history as factor
data$SeniorCitizen <- ifelse(data$SeniorCitizen>0.5,"Yes","NO")
data$SeniorCitizen <- as.factor(data$SeniorCitizen)

levels(data$SeniorCitizen)

# #detecting and treating missing values
colSums(is.na(data))


#segregating Numeric & factor data
data.numeric <- data[sapply(data, is.numeric)]
data.factor <- data[sapply(data, is.factor)]

#Analysing & treating NA's in numeric data
summary(data.numeric)


#Analysing histogram of each numeric values
numplot <- function(column, df)
{
     ggplot(df, aes_string(x=column))+
          geom_histogram(aes(y=..density..),fill = "grey", color = "black")+
          geom_density(fill='blue', alpha=0.2)+
          xlab(column)
}


np <- lapply(colnames(data.numeric), numplot, df=data.numeric)
do.call("grid.arrange", np)


data.skewed <- apply(data.numeric, c(2), skewness)
data.skewed

data.kurtosis <- apply(data.numeric, c(2), kurtosis)
data.kurtosis

#boxplot analysis
apply(data.numeric,c(2), boxplot)


out_std_fix = function(x, y, f){
     m=mean(x[,y])
     s=sd(x[,y])
     lc=m-f*s #lower cut-off
     uc=m+f*s #upper cut-off
     out_value <- which(x[,y] > uc | x[,y] < lc)
     #aq_sd_fix <- aq[-out_value,]
     x[out_value,y] <- m
     x[,y]<-floor(x[,y])
     return(x)
}

data.numeric <- out_std_fix(data.numeric,3, 3) # calling fix function to fix outlier.

#Transformation
#data.numeric$TotalAmount <- log10(data.numeric$TotalAmount)


data.numeric$TotalAmount <- (data.numeric$TotalAmount)^(1/3)
 #data.numeric$TotalAmount <- log10(data.numeric$TotalAmount)

# #bar plot for categorical varibale etc.
#
factplot <- function(column, df)
{
     ggplot(df, aes_string(x=column))+
          geom_bar(fill = "blue", color = "black", alpha= 0.2)+
          xlab(column)
}
#calling all bar plot
fp <- lapply(colnames(data.factor[1:5]), factplot, df=data.factor)
do.call("grid.arrange", fp)

          # View(data[c(2,20)])
          # 
          # data$SeniorCitizen <- ifelse(data$SeniorCitizen > 0.5,"Y","N")
          # 
          # colnames(data)

#Significance with target variable.
sigficant_var <- list()
df <- data.factor
for(i in 1:(length(df)-1))
{
     k= i+1
     y<-  chisq.test(table(df[,i], df[,k]))
     vec<-c(Var=paste(colnames(df[length(df)]),"-",colnames(df[i])), y$statistic, pval=y$p.value, significant = (if(y$p.value<0.05 & y$p.value!='NaN') "yes" else "no"))
     sigficant_var<-list.append(sigficant_var, vec)
}

print(sigficant_var)
str(sigficant_var)


#chisq.test(data.factor$Churn, data.factor$SeniorCitizen)


data <- cbind(data.numeric,data.factor)

#sampling

set.seed(99)
s=sample(1:nrow(data),0.70*nrow(data))
train=data[s,]
test=data[-s,]
#View(train)
colnames(train)
test1 <- test[,-20]

 # 
#  #model <- rpart(Churn~., data = train, method="class")
#  
#  model <- rpart(Churn~., data = train, method="class",
#                 control = rpart.control(cp = 0.001, minsplit =1000))
# 
#  model
#  printcp(model)
#  summary(model)
#  
#  rpart.plot::rpart.plot(model)
# 
#  #rattle()
#  fancyRpartPlot(model) 
#  
#  ?rpart
# 
# 
#  pred <- predict(model, test1, type = "class") 
#  
#  table(pred)
# 
#  
#  #RESULT & ACCURACY
#  conf_mat <- table(test$Churn, pred)
#  Acc <- (conf_mat[1,1]+conf_mat[2,2])/sum(conf_mat)
#  conf_mat
#  Acc
#  #ROC-AUC CURVE
#  #library(pROC)
#  
#  
#  levels(test$Churn)
#  View(test$Churn)
#  
#  pred_test_roc=ifelse(pred=="Yes",1,0)
#  test_loan_status_roc=ifelse(test$Churn=="Yes",1,0)
#  
#  roccurve=roc(test_loan_status_roc, pred_test_roc)
#  plot(roccurve)
#  auc(roccurve)
# 
#  
 
 # 
 #  #LOSS function ---Boosting---------------
 # regressor <- rpart(Churn~., data = train, method="class",
 #                    parms=list(loss=matrix(c(0,1,10,0), byrow=TRUE, nrow=2)))
 # 
 # 
 # #rattle()
 # fancyRpartPlot(regressor) 
 # 
 
 
 
 ##############Random forest
 
 
 #Random Forest
 library(randomForest)
 m1 <- randomForest(Churn~., data = train,
                    ntree = 40, mtry = 6)
                    
 #ntree = 10, mtry=6
 plot(m1)

?tune.randomForest
?tuneRF

 m1$err.rate
 m1$importance
 m1$err.rate
 
 importance(m1)
 varImpPlot(m1)
 

p2 <- predict(m1, test1)

dim(test1)
length(p2)
table(p2,test$Churn)


pred <- predict(m1, test1)

plot(m1)
