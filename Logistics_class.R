#library(rpart)
library(ggplot2)
library(rlist)
library(gridExtra)
library(grid)
library(corrplot)
#library(DAAG)
#Beautify tree
# library(rattle)
# library(rpart.plot)
library(RColorBrewer)
library(pROC)
library(e1071)

#read data file
data= read.csv("Credit_Risk_Train_data.csv", na.strings=c("","NA"))
View(data)


#checking structure & summary of the data
str(data)
summary(data)

#treating unique identifier columns
data <- data[,-1]

#credit history as factor
data$Credit_History <- as.factor(data$Credit_History)

#unique(data$Loan_Amount_Term)

# #detecting and treating missing values
colSums(is.na(data))
apply(is.na(data), c(2), sum)


# % of NA's in dataframe
sum(is.na(data))/prod(dim(data)) *100


# % of NA's contains as row
nrow(data[!complete.cases(data),])/nrow(data) *100


#segregating Numeric & factor data
data.numeric <- data[sapply(data, is.numeric)]
data.factor <- data[sapply(data, is.factor)]

#Analysing & treating NA's in numeric data
summary(data.numeric)


#deleting the na's, any one will work.
     # data.numeric <- na.omit(data.numeric)
     # data.numeric <- data.numeric[complete.cases(data.numeric),]

#Imputing single column
     # 
     # data.numeric$LoanAmount <- ifelse(is.na(data.numeric$LoanAmount),
     #                                   mean(data.numeric$LoanAmount, na.rm = TRUE), 
     #                                   data.numeric$LoanAmount)
     # 

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
     uniqv <- unique(x)
     uniqv[which.max(tabulate(match(x, uniqv)))]
}

# table(data.factor$Property_Area)
# getmode(data.factor$Property_Area)
# 
# 
# #table(data.factor$Gender)
# #Single column mode replacement
# data.factor$Credit_History[is.na(data.factor$Credit_History)] <- getmode(data.factor$Credit_History)


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


$data.factor$Loan_Amount_Term  = as.factor(data.numeric$Loan_Amount_Term)

data.numeric <- data.numeric[-4]

np <- lapply(colnames(data.numeric), numplot, df=data.numeric)
do.call("grid.arrange", np)

#Check with skewness
data.skewed <- apply(data.numeric, c(2), skewness)
data.skewed
skewness(data.numeric$ApplicantIncome)
#boxplot analysis
boxplot(data.numeric$ApplicantIncome)

View(data.numeric)

data.numeric$ApplicantIncome <- log10(data.numeric$ApplicantIncome)
data.numeric$Loan_Amount_Term <- ((data.numeric$Loan_Amount_Term)^2)
#data.numeric$Loan_Amount_Term <- (log10(data.numeric$LoanAmount)
data.numeric$CoapplicantIncome <- (data.numeric$CoapplicantIncome)^(1/3)
data.numeric$LoanAmount <- log10(data.numeric$LoanAmount)^0.5

#Do outlier analysis etc...preprocess the data.


#to check outliers by means of quantile.
out_qua_fix = function(x){
     m=mean(x)
     s=sd(x)
     lc=m-3*s #lower cut-off
     uc=m+3*s
     # Q1 = quantile(x, 0.25, na.rm = T)
     # Q3 = quantile(x, 0.75, na.rm = T)
     # IQR = Q3 - Q1
     # lc = Q1 - m*IQR #lower cut-off
     # uc = Q3 + m*IQR #upper cut-off
     #n=sum(x>uc | x<lc)
     out_value <- which(x > uc | x < lc)
     #aq_qua_fix <- aq[-out_value,]
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

data.numeric <- out_std_fix(data.numeric,1, 3) # calling fix function to fix outlier.


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
chisq.test(data.factor$Property_Area, data.factor$Loan_Status)

x <- aov(data.numeric$ApplicantIncome~ data.factor$Property_Area)
summary(x)
#

summary(data.factor)
data.factor <- data.factor
#Significance with target variable.
sigficant_var <- list()
df <- data.factor
for(i in 1:(length(df)-1))
{    k= i+1
     y<-  chisq.test(table(df[,i], df[,k]))
     vec<-c(Var=paste(colnames(df[length(df)]),"-",colnames(df[i])), pval=y$p.value, significant = (if(y$p.value<0.05 & y$p.value!='NaN') "yes" else "no"))
     sigficant_var<-list.append(sigficant_var, vec)
}

print(sigficant_var)
str(sigficant_var)


chisq.test(data.factor$Loan_Status, data.factor$Credit_History)

chisq.test(data.factor$Loan_Status, data.factor$Credit_History)

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
#Checking co-relation matrix.
descrCor <- cor(data.numeric)
print(descrCor)
corrplot(descrCor, type = "upper", method = "number")
corrplot.mixed(descrCor, lower.col = "black", number.cex = .7)

#converting credit histroy variable into factor variable and merging both
#merging both data set after cleaning
data <- cbind(data.numeric, data.factor)

set.seed(99)
s=sample(1:nrow(data),0.70*nrow(data))

train.data <- data[s,]
test.data <- data[-s,]
# dim(test.data)
# View(test.data)
test.data.new <- test.data[,-11]
colnames(test.data.new)

View(train.data)

model=glm(Loan_Status~.,data=train.data,family=binomial("logit"))

summary(model)



#stepwise sleection:

nullModel<- glm(Loan_Status ~ 1, data=train.data,family=binomial("logit"))

#summary(nullModel)

fullmodel <- glm(Loan_Status ~., data=train.data,family=binomial("logit"))
#summary(fullmodel)

fit <- step(nullModel, scope=list(lower=nullModel, upper=fullmodel), direction="both")

#revel the model
fit


#Final model
model <- glm(formula = Loan_Status ~ Credit_History + Property_Area + 
            Married, family = binomial("logit"), data = train.data)


summary(model)



dim(test.data)
dim(test.data.new)
length(fitted.results)

fitted.results = predict(model,newdata=test.data.new, type='response')
View(fitted.results1)

fitted.results1 = ifelse(fitted.results >=0.5  ,1,0)

#confusion matrix
table(fitted.results1)
table(test.data$Loan_Status)
cf1 = table(test.data$Loan_Status, fitted.results1)
cf1


TP=126 
FP=5
FN=25
TN=29



accuracy = TN+TP / TP+FP+FN+TN     (94+18)/(94+18+8+20)
Sensitivity=TP/(TP+FN)   94/(94+8)
Sensitivity
specificity=TN/(TN+FP)   18/(18+20)
specificity
Accuracy=317/333
Accuracy
error=FP+FN/P+N
error

test.data$Loan_Status1=ifelse(test.data$Loan_Status=="Y",1,0)

library(pROC)
roccurve=roc(test.data$Loan_Status1, fitted.results1)
plot(roccurve)
auc(roccurve)

?roc






#Deviance
#Deviance is a measure of goodness of fit of a model. Higher numbers always indicates bad fit.

#Fisher Iterations.
#Fisher scoring is a hill-climbing algorithm for getting results - it maximizes the likelihood by getting successively closer and closer to the maximum by taking another step ( an iteration).  It knows when it has reached the top of the hill in that taking another step does not increase the likelihood.  It is known to be an efficient procedure - not many steps are usually needed - and generally converges to an answer. When this is the case you do not need to be concerned about it - accept what  you have got.



#VIF
#Like in case of linear regression, we should check for multicollinearity in the model. 
#vif(logitMod)

#Misclassification Error
# Misclassification error is the percentage mismatch of predcited vs actuals, irrespective of 1's or 0's. 
# The lower the misclassification error, the better is your model.
#misClassError(testData$ABOVE50K, predicted, threshold = optCutOff)
#=> 0.0899

#ROC -Greater the area under the ROC curve, better the predictive ability of the model.


