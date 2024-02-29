# Georeferencing Canadian Vertabrates

This repository contains scripts for georeferencing times-series of Canadian vertebrates in the [Living Planet Database](https://livingplanetindex.org/). Further details of the project can be found in the [OSF repository](https://osf.io/mjvwh/).

Functions in this repository are now available with full documentation and help files in the [`GeoRef`](https://github.com/jiaangou/GeoRef) package. 


# Description of scripts

## 1. `New_Variable_Calculations.R`

- Reads shapefiles (*Polygon* data), calculates areas and centroids, and visualizes centroids on a map.
- Segments Polygons into area bins for categorization, making it ideal for geological data analysis.
- supports .shp, .kml , .gdb formats
- Currently implemented as `spatial_stats()` in the `GeoRef` package
- required packages: `tidyverse`, `sf`, `geodata`


## 2. `Point_Only_Data_Buffering.R`

- Creates polygons from *Point only* data. For records with only a single point, a 5km buffer is used to create the polygon. For sources with multiple points, a polygon  is created by fitting the smallest possible polygon that encompasses the set of points (i.e., convex hull). The resulting polygons are then exported as shapefiles for GIS applications.
- reads CSV files only 
- Currently implemented as `multiple_coordinates()` in the `GeoRef` package
- required packages: `tidyverse`, `sf`, `rgdal` (deprecated and needs update)


## 3. `Subsetting_polygons.R`

- Reads shapefiles and subsets polygons based on named places (i.e. parks, watersheds, lakes, cities).
- Note: There are lots of redundancy in this script with no clear distinction between different types of places in the data. 
- Currently implemented as `subset_polygons()` in the `GeoRef` package
- required packages: `sp`, `mapview`

## 4. `osf_link.R`

- Links current R session with OSF so that files can be exchanged between them. Requires OSF project ID and a Personal Access Token (PAT)
- Currently implmented as `osf_setup()` in the `GeoRef` package
- required packages: `osfr`


## 5. `osf_update_files.R`

- Contains functions to download and uploading files to OSF 
- `download_osf_files()` This function downloads all files of a `component` in an OSF `project`. The `project` argument takes the output of a `osf_retrieve_node()` call and the `project` is the character string that specifies the namne of the component that is to be downloaded
- `upload_osf_files()` This function uploads files into the `componeent` of an OSF `project` where files are specified by the a character string that specifies the names of objects to be uploaded
- NOTE: accessing OSF requires authentication which is done by providing a PAT. Since every user will have their own PAT, it is best practice to have the key stored locally in the .Renviron document for security purposes. 
- Currently implmented as `osf_updating()` in the `GeoRef` package
- required packages: `osfr`




