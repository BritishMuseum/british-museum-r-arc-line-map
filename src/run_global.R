# Global Code

# Author: Alice Daish (@adaish)
# October 2017

# Objective : Make a map with arcs from a central point using auto-collecting latitude and longitude of locations.
# OR just plot arc line path plotted on 2D map


###################################################################################################
#----Install Packages --for auto_geocode.R---------------------------------------------------------
install.packages("tidyverse")
install.packages("readxl")
install.packages("ggmap")

library(tidyverse)
library(readxl)
library(ggmap)

###################################################################################################
#----Install Packages ---for geocode_arc_map.R-----------------------------------------------------
install.packages("maps")
install.packages("mapdata")
install.packages("geosphere")
install.packages("tidyverse")
install.packages("stringr")

library(maps)
library(mapdata)
library(geosphere)
library(tidyverse)
library(stringr)

###################################################################################################
#--- Set working directory -------------------------------------------------------------------------
setwd("working directory")
# example = setwd("C://Users//adaish//GitHub//british-museum-r-geosphere-line-map")

###################################################################################################
#Latitude and Longitude required for locations
# Run auto collection of latitude and longitude of the locations using google geocode API
source("src\\auto_geocode.R") #RUN CODE (if it gets stuck stop and re-run)

###################################################################################################
#Plot the arcs
source("src\\geocode_arc_map.R") #RUN CODE

#Set the centre of the arcs
#(The default is london)
start_lat <- 51.5074 #latitude
start_long <- 0.1278 #longitude
title <- "This is my map title"
background_colour <- "grey8"
country_colour <- "grey58"
dot_colour <- "red"
line_colour <- "white"

# I want to plot a World Map
map_world(start_lat,start_long,title,background_colour,country_colour,dot_colour,line_colour)

# I want to plot a UK Map
map_uk(start_lat,start_long,title,background_colour,country_colour,dot_colour,line_colour)

# I want to plot a Europe Map
map_europe(start_lat,start_long,title,background_colour,country_colour,dot_colour,line_colour)

#IF ITS BROKEN - try
dev.off() #reset your image space


###########################------END----###############################################################


