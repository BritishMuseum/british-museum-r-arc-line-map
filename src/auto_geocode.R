# Auto generate Latitude and Longitude

#Author: Alice Daish (@adaish)
# October 2017

#Objective : Autogenerate lat and long of cities of locations using google API

###################################################################################################
#----Install Packages -----------------------------------------------------------------------------
#install.packages("tidyverse")
#install.packages("readxl")
#install.packages("ggmap")

#library(tidyverse)
#library(readxl)
#library(ggmap)

#---------Load Data --------------------------------------------------------------------------------
citydata <- read_csv("data\\city_data.csv")

dim(citydata) #dimensions of data

#View(citydata) # View data

######################################################################################################
#-------Prepare Data ---------------------------------------------------------------------------------
#Get unique cities list
#check for duplicates
unique_city <- unique(citydata$City)
length(unique_city)

#To improve accurancy of processing merge the city and the country into one cell
addresses <- paste0(citydata$City,", ",citydata$Country)

#-------Function to collect latitude and longitude from google API
#Function by Shane Lynn from https://www.r-bloggers.com/batch-geocoding-with-r-and-google-maps/
#Please read before use to see terms and conditions of Google Geocoding API terms of service!!!
##--------------- Start --Shane Lynn 10/10/2013-----------------------------
getGeoDetails <- function(address){
   #use the gecode function to query google servers
   geo_reply = geocode(address, output = 'all', messaging = TRUE, override_limit = TRUE)
#now extract the bits that we need from the returned list
   answer <- data.frame(lat = NA, long = NA, accuracy = NA, formatted_address = NA, address_type = NA, status = NA)
   answer$status <- geo_reply$status

   #if we are over the query limit - want to pause for an hour
   while (geo_reply$status == "OVER_QUERY_LIMIT") {
       print("OVER QUERY LIMIT - Pausing for 1 hour at:")
       time <- Sys.time()
       print(as.character(time))
       Sys.sleep(60*60)
       geo_reply = geocode(address, output = 'all', messaging=TRUE, override_limit = TRUE)
       answer$status <- geo_reply$status
   }
  #return Na's if we didn't get a match:
   if (geo_reply$status != "OK") {
       return(answer)
   }
   #else, extract what we need from the Google server reply into a dataframe:
   answer$lat <- geo_reply$results[[1]]$geometry$location$lat
   answer$long <- geo_reply$results[[1]]$geometry$location$lng
   if (length(geo_reply$results[[1]]$types) > 0) {
       answer$accuracy <- geo_reply$results[[1]]$types[[1]]
   }
   answer$address_type <- paste(geo_reply$results[[1]]$types, collapse = ',')
   answer$formatted_address <- geo_reply$results[[1]]$formatted_address

   return(answer)
}


# -------RUN THE FUNCTION------------------------------------------------------------------

# Create a dataframe to hold the results
geocoded <- data.frame()
# Find out where to start in the address list (if the script was interrupted before):
startindex <- 1

#if a temp file exists - load it up and count the rows!
tempfilename <- 'data//temp_geocoded_cities.rds'
if (file.exists(tempfilename)) {
       print("Found temp file - resuming from index:")
       geocoded <- readRDS(tempfilename)
       startindex <- nrow(geocoded)
       print(startindex)
}



# Start the geocoding process - address by address. geocode() function takes care of query speed limit.
for (ii in seq(startindex, length(addresses))) {
   print(paste("Working on index", ii, "of", length(addresses)))
   #query the google geocoder - this will pause here if we are over the limit.
   result = getGeoDetails(addresses[ii])
   print(result$status)
   result$index <- ii
   #append the answer to the results file.
   geocoded <- rbind(geocoded, result)
   #save temporary results as we are going along
   saveRDS(geocoded, tempfilename)
}
##--------------- END --Shane Lynn 10/10/2013---------------------------------------------------------------
###########################################################################################################
#----------SAVE FILES
# Save data from temp file
geocoded_data <- readRDS("data//temp_geocoded_cities.rds")

# Make unique just in cases
geocoded_all <- as.data.frame(unique(geocoded_data))
dim(geocoded_all) #check all the data has been processed
View(geocoded_all) #View Data

write_csv(geocoded_all,"data//geocode_all_cities.csv")

#finally write it all to the output files
saveRDS(geocoded_all, "data//geocode_cities.rds") #Make RDS file
write.table(geocoded_all, file = "data//geocode_cities.csv", sep = ",", row.names = FALSE) #Make CSV file


#If you want a simple table too
simple_geocode_cities <- cbind(addresses,geocoded_all$lat,geocoded_all$long) #merge cities, latitude and longitude
colnames(simple_geocode_cities) <- c("Location", "Latitude", "Longitude") #rename columns
View(simple_geocode_cities) #View Data
simple_geocode_cities <- as.data.frame(simple_geocode_cities)
write.csv(simple_geocode_cities, file = "data//simple_geocode_cities.csv",row.names = F) #Make a simple CSV file


#-----------END---------------------------------------------------------------------------------------------
###########################################################################################################



