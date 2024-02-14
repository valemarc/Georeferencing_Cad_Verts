###########################################################
##### Creating Buffer for single coordinates only data ####
###########################################################

#required packages
library(tidyverse)
library(sf)

# ##read in the csv
# baseDir <- "./Tester_2/"
# all_points <- read.csv(paste0(baseDir,"/tester_csv_file.csv")) #tester name do this fr later

## SE: using the first few rows of data in the CIEE_Canada_data_upload.csv file
all_points <- read_csv("../CIEE_Canada_data_upload.csv")
all_points <- all_points[1:10, ]
# SE: adding the Spatial_source column for test purposes - making up the data
# delete this line of code eventually
all_points$Spatial_source = rep("single coordinates", 10)

#define lat and long coordinates
# SE: Is this necessary? I think this can be deleted right??
# coords <- all_points[,c("Latitude","Longitude")]

# #filter csv by record number for just the records they want to use
# selected_points <- all_points %>%
#   dplyr::filter(ID %in% c("ID2_HERE","ID1_HERE","ect...."))

#SE: I think a better approach would be to filter it to by the newly added Spatial_source column
# for data that were flagged for 'single coordinates'
selected_points <- all_points %>%
  dplyr::filter(Spatial_source == "single coordinates")

#reproject coordinates into a coordinate system
#define coordinates
selected_points <- sf::st_as_sf(selected_points, coords = c("Longitude", "Latitude"), crs = 4326)


# #assign a CRS
# selected_points <- sf::st_set_crs(selected_points, 3979)
# sf::st_crs(selected_points) #check that CRS is now correct
selected_points <- sf::st_transform(selected_points, 3978)

#create buffer
selected_points_buffers <- sf::st_buffer(selected_points, 500)


### SE: this part seems uncessary
# ##project + overlay on basemap
# canada <- gadm(country = "CAN", level = 1, resolution = 2,   #### gadm function is undefined
#                path = "...Tester_2/")
# plot(canada, add=TRUE)
# canada_reproj <- sf::t_set_crs(canada, "EPSG:3977") #still need to fix this part

# #export buffers as a new shapefile
# rgdal::writeOGR(selected_points_buffers, dsn = '.', layer = 'poly', driver = "ESRI Shapefile")      #### writeOGR is from rgdal (should use st_write from sf)
# #not working right now


# write shapefile with sites (this will later be transformed in arcGIS to ensure that all
# sites are aligned to the coast shapefile and not inland)
sf::st_write(selected_points_buffers[, c(1, 125)],
             "../test_shapefiles.shp", driver = "ESRI Shapefile", append=FALSE)

selected_points_buffers <- selected_points_buffers %>%
  select(ID, geometry)

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






