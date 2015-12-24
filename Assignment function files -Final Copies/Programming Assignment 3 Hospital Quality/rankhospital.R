## Function  that take three arguments: the 2-character abbreviated name of a state,
## outcome name and rank. 
## The function reads the outcome-of-care-measures.csv ranks the hospital 
## name for a given rank in a  given state and returns the ranked hospital
## The outcomes can be one of "heart attack", "heart failure", or "pneumonia". 
## Hospitals that do not have data on a particular
## outcome should be excluded from the set of hospitals when deciding the rankings.
## Handling ties. If there is a tie for the best hospital for a given outcome, then the hospital names should
## be sorted in alphabetical order and the first hospital in that set should be chosen 
## (i.e. if hospitals "b", "c", and "f" are tied for best, then hospital "b" should be returned).


rankhospital <- function(state, outcome, num = "best") {
  
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
  
  
  
  ## Return hospital name in that state with the given rank
  ## 30-day death rate
  if(outcome == 'heart attack'){
    hospName = bestRankHospname(outcomeData,11,state,num)
  }
  
  else if(outcome == 'heart failure'){
      hospName = bestRankHospname(outcomeData,17,state,num)
  }
  else if(outcome == 'pneumonia'){
    hospName = bestRankHospname(outcomeData,23,state,num)
  }
  
  ## rate
  return(hospName)  
}


## This function will subset the dataframe to States and order  hospitals 
## by state and outcome. 
## Then, it will find the hospital as per inputted rank and return the same. 

bestRankHospname <- function(df,outcomecol,state,hrank){
  ## Dataframe subset as per state. State is column 7
  dfsubset <-subset(df, df[,7] == state) 
  
  ## Extracting only 2 required - hospital name and rate - columns
  dfsubset <- dfsubset[, c(2,outcomecol)]
  
  ##Changing column name to HospName , Rates. This will allow for better column access
  colnames(dfsubset)[1] <- paste('HospName')
  colnames(dfsubset)[2] <- paste('Rates')
  
  ##Check if hrank value is greater than number of hospitals in state
  hospCount <- length(dfsubset$HospName)
  if(is.integer(hrank) & hrank > hospCount){
    return ('NA')
  }
  
  ##deleting the NA rows.
  dfsubset <- dfsubset[complete.cases(dfsubset),]
  
  ##  Getting count after deletion of NA rows. 
  ##  This is to assign a 'worst' rank number
  hospCount <- length(dfsubset$HospName)
  
  if(is.character(hrank)) 
     {
  
    if (identical(hrank,'best')) { hrank = 1 }
    
    else if (identical(hrank,'worst')) { hrank = hospCount }
  }
  
  ## Ordering the rates, followed by the hospname. 
  ## This is to handle the Rate tie situation for 2+ hospitals.
  ## Will return best hospital name (alphabetical order), if tied.
  
      dfsubset <- dfsubset[order(dfsubset$Rates, dfsubset$HospName),]
  
      ## Ranking the rates and assigning rank value(ascending order).
      HospRateRank <- rank(dfsubset$Rates)
      
      ## Adding the Rank as a column to dataframe. HospRateRank will be column name
      dfsubset <- cbind(dfsubset,HospRateRank)
      
      ## returning the ranked hospital name.
      write.csv(dfsubset,'rankedhosp.csv')
      return(dfsubset[hrank,1])
      
      ##Best Ranked hospital can be got by searching rank under column HospRateRank
      ## function to do it :  return(dfsubset[(dfsubset$HospRateRank = hrank),1])

 }
