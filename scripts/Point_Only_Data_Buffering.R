############################################
#####Creating Buffer for point only data####
############################################

#required packages
library(tidyverse)
library(sf)

##read in the csv
baseDir <- "./Tester_2/"
all_points <- read.csv(paste0(baseDir,"/tester_csv_file.csv")) #tester name do this fr later

#define lat and long coordinates
coords <- all_points[,c("Latitude","Longitude")]

#filter csv by record number for just the records they want to use
selected_points <- all_points %>% 
  filter(ID %in% c("ID2_HERE","ID1_HERE","ect...."))

#reproject coordinates into a coordinate system
#define coordinates
selected_points <- selected_points %>% 
  st_as_sf(coords = c("Latitude", "Longitude"))
#assign a CRS
selected_points <- st_set_crs(selected_points, 3979)
st_crs(selected_points) #check that CRS is now correct

#create buffer
selected_points_buffers <- st_buffer(selected_points, 500)



##project + overlay on basemap                    
canada <- gadm(country = "CAN", level = 1, resolution = 2,   #### gadm function is undefined
               path = "...Tester_2/")
plot(canada, add=TRUE)


canada_reproj <- st_set_crs(canada, "EPSG:3977") #still need to fix this part

#export buffers as a new shapefile
writeOGR(selected_points_buffers, dsn = '.', layer = 'poly', driver = "ESRI Shapefile").      #### writeOGR is from rgdal (should use st_write from sf)
#not working right now

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













