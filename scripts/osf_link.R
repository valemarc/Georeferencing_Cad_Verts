#Accessing osf repository data
library(osfr)
library(dplyr)

############################
# Setting up --------------
############################
#Retrieve project info
project <- osf_retrieve_node("mjvwh")

#Authentication
PAT <- Sys.getenv("PAT_KEY") #gets key from .Renviron
osf_auth(PAT)

#List of components in the project 
components <- osf_ls_nodes(project)
data_component <- osf_retrieve_node('qha69') #get path for the data component


#Create a "Data" component (there are already 2 Data components)
# project%>%
#   osf_create_component("Data")


#Make subdirectories in the Data component
new_directories <- c('rawdata', 'tabular_shapefiles', 'outdata')
sapply(new_directories, function(x)osf_mkdir(data_component, x))

#Check that directories are added
osf_retrieve_node('qha69')%>%
  osf_ls_files()


############################
# Accessing files ----------
############################

#Download csv file from DATA component as an example
osf_retrieve_node('qha69')%>% #list files in data component
  osf_ls_files()%>%
  filter(name == "CIEE_Canada_data_upload.csv")%>% #filter out the file that is being downloaded
  osf_download(path = "./osf_data")






