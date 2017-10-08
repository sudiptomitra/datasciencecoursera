# Creating Specdata directory and Unzipping File 
# getwd()
#setwd("C:/Sudipto_BI/Sudipto/DataScience_coursera/Course_2_R_Programming/data")
# getwd()

#unzip("rprog%2Fdata%2Fspecdata.zip",exdir = "Specdata")

# Finding out the file names and no of files
#file_no <- list.files("Specdata")
# no_of_files <-length(file_no)

#Creating filelist for processing 
#file_list <- list.files("Specdata",full.names = TRUE)

# Creating an empty data frame for processing files
# data_read <-data.frame()

#Populating the empty dataframe 
# for(i in 1:no_of_files)
  #              {data_read <- rbind(data_read, read.csv(file_list[i],header = TRUE))
   #             }


pollutantmean <- function(directory, pollutant, id = 1:322 ) {
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files
        
        ## 'pollutant' is a character vector of length 1 indicating
        ## the name of the pollutant for which we will calculate the
        ## mean; either "sulfate" or "nitrate".
        
        ## 'id' is an integer vector indicating the monitor ID numbers
        ## to be used
        
        ## Return the mean of the pollutant across all monitors list
        ## in the 'id' vector (ignoring NA values)
        
        # Finding out the file names and no of files
        file_no <- list.files(directory)
        #no_of_files <- length(file_no)
        
        #Creating filelist for processing 
        file_list <- list.files(directory,full.names = TRUE)
        
        # Creating an empty data frame for processing files
        data_read <-data.frame()
        
        #Populating the empty dataframe 
        for(i in id )
                 {data_read <- rbind(data_read, read.csv(file_list[i],header = TRUE))
                 }
        
        
        mean(data_read[,pollutant],na.rm = TRUE)
                     
        }

