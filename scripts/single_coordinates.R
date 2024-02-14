###########################################################
##### Creating Buffer for single coordinates only data ####
###########################################################

#required packages
library(tidyverse)
library(sf)

# Read in dataset with coordinates
## SE: using the first few rows of data in the CIEE_Canada_data_upload.csv file
all_points <- read_csv("../CIEE_Canada_data_upload.csv")
all_points <- all_points[1:10, ]
# SE: adding the Spatial_source column for test purposes - making up the data
# delete this line of code eventually
all_points$Spatial_source = rep("single coordinates", 10)

#SE: I think a better approach would be to filter it to by the newly added Spatial_source column
# for data that were flagged for 'single coordinates'
selected_points <- all_points %>%
  dplyr::filter(Spatial_source == "single coordinates")

#define coordinates, if the paper is from after 1986 assuming coordinates were collected using NAD83 datum (ESPG:4269)
selected_points <- sf::st_as_sf(selected_points, coords = c("Longitude", "Latitude"), crs = 4269)

#define coordinates, if the paper is from before 1986 assuming coordinates were collected using NAD27 datum (ESPG:4267)
selected_points <- sf::st_as_sf(selected_points, coords = c("Longitude", "Latitude"), crs = 4267)


# project data with the Canada atlas lambert projection (Confirm that this is correct - workflow for QGIS says to use Lambert Conformic Conal-Canada.)
selected_points <- sf::st_transform(selected_points, 3978)

#create buffer
selected_points_buffers <- sf::st_buffer(selected_points, 500)

# which columns do we want to include?
selected_points_buffers <- selected_points_buffers %>%
  select(ID, geometry)

#change file path to correct one eventually
sf::st_write(selected_points_buffers,
             "../test_shapefiles.shp", driver = "ESRI Shapefile", append=FALSE)

