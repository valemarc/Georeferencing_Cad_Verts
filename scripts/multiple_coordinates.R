###########################################################
##### Creating Buffer for multiple coordinates data ####
###########################################################

#required packages
library(tidyverse)
library(sf)

# read in csv file

## SE: using the first few rows of data in the CIEE_Canada_data_upload.csv file
all_points <- read_csv("../CIEE_Canada_data_upload.csv")
all_points <- all_points[1:10, ]
# SE: adding the Spatial_source column for test purposes - making up the data
# delete this line of code eventually
all_points$Spatial_source = rep("multiple coordinates", 10)

# filter by Spatial_source column for records with multiple coordinates
selected_points <- all_points %>%
  dplyr::filter(Spatial_source == "single coordinates")

###################################################
#####Creating a convex hull for multiple points####
###################################################

#generates smallest possible polygon around a set of points

#call in the points of interest, stired in a .csv
baseDir <- "./Tester_2/" #@myself change file path once done  testing
filenames <- list.files("./Tester_2", pattern=".csv")
filepaths <- paste(baseDir, filenames, sep='')

convex_hulls <- lapply(filenames,chull)

#write out as a series of new shapefiles
writeOGR(convex_hulls, dsn = '.', layer = 'mypoints', driver = "ESRI Shapefile")   #### writeOGR is from rgdal (should use st_write from sf)

#or maybe this will work better?
{
  dsn <- layer <- gsub(".csv","",i)
  writeOGR(convex_hulls, dsn, layer, driver="ESRI Shapefile")     #### writeOGR is from rgdal (should use st_write from sf)
}

