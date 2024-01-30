# Georeferencing Canadian Vertabrates

This repository contains scripts for georeferencing times-series of Canadian vertebrates in the [Living Planet Database](https://livingplanetindex.org/). Further details of the project can be found in the [OSF repository](https://osf.io/mjvwh/).

# Description of scripts

## 1. `New_Variable_Calculations.R`

- This script reads *Polygon* data and calculates relevant spatial statistics such as  areas and centroids. 
- required packages: `tidyverse`, `sf`, `geodata`


## 2. `Point_Only_Data_Buffering.R`

- This script creates polygons from *Point only* data. For records with only a single point, a 5km buffer is used to create the polygon. For sources with multiple points, a polygon  is created by fitting the smallest possible polygon that encompasses the set of points (i.e., convex hull). The resulting polygons are then exported as shapefiles for GIS applications.

- required packages: `tidyverse`, `sf`, `rgdal` (deprecated and needs update)


## 3. `Subsetting_polygons.R`

- This script reads shapefiles and subsets polygons based on named places (i.e. parks, watersheds, lakes, cities).
- Note: There are lots of redundancy in this script with no clear distinction between different the types of places in the data. 
- required packages: `sp`, `mapview`