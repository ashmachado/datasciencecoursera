complete <- function(directory, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return a data frame of the form:
  ## id nobs
  ## 1  117
  ## 2  1041
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the
  ## number of complete cases

  allFilesdir <- list.files(path = directory, full.names = TRUE)
  
  filedata <- data.frame()
  finaldata <- data.frame()
  nobs <- 0
  for (id in id){
    
    filedata <- read.csv(allFilesdir[id],header = TRUE)
    
    
   # print(complete.cases(filedata))
    
  #  print(filedata[complete.cases(filedata),])
    
    #counting the logical vector rows of complete cases(TRUE logical value)
    
    #to access the completed data records use code - filedata[complete.cases(filedata),]
    # The , denotes all columns to be displayed
    
    nobs <- sum(complete.cases(filedata)) #sum option to count the logical True. No data frame is returned
    #nobs <- nrow(filedata[complete.cases(filedata),]) - nrows option on the data frame to get count of completed cases
    
    finaldata <- rbind(finaldata, data.frame(id,nobs))
  }
  
  return(finaldata)
  
  }