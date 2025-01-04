#The Salary_Data.csv data set is a table displaying data about an individuals age, gender, level of degree, job title, years of experience, and salary.
##This document lists the steps taken to create a set of graphs to compare salary ranges depenent on years of experience for each level of education.


## READING THE DATA


## The First thing we must do is read the data into the project. As the data is held in a CSV, we can use read.csv()

data <- read.csv("~/Documents/portfolio datasets/salary analysis/Salary_Data.csv", header = TRUE, sep=",")

## Lets also add the packages we need to use for the plotting now


library(ggplot2)
library(gridExtra)

##Now that the dataset has been loaded into the R project, we will create three separate variables to hold
## The data dependent on the level of education

## First, we need to see what education levels there are, using teh 'unique' function

unique(data$Education.Level)

## With this, we see there are Bachelors, Masters, empty, Bachelors degree, masters degree, highschool, phd, and phd.
## clearly, some of these values can be added to the same category, like the two bachelors and two phds.
## the empty values could indicate no degree, but as that isn't clarified, I will treat it as an empty variable


## CLEANING THE DATA
##Because the data is properly organized, and we will be sorting via the 
##Education.Level column, we don't need to worry about removing empty values
## we do, however, need to set all values indication a bachelors, masters, or phd
## to be the same

clean_data <- data

clean_data$Education.Level[clean_data$Education.Level %in% c("bachelor's", "Bachelor's Degree")] <- "Bachelor's"
clean_data$Education.Level[clean_data$Education.Level %in% c("Master's", "Master's Degree")] <- "Master's"
clean_data$Education.Level[clean_data$Education.Level %in% c("PhD", "phD")] <- "PhD"

## check to see if the cleaning was successful
unique(clean_data$Education.Level)


## ORGANIZING THE DATA

## create four data sets for the different levels of education

bachelors <- subset(clean_data, Education.Level =="Bachelor's")
masters <- subset(clean_data, Education.Level =="Master's")
phd <- subset(clean_data, Education.Level =="PhD")
HS <- subset(clean_data, Education.Level =="High School")



##Graphing

## With the four datasets set up, we can now create four seperate graphs using ggplot2

## bachelors
plot_bachelors <- ggplot(bachelors, aes(x= Years.of.Experience, y = Salary)) + geom_point(color = "green") +
  labs(title = "Bachelor's: Salary vs. years of Experience",
       x= "Years of Experience",
       y = "salary") +
  theme_minimal()

## masters
plot_masters <- ggplot(masters, aes(x= Years.of.Experience, y = Salary)) + geom_point(color = "blue") +
  labs(title = "Master's: Salary vs. years of Experience",
       x= "Years of Experience",
       y = "salary") +
  theme_minimal()

##PhD
plot_phd <- ggplot(phd, aes(x= Years.of.Experience, y = Salary)) + geom_point(color = "red") +
  labs(title = "Phd: Salary vs. years of Experience",
       x= "Years of Experience",
       y = "salary") +
  theme_minimal()

##High School
plot_hs <- ggplot(HS, aes(x = Years.of.Experience, y=Salary)) + geom_point(color = "black") +
  labs(title="High School Diploma: Salary vs. years of Exerpeince",
       x= "Years of Experience",
       y = "salary") +
  theme_minimal()


## Now lets render the graphs side by side to make it easier to compare them

grid.arrange(plot_hs, plot_bachelors, plot_masters, plot_phd, nrow=2, ncol=2) 


