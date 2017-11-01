# Create a Arc (Flight Paths) Lines on 2D Map
# World, UK and Europe

#Author: Alice Daish (@adaish)
#October 2017

# Objective : Plot circle arc line path plotted on 2D map

###################################################################################################
#----Install Packages -----------------------------------------------------------------------------
#install.packages("maps")
#install.packages("mapdata")
#install.packages("geosphere")
#install.packages("tidyverse")
#install.packages("stringr")

#library(maps)
#library(mapdata)
#library(geosphere)
#library(tidyverse)
#library(stringr)

####################################################################################################
#------------------WORLD--------------------------------------------------------------------------
map_world <- function(start_lat=51.5074,start_long=0.1278,title,background_colour="grey8",country_colour="grey58",dot_colour="red",line_colour="white")
{
#----Load Data ------------------------------------------------------------------------------------
map_data <- read_csv("data//geocode_cities.csv") #use the default result (not the simple table for plotting)

#--------Map the World ----------------------------------------------------------------------------
# Select Data required from the geocoded latitude and longitude data
worldmap_data <- map_data[,1:2]
worldmap_data <- as.data.frame(worldmap_data)

# Create a World map
maps::map("world", fill = T, col = country_colour, bg = background_colour,lwd = 0.02,zoom  = 4)


# Set starting point - default is set to london
start <- matrix(c(start_lat,start_long), nrow = 1, ncol = 2, byrow = T,
            dimnames = list(c("Start location name"),c("lat","lon"))) # London example


#For Loop
#Length from 1 to total places
for (i in (1:dim(worldmap_data)[1])) {

  #Start at point lon/lat and then loop through all cities linking lines to the start
  inter <- gcIntermediate(c(start[1,2], start[1,1]), c(worldmap_data[i,2], worldmap_data[i,1]), n = 200)

  #Plot lines on map
  lines(inter, lwd = 0.05, col = line_colour)
}

#Add place points
points(worldmap_data[,2],worldmap_data[,1], pch = 19, cex = 0.2,bg = dot_colour, col = dot_colour,lwd = 0.02)

#Add title
title(main = title, col.main = "white")
}
####################################################################################################

####################################################################################################
#------------------UK--------------------------------------------------------------------------
map_uk <-  function(start_lat=51.5074,start_long=0.1278,title,background_colour="grey8",country_colour="grey58",dot_colour="red",line_colour="white")
{
#----Load Data ---
map_data <- read_csv("data//geocode_cities.csv") #use the default result (not the simple table for plotting)

map_data$ukcount <- str_count(map_data$formatted_address, "UK") # tag UK locations

#-------UK-------
uk_map_data <- map_data %>% filter(ukcount == 1 )
uk_map_data <- uk_map_data[,1:2]
uk_map_data <- as.data.frame(uk_map_data)

# Create a UK map
maps::map('worldHires',
          c('UK', 'Ireland', 'Isle of Man','Isle of Wight'),
          xlim=c(-11,3), ylim=c(49,60.9), fill = T, col = country_colour, bg = background_colour,lwd = 0.02,zoom = 4)


# Set starting point
start <- matrix(c(start_lat,start_long), nrow = 1, ncol = 2, byrow = T,
                dimnames = list(c("Start location name"),c("lat","lon"))) # London example

#For Loop
#Length from 1 to total places
for (i in (1:dim(uk_map_data)[1])) {

  #start at point lon/lat and then loop through all cities link lines
  inter <- gcIntermediate(c(start[1,2], start[1,1]), c(uk_map_data[i,2], uk_map_data[i,1]), n = 200)

  lines(inter, lwd = 0.05, col = line_colour)
}

#Add place points
points(uk_map_data[,2],uk_map_data[,1], pch = 19, cex = 0.2,bg = dot_colour, col = dot_colour,lwd = 0.02)

#Add title
title(main = title, col.main = "white")
}

######################################################################################################

####################################################################################################
#-------EUROPE------------------------------------------------------------------------------------------
map_europe <-  function(start_lat = 51.5074,start_long = 0.1278,title,background_colour="grey8",country_colour="grey58",dot_colour="red",line_colour="white")
{
#----Load Data ---
map_data <- read_csv("data//geocode_cities.csv") #use the default result (not the simple table for plotting)

#Manually add 1 column to data to identicate European countries and label column "europecount
#(automation needs to be developed)
#geocoded_europe <- geocoded %>% filter(europecount ==1 )


geocoded_europe <- map_data
geocoded_europe <- as.data.frame(geocoded_europe)


#MAP europe
maps::map("world", fill = T, col = country_colour, bg = background_colour,lwd = 0.02, xlim = c(-10, 40), ylim = c(35, 70),zoom = 4)

start <- matrix(c(start_lat,start_long), nrow = 1, ncol = 2, byrow = T,
                dimnames = list(c("Start location name"),c("lat","lon"))) # London example

#For Loop
#Length from 1 to total places
for (i in (1:dim(geocoded_europe)[[1]])) {

  #start at point lon/lat and then loop through all cities link lines
  inter <- gcIntermediate(c(start[1,2], start[1,1]), c(geocoded_europe[i,2], geocoded_europe[i,1]), n = 200)

  lines(inter, lwd = 0.05, col = line_colour)
}

#Add point place points
points(geocoded_europe[,2],geocoded_europe[,1], pch = 19, cex = 0.45,bg = dot_colour, col = dot_colour,lwd = 0.02)

#Add title
title(main = title, col.main = "white")
}
######################################################################################################





