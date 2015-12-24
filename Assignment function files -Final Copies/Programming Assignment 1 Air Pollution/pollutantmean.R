pollutantmean <- function(directory, pollutant, id = 1:332){
  
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'pollutant' is a character vector of length 1 indicating
  ## the name of the pollutant for which we will calculate the
  ## mean; either "sulfate" or "nitrate".
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return the mean of the pollutant across all monitors list
  ## in the 'id' vector (ignoring NA values)
  ## NOTE: Do not round the result!
  
  
 
  ##Initializing the pollutant data's sum(of sulphate or nitrate) and count(of sulphate or nitrate)
  pollutantfileData <- data.frame()
  
  allFiles <- list.files(path = directory, full.names = TRUE)
  for (i in id) { 
      pollutantfileData <- rbind(pollutantfileData, read.csv(allFiles[i],header=TRUE))
    }
  
    return(mean(pollutantfileData[,pollutant],na.rm = TRUE))  

}
