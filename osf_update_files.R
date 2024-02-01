############################
#Update files to OSF
############################

#Create an example file locally so we can push it to OSF
write.csv(iris, file = "iris.csv")
write.csv(cars, file = 'cars.csv')

#Upload file to data component 
#osf_upload(data_component, path = 'iris.csv') #individually
osf_upload(data_component, path = list.files(pattern = ".csv$")) #in batch

#List files in the component to check that its been uploaded
data_component%>%
  osf_ls_files() 

#Update files in batches 
data_component%>%
  osf_upload(path = list.files(pattern = '.csv$'), conflicts = "overwrite")


#Delete example files
files <- c('iris.csv', 'cars.csv')
sapply(files, function(x)data_component%>%
         osf_ls_files()%>%
         filter(name == x)%>%
         osf_rm())

