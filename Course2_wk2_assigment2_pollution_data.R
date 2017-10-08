Complete <- function(directory,  id = 1:322 ) {
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files
        
     print(id)
        
        ## 'id' is an integer vector indicating the monitor ID numbers
        ## to be used
        
        ## Return the mean of the pollutant across all monitors list
        ## in the 'id' vector (ignoring NA values)
        
        # Finding out the file names and no of files
       # file_no <- list.files(directory)
        #no_of_files <- length(file_no)
        
        #Creating filelist for processing 
        file_list <- list.files(directory,full.names = TRUE)
        #print(file_list)
        # Creating an empty data frame for processing files
        data_read <- data.frame()
        print("id nobs")
        for (i in id )
                
        {data_read <- rbind(data_read, read.csv(file_list[i],header = TRUE))
        data_read <- data_read[complete.cases(data_read),]
        y <- length(data_read[,4])
        x <- c( i,y)
     
        print(x)
        data_read <- data_read[0,]
        }
        
        
        #return(data.frame(id, nobs))
        
   }

