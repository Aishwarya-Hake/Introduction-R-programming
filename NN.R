# ---------------------------Neural Network -------------------------------

# Neural network is an information-processing machine and can be viewed 
# as analogous to human nervous system. Just like human nervous system, 
# which is made up of interconnected neurons, a neural network is made 
# up of interconnected information processing units.

#The information processing units do not work in a linear manner. In fact, neural 
# network draws its strength from parallel processing of information, 
# which allows it to deal with non-linearity.

# A neural network is a complex adaptive system. Adaptive means it has the ability 
# to change its internal structure by adjusting weights of inputs. 

# The neural network was designed to solve problems which are easy for humans and 
# difficult for machines such as identifying pictures of cats and dogs, 
# identifying numbered pictures. These problems are often referred to as pattern 
# recognition. Its application ranges from optical character recognition to object detection.

# NN is algorithms are inspired by the human brain to performs a particular task or functions. 
# NN perform computations through a process by learning. The neural network is a set of 
# connected input/output units in which each connection has a weight associated with it. 
# In the learning phase, the network learns by adjusting the weights to predict the correct
# class label of the given inputs.

# Neural network is considered as one of the most useful technique in the world 
# of data analytics. However, it is complex and is often regarded as a black box, 
# i.e. users view the input and output of a neural network but remain clueless 
# about the knowledge generating process.

# Table of Contents
#   The Basics of Neural Network
#   Fitting Neural Network in R
#   Cross Validation of a Neural Network

#The Basics

     # Neural networks are built from units called perceptrons (ptrons). 
     # Ptrons have one or more inputs, an activation function and an output. 
     # An ANN model is built up by combining ptrons in structured layers. 
     # The ptrons in a given layer are independent of each other, but the 
     # each connect to all the ptrons in the next layer.
 
     # The input layer contains a ptron for each predictor variable

     # One or more hidden layers contain a user defined number of ptrons.
     # Each ptron in the first hidden layer receives an input from the each ptron 
     # in the input layer. If there is a second hidden layer, each ptron in this 
     # layer receives an input from each ptron in the first hidden layer, and so 
     # on with additional layers

     # The output layer contains a ptron for each response variable (usually one, 
     # sometimes more in multivariate response situations). Each output ptron receives 
     # one input from each ptron in the final hidden layer

     # The ptrons have a nonlinear activation function (e.g a logistic function) which 
     #determines their output value based upon the values of their inputs.

     # Dendrites receive signals from other neurons. Cell body sums all the inputs signals to 
     # generate output. Axon through output When the sum reaches to a threshold. Synapses is a point
     # of interaction neurons. It transmits electrical or chemical signals to another neuron. 
     # Synapse is derived from the Greek word which means conjunction.

# The weights are somewhat analogous to the coefficients of a linear model. There is also a 
# bias adjustment that represents the base Value of a ptron and is analogous to the intercept 
# in a linear model. If the inputs are near zero, the bias ensures that the output is near 
# average. However the situation is much more complex due to the network-like nature of the
# ANN. This leads to complex, non-linear relationships between the predictors and response.


# Connection Pattern : Feedforward and Feedback Artificial Neural Networks
     #There are two main types of artificial neural networks: Feedforward and feedback artificial neural networks. 
     # Feedforward neural network is a network which is not recursive. Neurons in this layer were only connected
     # to neurons in the next layer, and they are don't form a cycle. In Feedforward signals travel in only one 
     # direction towards the output layer.

     # Feedback neural networks contain cycles. Signals travel in both directions by introducing loops 
     # in the network. The feedback cycles can cause the network's behavior change over time based on its input.
     # Feedback neural network also known as recurrent neural networks. 

#Backpropagation
     #The most fundamental algorithm is named backpropagation, and we will walk through an example of this here.
     #a string containing the algorithm type to calculate the neural network. The following types are possible: 
     # 'backprop', 'rprop+', 'rprop-', 'sag', or 'slr'. 'backprop' refers to backpropagation, 'rprop+' and 
     # 'rprop-' refer to the resilient backpropagation with and without weight backtracking, while 'sag'
     # and 'slr' induce the usage of the modified globally convergent algorithm (grprop). 

#Activation Function
     #The output of a neuron can range from -inf to +inf. The neuron doesn't know the boundary. 
     # So we need a mapping mechanism between the input and output of the neuron. This mechanism of mapping 
     # inputs to output is known as Activation Function. There are many activation functions. 

     #Identity function is a function that maps input to the same output value. It is a linear operator in 
     #vector space. Also, known straight line function where activation is proportional to the input.

     #In Binary Step Function, if the value of Y is above a certain value known as the threshold, the output 
     # is True(or activated), and if it's less than the threshold, then the output is false (or not activated). 
     # It is very useful in the classifier.

     #Sigmoid Function called S-shaped functions. Logistic and hyperbolic tangent functions are commonly used 
     #sigmoid functions. There are two types of sigmoid functions.
     
     #Binary Sigmoid Function is a logistic function where the output values are either binary or vary from 0 to 1.

     #Bipolar Sigmoid Function is a logistic function where the output value varies from -1 to 1.
     #Also known as Hyperbolic Tangent Function or tanh.
     
     #Ramp Function: The name of the ramp function is derived from the appearance of its graph. It maps negative
     #inputs to 0 and positive inputs to the same output.
     
     #ReLu stands for the rectified linear unit (ReLU). It is the most used activation function in the world.
     #It output 0 for negative values of x.

#Pros and Cons
     #Neural networks are more flexible and can be used with both regression and classification problems. 
     # Neural networks are good for the nonlinear dataset with a large number of inputs such as images. 
     # Neural networks can work with any number of inputs and layers. Neural networks have the numerical 
     # strength that can perform jobs in parallel.
     #Neural Networks requires more data than other Machine Learning algorithms. NNs can be used only with 
     #numerical inputs and non-missing value datasets. 

# Use-cases of NN
# NN's wonderful properties offer many applications such as:
     # Pattern Recognition: neural networks are very suitable for pattern recognition problems such as 
     # facial recognition, object detection, fingerprint recognition, etc.
     # 
     # Anomaly Detection: neural networks are good at pattern detection, and they can easily detect the 
     # unusual patterns that don't fit in the general patterns.
     # 
     # Time Series Prediction: Neural networks can be used to predict time series problems such as stock 
     # price, weather forecasting.
     # 
     # Natural Language Processing: Neural networks offer a wide range of applications in Natural Language
     # Processing tasks such as text classification, Named Entity Recognition (NER), Part-of-Speech Tagging,
     # Speech Recognition, and Spell Checking.



#Understanding NN with smaller dataset

# TKS -(Technical Knowledge Score)
# CKS -(Communication Skills Score)
# Students placed or not placed

# creating training data set
     TKS=c(20,10,30,20,80,30)
     CSS=c(90,20,40,50,50,80)
     Placed=c(1,0,0,0,1,1)
# Here, you will combine multiple columns or features into a single set of data
     df=data.frame(TKS,CSS,Placed)
# load library
     require(neuralnet)

# fit neural network
     nn=neuralnet(Placed~TKS+CSS,data=df, hidden=c(5,3), act.fct = "logistic",
                  linear.output = FALSE)

     plot(nn)
     summary(nn)


# creating test set
     TKS=c(30,40,85)
     CSS=c(85,50,40)
     test=data.frame(TKS,CSS)

     Predict=compute(nn,test)
     Predict$net.result

# Converting probabilities into binary classes setting threshold level 0.5
     prob <- Predict$net.result
     pred <- ifelse(prob>0.5, "Placed", "Not Placed")
     pred


     
#Another example for continuous data on cerelar data --------------------------------------------
     
 
# Read the Data
data = read.csv("cereals.csv", header=T)
View(data)
# Random sampling
samplesize = 0.60 * nrow(data)
set.seed(80)
index = sample( seq_len ( nrow ( data ) ), size = samplesize )

# Create training and test set
datatrain = data[ index, ]
datatest = data[ -index, ]

View(datatrain)

# The first step is to scale the cereal dataset. The scaling of data is essential 
# because otherwise a variable may have large impact on the prediction variable only
# because of its scale. Using unscaled may lead to meaningless results. 
# The common techniques to scale data are: min-max normalization, Z-score 
# normalization, median and MAD, and tan-h estimators. The min-max normalization 
# transforms the data into a common range, thus removing the scaling effect from all
# the variables.

## Scale data for neural network

max = apply(data , 2 , max)
min = apply(data, 2 , min)
scaled = as.data.frame(scale(data, center = min, scale = max - min))

# The scaled data is used to fit the neural network. 
# We visualize the neural network with weights for each of the variable. 

# load library
library(neuralnet)


# creating training and test set
trainNN = scaled[index , ]
testNN = scaled[-index , ]

View(testNN)
# fit neural network
set.seed(2)
NN = neuralnet(rating ~ calories + protein + fat + sodium + fiber, 
               trainNN, hidden = c(5,3) , linear.output = TRUE )

summary(NN)
# plot neural network
plot(NN)

# We predict the rating using the neural network model.
# The predicted rating will be scaled and it must me 
# transformed in order to make a comparison with real rating.

## Prediction using neural network

predict_testNN = compute(NN, testNN[,c(1:5)])
predict_testNN = (predict_testNN$net.result * (max(data$rating) - min(data$rating))) + min(data$rating)

plot(datatest$rating, predict_testNN, col='blue', pch=16, ylab = "predicted rating NN", xlab = "real rating")
#abline(0,1)

# Calculate Root Mean Square Error (RMSE)
RMSE.NN = (sum((datatest$rating - predict_testNN)^2) / nrow(datatest)) ^ 0.5




## Cross validation of neural network model
# Now we will perform k-fold cross-validation on the neural network model.
# The complete data is partitioned into k equal subsets and each time a subset 
# is assigned as test set while others are used for training the model. 
# Every data point gets a chance to be in test set and training set, 
# thus this method reduces the dependence of performance on test-training 
# split and reduces the variance of performance metrics. The extreme case of 
# k-fold cross validation will occur when k is equal to number of data points. 
# It would mean that the predictive model is trained over all the data points 
# except one data point, which takes the role of a test set. This method of 
# leaving one data point as test set is known as leave-one-out cross validation.

# # install relevant libraries
# install.packages("boot")
# install.packages("plyr")

# Load libraries
library(boot)
library(plyr)

# Initialize variables
set.seed(50)
k = 10
RMSE.NN = NULL
List = list( )

#sample(1:nrow(data),40 )
# Fit neural network model within nested for loop
for(j in 20:65){
     for (i in 1:k) {
          index = sample(1:nrow(data),j )
          
          trainNN = scaled[index,]
          testNN = scaled[-index,]
          datatest = data[-index,]
          
          NN = neuralnet(rating ~ calories + protein + fat + sodium + fiber, trainNN, hidden = 3, linear.output= T)
          predict_testNN = compute(NN,testNN[,c(1:5)])
          predict_testNN = (predict_testNN$net.result*(max(data$rating)-min(data$rating)))+min(data$rating)
          
          RMSE.NN [i]<- (sum((datatest$rating - predict_testNN)^2)/nrow(datatest))^0.5
     }
     List[[j]] = RMSE.NN
}

Matrix.RMSE = do.call(cbind, List)
View(Matrix.RMSE)
dim(Matrix.RMSE)
# The RMSE values can be accessed using the variable Matrix.RMSE. 
# The size of the matrix is large; therefore we will try to make sense 
# of the data through visualizations. First, we will prepare a boxplot 
# for one of the columns in Matrix.RMSE, where training set has length 
# equal to 65. One can prepare these box plots for each of the training
# set lengths (10 to 65).

## Prepare boxplot
boxplot(Matrix.RMSE[,45], ylab = "RMSE", 
        main = "RMSE BoxPlot (length of traning set = 65)")

#checking all data points
# boxplot(Matrix.RMSE, ylab = "RMSE", main = "RMSE BoxPlot (length of traning set = 65)")


# #Now we will study the variation of RMSE with the length of training set. 
# We calculate the median RMSE for each of the training set length and plot them.

## Variation of median RMSE 
#install.packages("matrixStats")

library(matrixStats)

med = colMedians(Matrix.RMSE)

X = seq(20,65)

plot (med~X, type = "l", xlab = "length of training set", ylab = "median RMSE", main = "Variation of RMSE with length of training set")

# The aim is to predict the rating of cereals using information such as calories, 
# fat, protein etc. After constructing the neural network we evaluate the model 
# for accuracy and robustness. We compute RMSE and perform cross-validation analysis. 
# In cross validation, we check the variation in model accuracy as the length of 
# training set is changed. We consider training sets with length 10 to 65. For each 
# length a 100 samples are random picked and median RMSE is calculated. We show that
# model accuracy increases when training set is large.  Before using the model for 
# prediction, it is important to check the robustness of performance through cross 
# validation.
