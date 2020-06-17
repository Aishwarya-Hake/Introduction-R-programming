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



#get your working director
     getwd()

#Load all libraries
     library(ggplot2)
     library(ggthemes)
     library(ggfortify)
     #library(ggpubr)
     #library(ggExtra)
     library(grid)
     library(gridExtra)
     #library(gridGraphics)
     library(zoo)


#Load dataset
     detach(mtcars)
     rm(mtcars)
     mtcars
     attach(mtcars)
    
   
     
# Create factors with value labels 
     
     #str(mtcars)
     
     mtcars$gear <- factor(mtcars$gear,levels=c(3,4,5),
                           labels=c("3gears","4gears","5gears")) 
     
     mtcars$am <- factor(mtcars$am,levels=c(0,1),
                         labels=c("Automatic","Manual")) 
     
     mtcars$cyl <- factor(mtcars$cyl,levels=c(4,6,8),
                          labels=c("4cyl","6cyl","8cyl")) 


# Loading processed data
     attach(mtcars)

#Primitive plot() Functions for Visulaization
     plot(mpg, gear)
     plot(gear, mpg)
     plot(hp, mpg)
     plot(mtcars[1:5])
       #plot(sin, -pi, 4*pi)
     
     
##qplot() from ggplot
     
     # Use data from data.frame
     qplot(gear, mpg, data = mtcars)
     qplot(mpg, wt, data = mtcars, colour = cyl)
     qplot(mpg, wt, data = mtcars, size = cyl)
     qplot(mpg, wt, data = mtcars, facets = vs ~ am)
     
     
# Scatterplot of mpg vs. hp for each combination of gears and cylinders
# in each facet, transmittion type is represented by shape and color
     qplot(hp, mpg, data=mtcars, shape=am,  
           size=I(3),facets=gear~cyl, 
           xlab="Horsepower", ylab="Miles per Gallon")
     
# Boxplots of mpg by number of gears 
# observations (points) are overlayed and jittered
     qplot(gear, mpg, data=mtcars, geom=c("boxplot","jitter"), 
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
# The Co-ordinates
####
# First, you need to tell ggplot what dataset to use. 
# where df is a dataframe that contains all features needed to make the plot. 
# Unlike base graphics, ggplot doesn't take vectors as arguments.


##1. Setup
     
     ggplot(mtcars)  # if only the dataset is known.
     
     ggplot(mtcars, aes(x=gear))  # if only X-axis is known. The Y-axis can be specified in respective geoms.
     
     ggplot(mtcars, aes(x=gear, y=mpg)) # if both X and Y axes are fixed for all layers.
     
     #plot(gear, mpg)  
     
#??? ------Why there is no plot yet.
     ggplot(mtcars, aes(gear))+ geom_bar()
     
     ggplot(mtcars, aes(x=gear, y=mpg)) + geom_point() 
     
     ggplot(mtcars, aes(x=gear, y=mpg)) + geom_boxplot() + geom_point() 
     
   
     
     
       
# Each category of the 'am' variable will now have a distinct  color, once a geom is added.
     ggplot(mtcars, aes(x=gear, y=mpg, color=am))+ geom_point() 
     
     ggplot(mtcars)+  geom_boxplot(aes(x=gear, y=mpg)) + 
        geom_point(aes(x=gear, y=mpg, color=am)) 
     
        
     
    
      
          
     ggplot(mtcars, aes(x=gear, y=mpg, color=am)) + geom_boxplot() 

          ggplot(mtcars) + geom_boxplot(aes(x=gear, y=mpg, color=am)) 
   
          
##2. Layers
     
#Can be achieved more appropriately by using fill in asethetic
          
     x <- ggplot(mtcars)   
     
     y <- x + aes(y= mpg, x= disp)
     
     y + geom_point()
     
     y + geom_smooth()
     
     y + geom_point() + geom_smooth()
     
     
     z <- x + geom_boxplot(aes(x=gear, y=disp,
                               color = am))
     z
     
     z + geom_point(aes(x=gear, y=disp))
     
     
     
     # z <- z+ geom_jitter()
     # z
     
     x <- ggplot(mtcars,aes(x=gear, y=disp) )
     
     z <- x+ geom_boxplot() +  geom_jitter(aes(color = am))
     z
     
     #y + geom_jitter()+geom_boxplot()
     
     # z <- z + geom_jitter(aes(x=gear, y=disp))
     # z
      # z+ geom_jitter()
     
     y + geom_smooth(aes(color=am))
     
     y + geom_smooth(aes(color=am)) + 
        geom_point(aes(color=am))
     
   
     
##3. The Labels
     
     z <- z + 
        labs(title="Boxplot With Jitters", 
             x="No. of Gears", y="Milage Distribution")
     z
     
     z <- z +  scale_color_discrete(name="Transmission")   

     z
     
     
     

#4. The Facets
     y <- y + geom_point(aes(color=cyl))
     
     y

     y + facet_wrap(~am)

     y + facet_wrap(gear~cyl)

     y + facet_wrap(am ~ cyl)
     
     y + facet_wrap(am ~ cyl, nrow = 2)
     
     y + facet_wrap(am ~ cyl, scales="free_x")
     
      y + facet_grid(am ~ cyl) 
     
 
         
#The Grid
     
     gg <- ggplot(mtcars, aes(x=cyl))
     p1 <- gg + geom_bar(aes(fill=factor(gear)))  # stacked
     p2 <- gg + geom_bar(position="dodge", aes(fill=factor(gear)))  # side-by-side
      
     
     grid.arrange(p1, p2)
     

     y
     z
     grid.arrange(y,z) 
 
    
#Custom layout
#The gridExtra package provides the facility to arrage multiple ggplots in a single grid.
#using library(gridExtra)
    
    p4 <- ggplot(mtcars, aes(factor(cyl), mpg)) + 
         geom_violin(aes(fill = factor(vs)), width=0.5, trim=F) + 
         labs(title="Violin plot (untrimmed)")  # violin plot
    
    grid.arrange(p1, p2, p3, p4)    
 
    
#6. The Co-ordinates
    
#Adjust X and Y axis limits
# There are 3 ways to change the X and Y axis limits.
# 
#    Using coord_cartesian(xlim=c(x1,x2))
#    Using xlim(c(x1,x2))
#    Using scale_x_continuous(limits=c(x1,x2))
    
    
  p <-  y + coord_cartesian(ylim=c(15, 25), xlim = c(100, 200)) + 
         labs(title="Coord_cartesian zoomed in!")
   
   y + ylim(c(15, 30)) + 
        labs(title="Datapoints deleted: Note the 
             change in smoothing lines!")
   
   
   ##4. Themes
  
   z + theme_economist()
   z + theme_foundation()
   z + theme_pander()
   
   
   z + theme(
      plot.title=element_text(color = "#342566", size=18, face="bold"), 
      axis.text.x=element_text(size=10, color = "blue"), 
      axis.text.y=element_text(size=10, color = "red"),
      axis.title.x=element_text(size=14, color = "blue" ),
      axis.title.y=element_text(size=14, color = "red"),
      legend.position="top") 
   
   
   
   
   
 ## Deleting and Changing legends Position   
   p1 <- z + 
        theme(legend.position="none") + 
        labs(title="legend.position='none'")  # remove legend
   
   p2 <- z + 
        theme(legend.position="top") + 
        labs(title="legend.position='top'")  # legend at top
   
   p3 <- z + 
        labs(title="legend.position='coords inside plot'") + 
        theme(legend.justification=c(1,0), legend.position=c(1,0))  # legend inside the plot.
   
   
   grid.arrange(p1, p2, p3, ncol=3)  # arrange
  
   
   
#Grid lines
  p1 <- y + labs(title= "CYL & GEAR Wise Distribution of Cars", x= "Cylinders", 
            y="No. of Cars")+
      theme(panel.background = element_rect(fill = 'grey'),
              panel.grid.major = element_line(colour = "#679854", size=0.5),
              panel.grid.minor = element_line(colour = "lightblue", size=0.6)) 
   p1
#Plot margin and background
   p1 + 
        theme(plot.background=element_rect(fill="grey"),
              plot.margin = unit(c(2, 3, 1, 3), "cm"))# top, right, bottom, left
 

   
#Annotation
#library(grid)
   q = grobTree(textGrob("This is DSP 22 batch example", 
                               x=0.2,  y=0.9, hjust=0,
                               gp=gpar(col="#345667", 
                                       fontsize=11, fontface="bold")))
    
   p1 + annotation_custom(q) + 
        labs(title="Annotation Example")
  
   
   library(ggfortify)
   
   #Make a time series plot (using ggfortify)
   # The ggfortify package makes it very easy to plot time series directly from a time series object, 
   # without having to convert it to a dataframe.
   
   autoplot(AirPassengers) + labs(title="AirPassengers")  # where AirPassengers is a 'ts' object
   
   p3 <- autoplot(AirPassengers, ts.colour = 'red', 
                  ts.linetype = 'dashed')+ 
      labs(title="AirPassengers", x="Years", y="No. of AirPassengers")
   p3
   #from Zoo package 
   autoplot.zoo(AirPassengers)+ scale_colour_grey() + theme_economist()
   
   #scale_colour_hue()
   
    
# Saving ggplot
  
   ggsave("myggplot1.png")  # saves the last plot.
   ggsave("myggplot.png", plot=z) 
   

   
   
#some extra knowledge -----not to be focused
#Plotting Probability Distributions
   ggdistribution(dnorm, mtcars$mpg, mean = 15, sd = 4)
   
   ggdistribution(pnorm, seq(-3, 3, 0.1), mean = 0, sd = 1, colour = 'red')
   
   ggdistribution(dpois, seq(0, 20), lambda = 9, fill = 'blue', alpha= 0.3)
   
   #autoplot(density(rnorm(mtcars$mpg)), fill = 'green')
   
   p <- ggdistribution(pchisq, 0:20, df = 7, fill = 'blue')
   ggdistribution(pchisq, 0:20, p = p, df = 9, fill = 'red')
   
   
   
   ggplot(mtcars, aes(x=mpg, y= ..density..))+ 
        geom_histogram()+
        geom_density(fill = "yellow", alpha= 0.3)
   
   