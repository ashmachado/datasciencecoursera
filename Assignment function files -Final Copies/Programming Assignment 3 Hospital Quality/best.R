## Function  that take two arguments: the 2-character abbreviated name of a state and an
## outcome name. The function reads the outcome-of-care-measures.csv and returns a character vector
## with the name of the hospital that has the best (i.e. lowest) 30-day mortality for the specifed outcome
## in that state. The hospital name is the name provided in the Hospital.Name variable. The outcomes can
## be one of "heart attack", "heart failure", or "pneumonia". Hospitals that do not have data on a particular
## outcome should be excluded from the set of hospitals when deciding the rankings.
## Handling ties. If there is a tie for the best hospital for a given outcome, then the hospital names should
## be sorted in alphabetical order and the first hospital in that set should be chosen 
## (i.e. if hospitals "b", "c", and "f" are tied for best, then hospital "b" should be returned).


best <- function(state, outcome) {
  
 
  ## Save old directory and set new directory
  old.dir <- getwd()
  setwd('rprog-data-ProgAssignment3-data')
  
  ## Read outcome data
  outcomeData <- read.csv('outcome-of-care-measures.csv', header = TRUE, colClasses = 'character')
  
  ## Set old directory
  setwd(old.dir)
  
  ## Converting to numeric and suppressing coversion warnings
  ## 'heart attack' is column 11
  ## 'heart failure' is column 17
  ## 'pneumonia' is column 23
  outcomeData[,11] <- suppressWarnings(as.numeric(outcomeData[,11]))
  outcomeData[,17] <- suppressWarnings(as.numeric(outcomeData[,17]))
  outcomeData[,23] <- suppressWarnings(as.numeric(outcomeData[,23]))
  
  ## Check that state and outcome are valid
  ## State is column 7. get unique states
  uniquestates <- unique(outcomeData[,7]);
  validInputoutcome <- c('heart attack', 'heart failure', 'pneumonia')
  
  ## Check if state input is valid
  if(is.na(match(state, uniquestates))){
    ##stop will display message as - Error in best("TXd", "heart failure")  : invalid state
    stop (' invalid state')
  } 
  ## Check if outcome input is valid 
  else if (is.na(match(outcome, validInputoutcome))){ 
    ## stop will display message as - Error in best("TX", "hearsst failures") : invalid outcome
    stop(' invalid outcome')
  }
  
  ## Return hospital name in that state with lowest 30-day death. Calls the bestHospname function
  ## 'heart attack' is column 11
  ## 'heart failure' is column 17
  ## 'pneumonia' is column 23
  
  
  if(outcome == 'heart attack'){
    ##bestRankedHosp = bestRankHospname(outcomeData,11,state)
    bestHospname = bestRankHospname(outcomeData,11,state)
  }
  
  else if(outcome == 'heart failure'){
    ##bestRankedHosp = bestRankHospname(outcomeData,17,state)
    bestHospname = bestRankHospname(outcomeData,17,state)
  }
  else if(outcome == 'pneumonia'){
    ##bestRankedHosp = bestRankHospname(outcomeData,23,state)
    bestHospname = bestRankHospname(outcomeData,23,state)
  }
  
  ## rate
  return(bestHospname)  
}

## This function will subset the dataframe to States and considers the rate 
## column number input to find hospital with least death rate for that outcome. 
## And then subsets dataframe to 2 columns - hospital name and rate - and 
## orders rate and hospital in ascending order.
## Function returns the hospital with least death rate i.e. best hospital
bestRankHospname <- function(df,outcomecol,state){
  
  ## Dataframe subset as per state. State is column 7
  dfsubset <-subset(df, df[,7] == state) 
  
  ## Extracting only 2 required - hospital name and rate - columns
  dfsubset <- dfsubset[, c(2,outcomecol)]
  
  ##deleting the NA rows.
  dfsubset <- dfsubset[complete.cases(dfsubset),]
  ##alternate way - dfsubset[,outcomecol] <- dfsubset[!is.na(dfsubset[,outcomecol])]
  
  ##Changing column name to HospName , Rates. This will allow for better column access
  colnames(dfsubset)[1] <- paste('HospName')
  colnames(dfsubset)[2] <- paste('Rates')
  
  ## Ordering the rates, followed by the hospname. 
  ## This is to handle the Rate tie situation for 2+ hospitals.
  ## Function will return the best hospital name (alphabetical order), if tied.
  ## dfsubset <- dfsubset[order(dfsubset[,2], dfsubset[,1]),]
  
  dfsubset <- dfsubset[order(dfsubset$Rates, dfsubset$HospName),]
 
  return (dfsubset$HospName[1])
}



## Not to be used This is a alternate funciton to get minimum rate
bestRankHospnameBACKUPOPTION <- function(df,outcomecol,state){
  
  dfstatesubset <- subset(df, df[,7] == state) 
  minrate <- min(dfstatesubset[,outcomecol], na.rm = TRUE)
  print(minrate)
  minrateindex <- which(dfstatesubset[,outcomecol] == minrate)
  
  bestRankhosp <- c()
  
  minrateindexlen <- length(minrateindex)
  
  if(minrateindexlen > 1){
    
    for(i in minrateindexlen){
      bestRankhosp <- c(bestRankhosp,dfstatesubset[i,2])
    }
    bestRankhosp <- sort(bestRankhosp, decreasing = FALSE)
    print(bestRankhosp)
  }
  else {
    bestRankhosp <- dfstatesubset[minrateindex,2]
  }
  
  return(bestRankhosp[1])
}

