############################
#Updating OSF files
############################
library(osfr)
library(dplyr)


#Functions -------
# 1. Downloading
download_osf_files <- function(project,
                               component){
  
  project%>%
    osf_ls_nodes()%>%
    filter(name == component)%>%
    osf_ls_files()%>%
    osf_download(conflicts = "overwrite")
  
  
}

# 2. Uploading
upload_osf_files <- function(project, component, files){
  
  project%>%
    osf_ls_nodes()%>%
    filter(name == component)%>%
    osf_upload(path = files, conflicts = "overwrite")
  
}


#Authentication
PAT <- Sys.getenv("PAT_KEY") #gets key from .Renviron
osf_auth(PAT)

#Retrieve node 
project <- osf_retrieve_node("mjvwh")

#Download 
#project%>%
#  download_osf_files(project = ., component = "Data")

#Upload
#upload_osf_files(project, component = "Data", files = c('outdata','rawdata','tabular_shapefiles'))
