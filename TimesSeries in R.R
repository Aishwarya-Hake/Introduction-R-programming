# Time Series forcasting in R
#data used : Airpassenger
#techinqiues used : ARIMA & SARIMA
# Assumptions of ARIMA model
# 1. Data should be stationary - by stationary it means that the properties of the series
# doesn't depend on the time when it is captured. A white noise series and series with 
# cyclic behavior can also be considered as stationary series.
#  2. Data should be univariate - ARIMA works on a single variable. 
# Auto-regression is all about regression with the past values.

# Steps to be followed for ARIMA modeling:
#   
#   1. Exploratory analysis
# 2. Fit the model
# 3. Diagnostic measures



# # 1. Introduction to Stationarity
# # 'Stationarity' is one of the most important concepts you will come across when working with 
# time series data. A stationary series is one in which the properties - 
#   mean, variance and covariance, do not vary with time.
# # In the first plot, we can clearly see that the mean varies (increases) with time 
# which results in an upward trend. Thus, this is a non-stationary series. 
# For a series to be classified as stationary, it should not exhibit a trend.
# # Moving on to the second plot, we certainly do not see a trend in the series, 
# but the variance of the series is a function of time. As mentioned previously, 
# a stationary series must have a constant variance.
# # If you look at the third plot, the spread becomes closer as the time increases,
# which implies that the covariance is a function of time.


#Load the libraries
library(forecast)
library(tseries)

View(AirPassengers)

#This tells you that the data series is in a time series format
class(AirPassengers)

#This is the start of the time series
start(AirPassengers)

#This is the end of the time series
end(AirPassengers)

#The cycle of this time series is 12months in a year
frequency(AirPassengers)

#The number of passengers are distributed across the spectrum
summary(AirPassengers)

#This will plot the time series
plot(AirPassengers)

# This will fit in a line
abline(reg=lm(AirPassengers~time(AirPassengers)))

#This will print the cycle across years.
cycle(AirPassengers)

#This will aggregate the cycles and display a year on year trend
plot(aggregate(AirPassengers,FUN=mean))

#Box plot across months will give us a sense on seasonal effect
boxplot(AirPassengers~cycle(AirPassengers))

# Important Inferences
# The year on year trend clearly shows that the #passengers have been increasing without fail.
# The variance and the mean value in July and August is much higher than rest of the months.
# Even though the mean value of each month is quite different their variance is small. 
#   Hence, we have strong seasonal effect with a cycle of 12 months or less.
# Exploring data becomes most important in a time series model - 
#  without this exploration, you will not know whether a series is stationary or not. 
#  As in this case we already know many details about the kind of model we are looking out for.


#Primaly four components
#  Trends , Seasonlity, Cyclicity, Irregularity or Randomness.

#Decomposing the data
tsdata<- ts(AirPassengers, frequency = 12)
ddata <- decompose(tsdata, "multiplicative")
plot(ddata)

#When not to use time series
# 1. when values are constant over a period of time.
# 2. when it is function of cosine or sine etc.

#Staionarity of time series depend on :
# 1. Mean - Should not be a function of time.
# 2. Variance - Should not be a function of time.
# 3. Co-Variance. for ith term and (n-1)ith term should not be a function of time.

#ARIMA - Auto Regration Integraded Moving Avg.
#Moving Avrage - is a techniue to get overall idea of the trends

#AR - ice cream example - Spike drop slowly
#MV - Bag example - Sudden spike & drop

# order ( p,d,q)
  # p- no. of AR term
  # d - degree of diiference needed to achive stationarity.
  # q - no. of lagged forcast error in prediction avg., no. of degree for Moving Avg.


#Process of Building Model


#Stationarize the Series
#   Detrending : Here, we simply remove the trend component from the time series. For instance, the equation of my time series is:
#     x(t) = (mean + trend * t) + error, simply remove the part in the parentheses and build model for the rest.

# Differencing : This is the commonly used technique to remove non-stationarity. Here we try to model the differences of the terms and not the actual term. For instance,
# 
#   x(t) - x(t-1) = ARMA (p ,  q)
#      
#       This differencing is called as the Integration part in AR(I)MA.
        #Now, we have three parameters
# 
#       p : AR
# 
#       d : I
# 
#       q : MA

# Removing the seasonality or irregularity.
# We know that we need to address two issues before we test stationary series. 
# One, we need to remove unequal variances. We do this using log of the series. 
# Two, we need to address the trend component. We do this by taking difference
# of the series. Now, let's test the resultant series.


    # adf.test(AirPassengers)
    # ndiffs(AirPassengers)
    #adf.test(diff(log(AirPassengers)), alternative="stationary", k=1)

#Next step is to find the right parameters to be used in the ARIMA model.

#In order to test the stationarity or data and auto co-relation of their error term.
#ACF Plots
acf(ts(AirPassengers), main= 'ACF')

acf(AirPassengers) 
#-Clearly, the decay of ACF chart is very slow, which means that the population 
#is not stationary. 

acf(log(AirPassengers))
pacf(diff(log(AirPassengers)))

#PACF - degree of association between two variable while adjusting 
#the effect of one or more variables

pacf(AirPassengers)
# pacf(log(AirPassengers))
# pacf(diff(log(AirPassengers)))

#?arima
#?pacf

fit <- arima(AirPassengers, order = c(2,1,1))


fit
accuracy(fit)
summary(fit)


#Making it Auto

fit <- auto.arima(AirPassengers)

auto.arima(AirPassengers, ic="aic", trace = TRUE)

#diagonistic and validation

plot.ts(fit$residuals)
hist(fit$residuals)
acf(fit$residuals, main="ACF residuals")
pacf(fit$residuals,main="PACF residuals")

plot(fitted(fit), fit$residuals)

plot(fit$x, col='red')
lines(fitted(fit), col='blue')
#forecasting


mydata<- forecast(fit, h=5*12)
 plot(mydata)
 
 
 AirPassengersT <- window(AirPassengers, end=1957)
 
# Average Method: Under this method, the forecasted future values are just an average of the historical values. It can be easily executed in R using the following commands:
xm <- meanf(AirPassengersT, h=5)
plot(xm) 
#Where the blue line represents the forecasted values and the dark and light grey areas represent the 95% and 80% confidence intervals.

#Naïve Method: As the name suggests, under this method the forecasted values are just equal to the last observation.
xn <- naive(AirPassengersT, h=25)
plot(xn)

# Seasonal Naïve Method: We know that there is some seasonality in our data, when such kind of time series are available the Seasonal Naïve Method provides better forecasting accuracy than the simple Naïve method. Naïve methods are very useful in economic and financial data.
xsn <- snaive(AirPassengersT, h= 5)
plot(xsn)


tsp <- auto.arima(AirPassengersT, trace = T, stepwise = FALSE)
tsp
ftsp <- forecast(tsp, h=40)
plot(ftsp)

test <- window(AirPassengers, start=1959)
accuracy(ftsp, test)




# 
# train['#Passengers_diff'] = train['#Passengers'] - train['#Passengers'].shift(1)
# train['#Passengers_diff'].dropna().plot()


# Differencing
# In this method, we compute the difference of consecutive terms in the series. Differencing is typically performed to get rid of the varying mean. Mathematically, differencing can be written as:
#   
#   yt' = yt - y(t-1)
# 
# where yt is the value at a time t


# Seasonal Differencing
# In seasonal differencing, instead of calculating the difference between consecutive values, we calculate the difference between an observation and a previous observation from the same season. For example, an observation taken on a Monday will be subtracted from an observation taken on the previous Monday. Mathematically it can be written as:
#   
#   yt' = yt - y(t-n)


# Transformation
# Transformations are used to stabilize the non-constant variance of a series. Common transformation methods include power transform, square root, and log transform. Let's do a quick log transform and differencing on our air passenger dataset:
#   
# train['#Passengers_log'] = np.log(train['#Passengers'])
# train['#Passengers_log_diff'] = train['#Passengers_log'] - train['#Passengers_log'].shift(1)
# train['#Passengers_log_diff'].dropna().plot()
