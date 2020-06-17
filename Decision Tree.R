library(rpart)
library(ggplot2)
library(rlist)
library(gridExtra)
library(grid)
library(corrplot)
#library(DAAG)
#Beautify tree
library(rattle)
library(rpart.plot)
library(RColorBrewer)
library(pROC)


#read data file
data= read.csv("Credit_Risk_Train_data.csv", na.strings= c("","NA"))
View(data)

#checking structure & summary of the data
str(data)
summary(data)

#treating unique identifier columns
data <- data[,-1]

#credit history as factor
data$Credit_History <- as.factor(data$Credit_History)

# #detecting and treating missing values
colSums(is.na(data))

(colSums(is.na(data))/nrow(data))*100

apply(is.na(data), c(2), sum)


# % of NA's in dataframe
sum(is.na(data))/prod(dim(data)) *100


# % of row affected by NA's
nrow(data[is.na(data),])/nrow(data) *100

data <- na.omit(data)
complete.cases(data)

#segregating Numeric & factor data
data.numeric <- data[sapply(data, is.numeric)]
data.factor <- data[sapply(data, is.factor)]

#Analysing & treating NA's in numeric data
summary(data.numeric)


#deleting the na's, any one will work.
data.numeric <- na.omit(data.numeric)
data.numeric <- data.numeric[complete.cases(data.numeric),]

#Imputing single column
  
 data.numeric$LoanAmount <- ifelse(is.na(data.numeric$LoanAmount),
                               mean(data.numeric$LoanAmount, na.rm = TRUE), 
                               data.numeric$LoanAmount)

 
 data.numeric$LoanAmount[is.na(data.numeric$LoanAmount)] <- 
   mean(data.numeric$LoanAmount, na.rm = TRUE)

#Imputation with mean
for(i in seq(data.numeric)) {
data.numeric[i]<- ifelse(is.na(data.numeric[,i]), 
                         mean(data.numeric[,i], na.rm = T), data.numeric[,i])
}
# for(i in seq(data.numeric))
#   data.numeric[is.na(data.numeric[,i]),]<- mean(data.numeric[,i], na.rm = T)

#check summary again
summary(data.numeric)

mode
#imputing categorical varibales with mode
summary(data.factor)

#mode function
getmode <- function(x) {
  x <- x[!is.na(x)]
  uniqv <- unique(x)
  uniqv[which.max(tabulate(match(x, uniqv)))]
}

table(data.factor$Property_Area)
getmode(data.factor$Property_Area)


#table(data.factor$Gender)
#Single column mode replacement
data.factor$Credit_History[is.na(data.factor$Credit_History)] <- 
  getmode(data.factor$Credit_History)


#imputation with mode
for(i in seq(data.factor))
  data.factor[,i][is.na(data.factor[,i])] <- getmode(data.factor[,i])


#check summary again
summary(data.factor)

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

 skewness(data.numeric$ApplicantIncome)
 #boxplot analysis
 boxplot(data.numeric$ApplicantIncome)
 
 data.numeric$ApplicantIncome <- log10(data.numeric$ApplicantIncome)

#Do outlier analysis etc..preprocess the data.
 
 
 #to check outliers by means of quantile.
 out_qua_fix = function(x){
   m=mean(x)
   s=sd(x)
   lc=m-3*s #lower cut-off
   uc=m+3*s
 
   #n=sum(x>uc | x<lc)
   out_value <- which(x > uc | x < lc)
   aq_qua_fix <- aq[-out_value,]
   return(aq_qua_fix)
 }
 
 out_std_check(aq$Temp) 
 
 
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

data.numeric <- out_std_fix(data.numeric,2, 3) # calling fix function to fix outlier.


 #log10(data.numeric$ApplicantIncome)
#
# #bar plot for categorical varibale etc.
#
  factplot <- function(column, df)
      {
        ggplot(df, aes_string(x=column))+
          geom_bar(fill = "blue", color = "black", alpha= 0.2)+
          xlab(column)
      }
#calling all bar plot
  fp <- lapply(colnames(data.factor), factplot, df=data.factor)
  do.call("grid.arrange", fp)
#
#
  
  chisq.test(data.factor$Gender, data.factor$Loan_Status)
  
  a = data.numeric$ApplicantIncome
  y = data.numeric$LoanAmount 
  x= data.factor$Gender
  q <- data.factor$Education
  
  p <- aov(y~x+q)
  summary(p)
  p <- manova(cbind(a,y) ~x+q)
  summary(p)
  summary.aov(p)
  
  
#
 #Significance with target variable.
  sigficant_var <- list()
  df <- data.factor
  for(i in 1:(length(df)-1))
  {
    y<-  chisq.test(table(df[,i], df[,k]))
    vec<-c(Var=paste(colnames(df[length(df)]),"-",colnames(df[i])), y$statistic, pval=y$p.value, significant = (if(y$p.value<0.05 & y$p.value!='NaN') "yes" else "no"))
    sigficant_var<-list.append(sigficant_var, vec)
  }

  print(sigficant_var)
  str(sigficant_var)


  # y <- data.factor$Loan_Status
  # x <- data.numeric$LoanAmount
  #
  # aov(y~ data.numeric$ApplicantIncome+data.numeric$CoapplicantIncome)
  #

  df <- data.factor    #this supposed to be a data frame
  x<-list()       # return var as a list
  for (i in 1:length(df))
  {
    if(i < length(df)){ k= i+1 }
    if((class(df[,i])== class(df[,k])) & class(df[,i])=='factor' )
    {
      y<-  chisq.test(table(df[,i], df[,k]))
      vec<-c(Var=paste(colnames(df[i]),"-",colnames(df[k])), y$statistic, pval=y$p.value, significant = (if(y$p.value<0.05 & y$p.value!='NaN') "yes" else "no"))
      x<-list.append(x, vec)
    }
  }
  print(x)
#
#
  #data.numeric <- na.omit(data.numeric)
#Checking co-relation matrix.
  descrCor <- cor(data.numeric)
  #print(descrCor)
  corrplot(descrCor)
  
  corrplot(descrCor, type = "upper", method = "number")
  corrplot.mixed(descrCor, lower.col = "black", number.cex = .7)

#converting credit histroy variable into factor variable and merging both
#merging both data set after cleaning
data <- cbind(data.numeric, data.factor)

set.seed(99)
s=sample(1:nrow(data),0.70*nrow(data))

train.data <- data[s,]
test.data <- data[-s,]
# dim(data)
# View(test.data)
test.data.new <- test.data[,-12]
colnames(test.data.new)

#Applying rpart algorithms
regressor <- rpart(formula = Loan_Status ~ .,
                   data= train.data, method="class")


#-------------Pruning parameters----------------
regressor <- rpart(formula = Loan_Status ~ .,data= train.data, method="class",
                   control = rpart.control(cp=0.001))
# #
# (cp = 0.001, minsplit = 20, minbucket = 7,
#   maxdepth = 10, usesurrogate = 2, xval =10 )

#LOSS function ---Boosting---------------
regressor <- rpart(formula = Loan_Status ~ .,data= train.data, method="class",
                   parms=list(loss=matrix(c(0,1,10,0), byrow=TRUE, nrow=2)),
                   control = rpart.control(cp = 0.001, minsplit = 20, minbucket = 7,
                    maxdepth = 10, usesurrogate = 2, xval =10 ))



regressor
printcp(regressor)
summary(regressor)

rpart.plot::rpart.plot(regressor)



#view3- fancy Plot
#rattle()
fancyRpartPlot(regressor)

########Pruning#############

printcp(regressor)
bestcp <- regressor$cptable[which.min(regressor$cptable[,"xerror"]),"CP"]

# Prune the tree using the best cp.
pruned <- prune(regressor, cp = bestcp)

# Plot pruned tree
fancyRpartPlot(pruned)


#PREDICTION
pred <- predict(regressor, test.data.new, type = 'class')

#RESULT & ACCURACY
conf_mat <- table(test.data$Loan_Status, pred)
Acc <- (conf_mat[1,1]+conf_mat[2,2])/sum(conf_mat)
conf_mat
Acc
#ROC-AUC CURVE
#library(pROC)

pred_test_roc=ifelse(pred=="Y",1,0)
test_loan_status_roc=ifelse(test.data$Loan_Status=="Y",1,0)

roccurve=roc(test_loan_status_roc, pred_test_roc)
plot(roccurve)
auc(roccurve)


#Random Forest
library(randomForest)
regressor <- randomForest(formula = Loan_Status ~ .,
                          data= train.data, ntree = 10, mtry=6)

regressor
?randomForest

plot(regressor)

regressor$importance

regressor$err.rate
# ##############
# 
# 
# # confusion matrix (training data)
# conf.matrix <- table(train.data$Loan_Status, predict(pruned,type="class"))
# rownames(conf.matrix) <- paste("Actual", rownames(conf.matrix), sep = ":")
# colnames(conf.matrix) <- paste("Pred", colnames(conf.matrix), sep = ":")
# 
# print(conf.matrix)
# 
# 
# #Scoring
# library(ROCR)
# val1 = predict(pruned, test.data.new, type = "prob")
# #Storing Model Performance Scores
# pred_val <- prediction(val1[,2], test.data$Loan_Status)
# 
# 
# # Calculating Area under Curve
# perf_val <- performance(pred_val,"auc")
# perf_val
# 
# # Calculating True Positive and False Positive Rate
# perf_val <- performance(pred_val, "tpr", "fpr")
# 
# # Plot the ROC curve
# plot(perf_val, col = "green", lwd = 1.5)
# 
Gender
Loan_Status

attach(data)
data$Gender
library(ggplot2)
ggplot(data)+ aes(x=Loan_Status)+
  geom_bar(aes(fill=factor(Gender)))
