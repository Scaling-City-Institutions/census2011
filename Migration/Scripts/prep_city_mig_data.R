# This script will prepare and clean the migration data for each city in India.
#Before running this script download all the city level migration data file in the path: Migration/Data/city

library(readxl)
library(dplyr)

#Path to the data folder
PATH_MIGRATION_CITY=paste(getwd(),"/Migration/Data/city",sep = "")

#Read all the files with extension XLSX and store it in a data frame
#Make sure that only the relevant files are stored there
file.list <- as.data.frame(list.files(pattern='*.XLSX',path  = PATH_MIGRATION_CITY,full.names = TRUE))

#Declare a empty data frame for storing data after merging all the state level files.
city_migration_list=data.frame()

#Iterate through the list of files in the folder and merge
for(i in 1:nrow(file.list)){
  temp_data=read_excel(file.list[i,])
  temp_data=temp_data[5:nrow(temp_data),]
  city_migration_list=rbind(city_migration_list,temp_data)
}


# Prepare list of columns names
col_list=as.data.frame(list(a=c("Table_Name",
                                "State",
                                "District",
                                "City",
                                "Area_Name",
                                "Place_Enumeration",
                                "Duration_Residence",
                                "Last_Residence",
                                "Last_Residence_Type",
                                "Tot_Mig_P",
                                "Tot_Mig_M",
                                "Tot_Mig_F",
                                "Work_Mig_P",
                                "Work_Mig_M",
                                "Work_Mig_F",
                                "Business_Mig_P",
                                "Business_Mig_M",
                                "Business_Mig_F",
                                "Education_Mig_P",
                                "Education_Mig_M",
                                "Education_Mig_F",
                                "Marriage_Mig_P",
                                "Marriage_Mig_M",
                                "Marriage_Mig_F",
                                "Birth_Mig_P",
                                "Birth_Mig_M",
                                "Birth_Mig_F",
                                "HH_Mig_P",
                                "HH_Mig_M",
                                "HH_Mig_F",
                                "Others_Mig_P",
                                "Others_Mig_M",
                                "Others_Mig_F")))

#Add column names
colnames(city_migration_list)=col_list$a

#clean
city_migration_list=filter(city_migration_list,city_migration_list$Table_Name=="D0603")

#Convert all the numbers stored as strings to numeric data type.
city_migration_list=type.convert(city_migration_list,as.is=T)



