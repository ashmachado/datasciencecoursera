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
  
  
  ##the CSV file. Setting new directory 
  setwd(file.path(getwd(),directory))
  
  ##Initializing the pollutant data's sum(of sulphate or nitrate) and count(of sulphate or nitrate)
  pollutantSum <- 0
  pollutantcount <- 0
  pollutant
  ##Alterntate way to read files in directory. this will create a sequential file list. 
    ##wont work if file name is not in sequence
  ##allFiles <- list.files(path = directory, full.names = TRUE)
  ##for (i in id) { 
  ##read.csv(allFiles[i],header=TRUE)
  ##file.info(allFiles[1])
  ##}
  
  
    for (i in id){
  
      if (i < 10){  ##if (max(i) < 10){  
         ##Construct file name and Read data from files numbered from 1 to 9 and get data
         pollutantFileData <- read.csv(paste("00",as.character(i),".csv",sep = ""),header = TRUE)
       
          }
  
      else if (i >=10 & i<100){  ##else if (min(i) >=10 & max(i)<100){  
          ##Construct file name and Read data from files numbered from 10 to 99 and get data
          pollutantFileData <- read.csv(paste("0",as.character(i),".csv",sep = ""),header = TRUE)
          }
        
        else {
          ##Construct file name and Read data from files numbered above 99 and get data
          pollutantFileData <- read.csv(paste(as.character(i),".csv",sep = ""),header = TRUE)
        }
  
     ## Delete all the rows which have NA values. 
     pollutantFileData <- na.omit(pollutantFileData)
  
     ##Counting rows
     pollutantcount = pollutantcount + nrow(pollutantFileData)
  
     ##adding values as per selection of pollutant
     if(pollutant == 'sulfate') {
       pollutantSum <- pollutantSum + sum(pollutantFileData$sulfate) ## Column position of sulphate is 2
              }else{
      pollutantSum <- pollutantSum + sum(pollutantFileData$nitrate) ## Column position of nitrate is 3
      }
  
    }
  
  ##setting back the root folder 
  setwd('..')  
  
  ##Return mean value  
  return (pollutantSum/pollutantcount)

}
