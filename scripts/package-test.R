#Install and load package
#install.packages("devtools")
#install.packages('sf')
devtools::install_github("jiaangou/GeoRef")
library(GeoRef)
#library(sf)
library(dplyr)

#Link OSF --------------------------
project_ID <- "mjvwh" #project ID
PAT_KEY = "SGvfuq116RBO0adsp0xjgUttEnkDC9EWb1FqgWorv7SJXjtDivIusbyGKfGy5csjXvlaqA" #Personal Access Token
project <- osf_setup(project_ID = project_ID, PAT = PAT_KEY) #Connection

#Download --------------------------
osf_updating(project = project, component = "Data", type = 'download')


#Reading files --------------------------
#shp file
shp_file <- here::here("tabular_shapefiles/KML_SHP/CensusSubdivisions_lcsd000b16a_e.shp")%>%
  sf::st_read()
#time-series data
ts_data <- here::here("rawdata/CIEE_Canada_data_upload.csv")%>%
  read.csv()


#Subset polygons --------------------------
rand_names <- shp_file$CSDNAME%>%
  sample(100)
subset_polygons(shp_file, type = 'Cities', polygon_name = rand_names, view = TRUE)
shp_subset <- subset_polygons(shp_file, type = 'Cities', polygon_name = rand_names, view = FALSE)
#sf::st_write(shp_subset, dsn = here::here("outdata/subset.shp"))


#Adding buffers --------------------------
ts_data%>%
  sample_n(10)%>%
  add_buffers(buffer_radius = 50000, view = TRUE)

point_buffers <- ts_data%>%
  sample_n(10)%>%
  add_buffers(buffer_radius = 500, view = FALSE)




#Spatial statistics --------------------------
shp_file%>%
  sample_n(5)%>%
  spatial_statistics()

#Multiple coordinates (Convex hulls) --------------------------
ts_data%>%
  sample_n(30)%>%
  mutate(group = rep(c('a','b'), each = 15))%>%
  convex_hull(data = ., group = group, crs = 4269)


#Uploading  --------------------------
#osf_updating(project = project, component = "Data", type = 'upload')

