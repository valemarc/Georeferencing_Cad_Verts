#Accessing osf repository data
library(osfr)
library(dplyr)

############################
# Setting up --------------
############################
#Retrieve project info
project <- osf_retrieve_node("mjvwh")

#List files uploaded into the project 
osf_ls_files(project)

#List components of the project 
osf_ls_nodes(project)

#Create a "Data" component
project%>%
  osf_create_component("Data")

#Make subirectories in the Data component
new_directories <- c('rawdata', 'tabular_shapefiles', 'outdata')
sapply(new_directories, function(x)osf_mkdir(name = x, target = "Data"))


############################
# Accessing files ----------
############################

