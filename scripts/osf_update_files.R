############################
#Updating OSF files
############################
library(osfr)

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



#Create an example file locally so we can push it to OSF
# write.csv(iris, file = "iris.csv")
# write.csv(cars, file = 'cars.csv')
# 
# #Upload file to data component 
# #osf_upload(data_component, path = 'iris.csv') #individually
# osf_upload(data_component, path = list.files(pattern = ".csv$")) #in batch
# 
# #List files in the component to check that its been uploaded
# data_component%>%
#   osf_ls_files() 
# 
# #Update files in batches 
# data_component%>%
#   osf_upload(path = list.files(pattern = '.csv$'), conflicts = "overwrite")
# 
# 
# #Delete example files
# files <- c('iris.csv', 'cars.csv')
# sapply(files, function(x)data_component%>%
#          osf_ls_files()%>%
#          filter(name == x)%>%
#          osf_rm())
# 
