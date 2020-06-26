
data <- read.csv(file.choose())
View(data)
str(data)
summary(data)

data <- data[,-1]
plot(data$Salary)
ggplot(data,aes(x=data$Salary,y=..density..))+geom_histogram()+geom_density(fill="red",alpha=0.3)
ggplot(data,aes(x=data$Level,y=data$Salary))+geom_point()

fit <- lm(data$Salary~.,data=(data))
summary(data)
nrow(data)
a<- data.frame(Level=6.5)
a1<- data.frame(Level=c(6.5,4.5))


pred <- predict(fit,a1)
pred
View(pred)
plot(fit)
plot(hit)
View(data)
data$Level2=data$Level^2
data$Level3=data$Level^3
data$Level4=data$Level^4
data$Level5=data$Level^5
data$Level6=data$Level^6
data$Level7=data$Level^7

poly_reg=lm(formula = Salary~.,data=data)
predict(poly_reg,data.frame(Level=6.5,
                            Level2=6.5^2,
                            Level3=6.5^3,
                            Level4=6.5^4,
                            Level5=6.5^5,
                            Level6=6.5^6,
                            Level7=6.5^7))


ggplot(data,aes(x=data$Level,y=data$Salary),color='red')+
  geom_line(aes(x=data$Level,y=predict(poly_reg,newdata = data)),color='blue')+geom_point()
  
ggtitle('truth or bluff(polynomial regration)')+
  xlab(data$Level)+
  ylab(data$Salary)





##Logistic regration#########

# why we call it  regreation? ####imp#
#|_>1.
#\_>2.output of loogistic not pass or fail it is numeric...so it is regration
#95% tym it is used in binary regration#
##convert into s-Shape curve ##
#3.#log is symetric##
#log(0dd)=log(p/1-p)---logic fun(convert probability to logictic)
 #log(p/1-p)=log(0dd)
 #p/1-p=e^log(0dd)
#P=(1-P)log(0dd)
#P=e^log(0dd)-P.elog(0dd)
#p+p.e^log(0dd)=P.elog(0dd)
#z#[p=P.e^log(0dd)/1+P.e^log(0dd)]------sigmoistic function(logistic to probability)


#####logistic regration ######
data <- read.csv(file.choose())
View(data)
str(data)
summary(data)

colSums(is.na(data))
apply(is.na(data),2,sum)
data <- na.omit(data)

data <- data[,-1]
data.numeric <- data[sapply(data,is.numeric)]
data.factor <- data[sapply(data,is.factor)]
set.seed(99)
s <- sample(1:nrow(data),0.70*nrow(data))
train <- data[s,]
test <- data[-s,]
View(test)
test <- test[,-12]
model <- glm(Loan_Status~.,data=train,family = binomial("logit"))
nullmodel <-glm(Loan_Status~1,data=train,family = binomial("logit")) 
fullmodel <- glm(Loan_Status~.,data=train,family = binomial("logit"))
fit <- step(nullmodel,scope = list(lower=nullmodel,upper=fullmodel),direction = "both")
fit
model <- glm(formula = Loan_Status ~ Credit_History+Property_Area+Married,family = binomial("logit"),data=train)

fitted.result=predict(model,newdata = test,type = 'response')

fitted.result1=ifelse(fitted.result>=0.5,1,0)
View(fitted.result1)
cf1 <- table(test1$Loan_Status,fitted.result1)
cf1
test <- test[,-12]
test1 <- data[-s,]


