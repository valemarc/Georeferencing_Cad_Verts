###############################################################################
#                         Pulling external polygons:                          #
#             National parks, provincial parks, protected areas,              #
#                     lakes, rivers, ponds, cities, towns                     #
###############################################################################

#Authors: Mary Paz Mañé and Olivia Rahn
#Date: 2023-01-23



# Script 2.

# Instructions: Run only the sections of this script that you require depending on
#               the type of polygon you need. This script is almost only for records
#               labeled as "Place names (with obvious spatial extent)".



# Install required packages #
#         NOTE: Only run this if you've never installed them before. If you have, 
#         just use the "Needed libraries" code below.
#install.packages("mapview")


# Needed libraries #
library(dplyr)
library(sf)               # For st_read() and st_write() - reading and creating files
library(mapview)          # For mapview - viewing shp polygon coordinates in a map
library(here)



########     Subsetting function     ########

subset_polygons <- function(feature, type = c('Parks', 'Watershed', 'Cities'), polygon_name = NULL, view = FALSE){
  
  #Filter if names are supplied
  if (!is.null(polygon_name) || length(polygon_name) != 0) {
    
    if (type == "Parks"){
      
      feature <- feature%>%
        filter(Name %in% polygon_name)
      
    } else if (type == "Watershed"){
      
      feature <- feature%>%
        filter(NOM %in% polygon_name)
      
    } else {
      
      feature <- feature%>%
        filter(CSDNAME %in% polygon_name)
      
    }
    
  }
  
  #View
  if(view == TRUE){
    feature%>%
      st_zm()%>%
      mapview()
    
  }
  
  #Return feature otherwise
  else{
    
    return(feature)
  }
}
  



# Example of use --------------
# Read
# shape_files <- here("tabular_shapefiles/KML_SHP")%>%
#   list.files(".shp")%>%
#   sapply(function(x)paste0(here("tabular_shapefiles/KML_SHP/"), x)%>%
#         read_sf())
# # Polygons to subset
# rand_subset <- shape_files$CensusSubdivisions_lcsd000b16a_e.shp$CSDNAME%>%sample(100)
# 
# # Subset
# subset_polygons(feature = shape_files$CensusSubdivisions_lcsd000b16a_e.shp,
#                 type = c("Cities"), polygon_name = rand_subset, view = TRUE)



###############################################################################
###############################################################################


########     NATIONAL PARKS, PROVINCIAL PARKS AND PROTECTED AREAS      ########


# Reading the shapefile into the R environment as a Spatial object.
pp_pa <- here("tabular_shapefiles")%>%
  here("KML_SHP")%>%
  here("ProtectedAreas_CPCAD_Dec2021.shp")%>%
  sf::st_read()

#ogrListLayers("source_kml_shp/ProtectedAreas_CPCAD_Trial.shp") #deprecated function from rgdal?? (Will)

# Create a data frame with only the names contained in the shapefile.
#       NOTE: You can filter it to find the one you're looking for.
pp_pa_names <- data.frame(Name = pp_pa$Name)%>%
  arrange(Name)


# Copy and paste the name from the names table between the " " (Name == "paste-here").
#         This creates a subset of only the region in the specified name.
new_polygon <- subset(pp_pa, Name == "Opavsky")

# Check the number of elements in new_polygon. If you don't get a 1, go to the 
#       OPTIONAL STEP - Splitting polygons.
length(new_polygon) 

# Inspect the polygon on a map. Make sure you're getting the polygon you want.
#       If you can't see the polygon, you might have more than one polygon in the 
#       "new_polygon" variable. If in such a case go to the OPTIONAL STEP - 
#       Splitting polygons.
mapview(new_polygon)


# OPTIONAL STEP - Splitting polygons of "new_polygon".
#       Depending on the number of elements you get in length(new_polygon), we
#       will split the variable into that number of variables (split_polx) and 
#       inspect each one separately with mapview() to see which one is our 
#       desired polygon. Once you find it, re-assign that variable to "new_polygon"
split_pol <- new_polygon[1,] 
split_pol2 <- new_polygon[2,]
split_pol3 <- new_polygon[3,]

mapview(split_pol)       # Change the split_pol to view all the new variables
new_polygon <- split_pol # Change the split_pol to the right number


# Export the shapefile. Change the name of the output file (layer = "file-name-here").
sf::st_write(new_polygon, dsn = "outputs/subset_shp",
         driver = "ESRI Shapefile", layer = "file-name-here")


###############################################################################
###############################################################################


###########                       WATERSHEDS                      #############


# This file is a kmz without names that can be pulled, follow the protocol's 
#       instructions (Section 4.5) for pulling anything from this file. To 
#       download it go to the following link:
# https://ftp.maps.canada.ca/pub/nrcan_rncan/vector/geobase_nhn_rhn/index/nhn_index_geobase.kmz


###############################################################################
###############################################################################


############             LAKES, RIVERS, CREEKS, PONDS             #############


# Reading the shapefile into the R environment as a Spatial object.
l_r <- sf::st_read("source_kml_shp/LakesAndRivers_lhy_000c16a_f.shp")
ogrListLayers("source_kml_shp/LakesAndRivers_lhy_000c16a_f.shp")

# Create a data frame with only the names contained in the shapefile.
#       NOTE: You can filter it to find the one you're looking for.
l_r_names <- as.data.frame(sort(l_r$NOM))
View(l_r_names)

# Copy and paste the name from the names table between the " " (NOM == "paste-here").
#         This creates a subset of only the region in the specified name.
new_polygon <- subset(l_r, NOM == "paste-here")

# Check the number of elements in new_polygon. If you don't get a 1, go to the 
#       OPTIONAL STEP - Splitting polygons.
length(new_polygon) 

# Inspect the polygon on a map. Make sure you're getting the polygon you want.
#       If you can't see the polygon, you might have more than one polygon in the 
#       "new_polygon" variable. If in such a case go to the OPTIONAL STEP - 
#       Splitting polygons.
mapview(new_polygon)


# OPTIONAL STEP - Splitting polygons of "new_polygon".
#       Depending on the number of elements you get in length(new_polygon), we
#       will split the variable into that number of variables (split_polx) and 
#       inspect each one separately with mapview() to see which one is our 
#       desired polygon. Once you find it, re-assign that variable to "new_polygon"
split_pol <- new_polygon[1,] 
split_pol2 <- new_polygon[2,]
split_pol3 <- new_polygon[3,]
mapview(split_pol)       # Change the split_pol to view all the new variables
new_polygon <- split_pol # Change the split_pol to the right number


# Export the shapefile. Change the name of the output file (layer = "file-name-here").
sf::st_read(new_polygon, dsn = "outputs/subset_shp",
         driver = "ESRI Shapefile", layer = "file-name-here")


###############################################################################
###############################################################################


############                    CITIES, TOWNS                     #############


# Read the shapefile into the R environment as a Spatial object.
c_t <- sf::st_read("source_kml_shp/CensusSubdivisions_lcsd000b16a_e.shp")
ogrListLayers("source_kml_shp/CensusSubdivisions_lcsd000b16a_e.shp")

# Create a data frame with only the names contained in the shapefile.
#       NOTE: You can filter it to find the one you're looking for.
c_t_names <- as.data.frame(sort(c_t$CSDNAME))
View(c_t_names)

# Copy and paste the name from the names table between the " " (CDSNAME == "paste-here").
#         This creates a subset of only the region in the specified name.
new_polygon <- subset(c_t, CSDNAME == "paste-here")

#Check the number of elements in new_polygon. If you don't get a 1, go to the 
#       OPTIONAL STEP - Splitting polygons.
length(new_polygon) 

# Inspect the polygon on a map. If you can't see the polygon, you might have
#       more than one polygon in the "new_polygon" variable. If in such a case
#       go to the OPTIONAL STEP - Splitting polygons.
mapview(new_polygon)


# OPTIONAL STEP - Splitting polygons of new_polygon.
#       Depending on the number of elements you get in length(new_polygon), we
#       will split the variable into that number of variables (split_polx) and 
#       inspect each one separately with mapview() to see which one is our 
#       desired polygon. Once you find it, re-assign that variable to "new_polygon"
split_pol <- new_polygon[1,] 
split_pol2 <- new_polygon[2,]
split_pol3 <- new_polygon[3,]
mapview(split_pol)       # Change the split_pol to view all the new variables
new_polygon <- split_pol # Change the split_pol to the right number


# Export the shapefile. Change the name of the output file (layer = "file-name-here")
#         following the file naming conventions.
sf::st_write(new_polygon, dsn = "outputs/subset_shp",
         driver = "ESRI Shapefile", layer = "file-name-here")


###############################################################################
###                             End of script                               ###
###############################################################################
