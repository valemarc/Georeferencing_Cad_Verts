# Georeferencing Canadian Vertabrates

This repository contains scripts for georeferencing times-series of Canadian vertebrates in the [Living Planet Database](https://livingplanetindex.org/). Further details of the project can be found in the [OSF repository](https://osf.io/mjvwh/).

# Description of scripts

## 1. `New_Variable_Calculations.R`

- This script reads shapefiles (*Polygon* data), calculates areas and centroids, and visualizes centroids on a map.
- Segments Polygons into area bins for categorization, making it ideal for geological data analysis.
- supports .shp, .kml , .gdb formats
- required packages: `tidyverse`, `sf`, `geodata`


## 2. `Point_Only_Data_Buffering.R`

- This script creates polygons from *Point only* data. For records with only a single point, a 5km buffer is used to create the polygon. For sources with multiple points, a polygon  is created by fitting the smallest possible polygon that encompasses the set of points (i.e., convex hull). The resulting polygons are then exported as shapefiles for GIS applications.
- reads CSV files only 

- required packages: `tidyverse`, `sf`, `rgdal` (deprecated and needs update)


## 3. `Subsetting_polygons.R`

- This script reads shapefiles and subsets polygons based on named places (i.e. parks, watersheds, lakes, cities).
- Note: There are lots of redundancy in this script with no clear distinction between different types of places in the data. 
- required packages: `sp`, `mapview`

## 4. `osf_update_files.R`

- This script contains functions to download and uploading files to OSF 
- `download_osf_files()` This function downloads all files of a `component` in an OSF `project`. The `project` argument takes the output of a `osf_retrieve_node()` call and the `project` is the character string that specifies the namne of the component that is to be downloaded
- `upload_osf_files()` This function uploads files into the `componeent` of an OSF `project` where files are specified by the a character string that specifies the names of objects to be uploaded
- NOTE: accessing OSF requires authentication which is done by providing a PAT. Currently, the key is stored locally in the .Renviron document for security purposes. 

- required packages: `osfr`




