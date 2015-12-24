corr <- function(directory, threshold = 0) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'threshold' is a numeric vector of length 1 indicating the
  ## number of completely observed observations (on all
  ## variables) required to compute the correlation between
  ## nitrate and sulfate; the default is 0
  
  ## Return a numeric vector of correlations
  ## NOTE: Do not round the result!

  allfiles <- list.files( path = directory, full.names = TRUE )
  
  corvec <- c() 
  
  for(i in 1:length(allfiles)){ ##1:length is required as length is a derived field
    filedata <- read.csv(allfiles[i],header = TRUE)
    filedata <- filedata[complete.cases(filedata),] ##get the data frame of all complete case rows/records.
    ## the complete.cases(filedata), is applied to all rows. Column value is not mentioned.  
    ##print(filedata)
    
    if ( nrow(filedata) > threshold ) {
      corvec <- c(corvec, cor(filedata$sulfate, filedata$nitrate)) ##  
    }
    
  } ##for loop end
  
  return(corvec)
}


 