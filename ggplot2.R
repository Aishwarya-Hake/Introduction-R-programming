#####------------------ GGPLOT2 Exploration ---------------####
# ggplot2 is the most elegant and aesthetically pleasing graphics framework 
# available in R. It has a nicely planned structure to it. This tutorial 
# focusses on exposing this underlying structure you can use to make any
# ggplot
   
# The main difference is that, unlike base graphics, ggplot works with dataframes 
# and not individual vectors. All the data needed to make the plot is
# typically be contained within the dataframe supplied to the ggplot() 
# itself or can be supplied to respective geoms.
# 
# The second noticeable feature is that you can keep enhancing the plot by 
# adding more layers (and themes) to an existing plot created using 
# the ggplot() function.

getwd()
library(ggplot2) 



# create factors with value labels 
mtcars$gear <- factor(mtcars$gear,levels=c(3,4,5),
                      labels=c("3gears","4gears","5gears")) 
mtcars$am <- factor(mtcars$am,levels=c(0,1),
                    labels=c("Automatic","Manual")) 
mtcars$cyl <- factor(mtcars$cyl,levels=c(4,6,8),
                     labels=c("4cyl","6cyl","8cyl")) 


# Scatterplot of mpg vs. hp for each combination of gears and cylinders
# in each facet, transmittion type is represented by shape and color
qplot(hp, mpg, data=mtcars, shape=am,  
      size=I(3),facets=gear~cyl, 
      xlab="Horsepower", ylab="Miles per Gallon")

# Boxplots of mpg by number of gears 
# observations (points) are overlayed and jittered
qplot(gear, mpg, data=mtcars, geom=c("boxplot", "jitter"), 
      fill=gear, main="Mileage by Gear Number",
      xlab="", ylab="Miles per Gallon")

# Kernel density plots for mpg
# grouped by number of gears (indicated by color)
qplot(mpg, data=mtcars, geom="density", fill=gear, alpha=I(.5), 
      main="Distribution of Gas Milage", xlab="Miles Per Gallon", 
      ylab="Density")

# Separate regressions of mpg on weight for each number of cylinders
qplot(wt, mpg, data=mtcars, geom=c("point", "smooth"), 
      method="lm", formula=y~x, color=cyl, 
      main="Regression of MPG on Weight", 
      xlab="Weight", ylab="Miles per Gallon")


####
# The Setup
# The Layers
# The Labels
# The Theme
# The Facets
####
# 
# First, you need to tell ggplot what dataset to use. 
# where df is a dataframe that contains all features needed to make the plot. 
# Unlike base graphics, ggplot doesn't take vectors as arguments.

diamonds # dataset.

#data(diamonds)
#the setup
#View(diamonds)

ggplot(diamonds)  # if only the dataset is known.

ggplot(diamonds, aes(x=carat))  # if only X-axis is known. The Y-axis can be specified in respective geoms.

ggplot(diamonds, aes(x=carat, y=price)) + geom_point  # if both X and Y axes are fixed for all layers.

#plot(diamonds$carat, diamonds$price)

ggplot(diamonds, aes(x=carat, y=price,color=cut)) + geom_boxplot() # Each category of the 'cut' variable will now have a distinct  color, once a geom is added.

#2. The Layers

ggplot(mtcars, aes(mpg))+ geom_histogram()

mtcars$cyl <- as.factor(mtcars$cyl)

ggplot(mtcars, aes(cyl))+ geom_bar()


ggplot(mtcars,aes(y= mpg, x= disp) )+
 geom_point() + 
  geom_smooth()

mtcars$gear <- as.factor(mtcars$gear)

ggplot(mtcars, aes(x= cyl, y = mpg))+ 
  geom_boxplot(aes(fill= gear))
  ``
iris$Species <- as.factor(iris$Species)

ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width))+
  geom_point(aes(color=Species))



#making a simple scatter plot.

ggplot(diamonds, aes(x=factor(color), y=price)) + 
  geom_boxplot()  

ggplot(diamonds, aes(x=factor(color), y=price)) + 
  geom_boxplot(aes(fill = cut))+
# ylim(c(0, 5500))
# #rm(diamonds)
# diamonds <- slice(diamonds, 1:1000)
#making color scatter plot
gg<- ggplot(diamonds) + geom_point(aes(x=carat, y=price, color=cut)) 

gg + geom_smooth(aes(x=carat, y=price))


ggplot(diamonds) + geom_smooth(aes(x=carat, y=price))


ggplot(diamonds, aes(x=carat, y=price, color=cut))+
  geom_point() + geom_smooth() # Adding scatterplot geom (layer1) and smoothing geom (layer2).


ggplot(diamonds) + geom_point(aes(x=carat, y=price, color=cut))+
  geom_smooth(aes(x=carat, y=price))


ggplot(diamonds, aes(x=carat, y=price))+
  geom_point(aes(color=cut)) + geom_smooth()




#3. The Labels
gg <- ggplot(diamonds, aes(x=carat, y=price, color=cut))
 
gg1 <- gg+ geom_point()

gg2 <- gg1+ labs(title="Scatterplot", x="Carat", y="Price")  # add axis lables and plot title.

print(gg2)


#4. The Theme

gg3 <- gg2 + theme_economist()

gg3 <- gg2 + theme(plot.title=element_text(colour = "Red", size=20, face="bold"), 
                  axis.text.x=element_text(size=15, color = "blue"), 
                  axis.text.y=element_text(size=15, color = "red"),
                  axis.title.x=element_text(size=25),
                  axis.title.y=element_text(size=25)) + 
  scale_color_discrete(name="Cut of diamonds")  # add title and axis text, change legend title.
print(gg3)  # print the plot


mtcars$am <- as.factor(mtcars$am)

gm <- ggplot(mtcars, aes(x=cyl, y = mpg))+ 
      geom_boxplot(aes(fill = am))

gm + facet_wrap(am ~ gear)

?facet_wrap

#5. The Facets
View(diamonds)

gg3 + facet_wrap( ~ cut, ncol=5)  # columns defined by 'cut'

# facet_wrap(formula) takes in a formula as the argument. 
# The item on the RHS corresponds to the column. 
# The item on the LHS defines the rows.

gg3 + facet_wrap(color ~ cut, ncol=5)  # row: color, column: cut

#In facet_wrap, the scales of the X and Y axis are fixed to accomodate all points by default. 
# This would make comparison of attributes meaningful because they would be in the same scale. 
# However, it is possible to make the scales roam free making the charts look more evenly distributed
# by setting the argument scales=free.

gg3 + facet_wrap(color ~ cut, scales="free_x")  # row: color, column: cut

gg3 + facet_grid(color ~ cut)   # In a grid


#Bar charts

plot1 <- ggplot(mtcars, aes(x=cyl)) + geom_bar() +
  labs(title="Frequency bar chart")  # Y axis derived from counts of X item

print(plot1)

gg <- ggplot(mtcars, aes(x=cyl))
p1 <- gg + geom_bar(position="dodge", aes(fill=factor(am)))  # side-by-side
p2 <- gg + geom_bar(aes(fill=factor(gear)))  # stacked
   
grid.arrange(p1, p2, p1, p2)
 


#Make a time series plot (using ggfortify)
# The ggfortify package makes it very easy to plot time series directly from a time series object, 
# without having to convert it to a dataframe.

library(ggfortify)
autoplot(AirPassengers) + labs(title="AirPassengers")  # where AirPassengers is a 'ts' object

p1 <- autoplot(AirPassengers, ts.colour = 'red', ts.linetype = 'dashed')+ 
  labs(title="AirPassengers")


autoplot.zoo(AirPassengers)+ scale_colour_grey() + theme_economist()

#Custom layout
#The gridExtra package provides the facility to arrage multiple ggplots in a single grid.
library(gridExtra)

p2 <- ggplot(mtcars, aes(factor(cyl), mpg)) + 
  geom_violin(aes(fill = factor(vs)), width=0.5, trim=F) + 
  labs(title="Violin plot (untrimmed)")  # violin plot

grid.arrange(p1, p2, ncol=2)

#Adjust X and Y axis limits
# There are 3 ways to change the X and Y axis limits.
# 
# Using coord_cartesian(xlim=c(x1,x2))
# Using xlim(c(x1,x2))
# Using scale_x_continuous(limits=c(x1,x2))

ggplot(diamonds, aes(x=carat, y=price, color=cut)) + geom_point()+ 
 geom_smooth()+ coord_cartesian(ylim=c(500, 1000), xlim = c(0, 1)) + 
  labs(title="Coord_cartesian zoomed in!")



ggplot(diamonds, aes(x=carat, y=price, color=cut)) + geom_point()+ 
geom_smooth() + ylim(c(0, 10000)) + 
  labs(title="Datapoints deleted: Note the change in smoothing lines!")
#
#Change themes
# Apart from the basic ggplot2 theme, you can change the look and feel of your plots using one of these builtin themes.
# 
# theme_gray()
# theme_bw()
# theme_linedraw()
# theme_light()
# theme_minimal()
# theme_classic()
# theme_void()

ggplot(diamonds, aes(x=carat, y=price, color=cut)) + geom_point() + geom_smooth() +theme_bw() + labs(title="bw Theme")

x <- ggplot(diamonds, aes(x=carat, y=price, color=cut)) + 
  geom_point() + 
  geom_smooth()
# Deleting and Changing Position
p1 <- x + 
  theme(legend.position="none") + 
  labs(title="legend.position='none'")  # remove legend

p2 <- x + 
  theme(legend.position="top") + 
  labs(title="legend.position='top'")  # legend at top

p3 <- x + 
  labs(title="legend.position='coords inside plot'") + 
  theme(legend.justification=c(1,0), legend.position=c(1,0))  # legend inside the plot.

grid.arrange(p1, p2, p3, ncol=3)  # arrange

#Grid lines
ggplot(mtcars, aes(x=cyl)) + geom_bar(fill='darkgoldenrod2') +
  theme(panel.background = element_rect(fill = 'steelblue'),
        panel.grid.major = element_line(colour = "firebrick", size=3),
        panel.grid.minor = element_line(colour = "blue", size=1))

#Plot margin and background
ggplot(mtcars, aes(x=cyl)) + geom_bar(fill="firebrick") + theme(plot.background=element_rect(fill="steelblue"), plot.margin = unit(c(2, 4, 1, 3), "cm")) # top, right, bottom, left

#Annotation
library(grid)
my_grob = grobTree(textGrob("This is pGA 6 batch, relative!\n Anchor point is at 0,0", 
                            x=0.2,  y=0.9, hjust=0,
                            gp=gpar(col="firebrick", fontsize=12, fontface="bold")))
ggplot(mtcars, aes(x=cyl)) + 
  geom_bar() + 
  annotation_custom(my_grob) + 
  labs(title="Annotation Example")

# Saving ggplot
plot1 <- ggplot(mtcars, aes(x=cyl)) + geom_bar()
ggsave("myggplot1.png")  # saves the last plot.
ggsave("myggplot.png", plot=p2) 

getwd()
#some extra knowledge -----not to be focused
p1 <- ggplot(mtcars, aes(factor(cyl), mpg)) + geom_boxplot(aes(fill = factor(vs)), width=0.5, outlier.colour = "dodgerblue", outlier.size = 4, outlier.shape = 16, outlier.stroke = 2, notch=F) + labs(title="Box plot")  # boxplot
p2 <- ggplot(mtcars, aes(factor(cyl), mpg)) + geom_violin(aes(fill = factor(vs)), width=0.5, trim=F) + labs(title="Violin plot (untrimmed)")  # violin plot
gridExtra::grid.arrange(p1, p2, ncol=2)

#Plotting Probability Distributions
ggdistribution(dnorm, seq(-3, 3, 0.1), mean = 0, sd = 1)

ggdistribution(pnorm, seq(-3, 3, 0.1), mean = 0, sd = 1, colour = 'red')

ggdistribution(dpois, seq(0, 20), lambda = 9, fill = 'blue')

autoplot(density(rnorm(mtcars$mpg)), fill = 'green')



ggplot(mtcars, aes(x=mpg, y= ..density..))+ 
  geom_histogram()+
  geom_density(fill = "blue", alpha= 0.3)