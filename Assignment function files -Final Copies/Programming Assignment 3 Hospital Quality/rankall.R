## Function  that take three arguments: the 2-character abbreviated name of a state,
## outcome name and rank. 
## The function reads the outcome-of-care-measures.csv and ranks all  hospital 
## name for a given rank in all states and return list of hospitals in all states with the rank.
## Hospital name for some states can be NA. 
## The outcomes can be one of "heart attack", "heart failure", or "pneumonia". 
## Hospitals that do not have data on a particular
## outcome should be excluded from the set of hospitals when deciding the rankings.
## Handling ties. If there is a tie for the best hospital for a given outcome, then the hospital names should
## be sorted in alphabetical order and the first hospital in that set should be chosen 
## (i.e. if hospitals "b", "c", and "f" are tied for best, then hospital "b" should be returned).

rankall <- function(outcome, num = "best") {
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
  
 
  ## Check if outcome input is valid 
  validInputoutcome <- c('heart attack', 'heart failure', 'pneumonia')
  if (is.na(match(outcome, validInputoutcome))){ 
    ## stop will display message as - Error in best("TX", "hearsst failures") : invalid outcome
    stop(' invalid outcome')
  }
  
    ## For each outcome, find the hospitals of all states per given rank
  if(outcome == 'heart attack'){
    rankAllhosp = hospitalRankperState(outcomeData,11,num,uniquestates)
  }
  
  else if(outcome == 'heart failure'){
    rankAllhosp = hospitalRankperState(outcomeData,17,num,uniquestates)
  }
  else if(outcome == 'pneumonia'){
    rankAllhosp = hospitalRankperState(outcomeData,23,num,uniquestates)
  }
  
  ## Return a data frame with the hospital names and the
  ## (abbreviated) state name
  write.csv(rankAllhosp, 'rankallhosp.csv')
  return(rankAllhosp) 
}


hospitalRankperState <- function(df,outcomecol,num,uniquestates){
  
  ## An empty vector to fill in state-wise data, row by row.
  outputRankAllHosp <- vector()
  
    for(i in 1:length(uniquestates)){
      
      ## This is required to reset the rank as the hrank value is modified on 
      ## each for for loop run
      hrank <- num
      
      hospName <- c()
      stateName = uniquestates[i]
      
      ## Dataframe subset as per state. State is column 7
      dfsubset <-subset(df, df[,7] == stateName)
      
      ## Extracting only 2 required - hospital name and rate - columns
      dfsubset <- dfsubset[, c(2,outcomecol)]
      
      ##Changing column name to HospName , Rates. This will allow for better column access
      colnames(dfsubset)[1] <- paste('HospName')
      colnames(dfsubset)[2] <- paste('Rates')
      
      
      hospCount <- length(dfsubset$HospName)
      ## Check if rank value is greater than number of hospitals in state
      ## If condition is Yes, make hospname as NA
      if(is.integer(hrank) & hrank > hospCount){
              hospName <- 'NA'
      } ## End of IF loop
      else 
        { ## Get the hospital name as per rank.
          
          ##deleting the NA rows.
              dfsubset <- dfsubset[complete.cases(dfsubset),]
              
              ##  Getting count after deletion of NA rows. 
              ##  This is to assign a 'worst' rank number
              hospCount <- length(dfsubset$HospName)
              
              
              if(is.character(hrank) & identical(hrank,'best')) { hrank = 1 }
              else if (is.character(hrank) & identical(hrank,'worst')) { hrank = hospCount }
                ##if (identical(hrank,'best')) { hrank = 1 }
                ##if (identical(hrank,'worst')) { hrank = hospCount }
                ##}
              
              ## Ordering the rates, followed by the hospname. 
              ## This is to handle the Rate tie situation for 2+ hospitals.
              ## Will return best hospital name (alphabetical order), if tied.
              dfsubset <- dfsubset[order(dfsubset$Rates, dfsubset$HospName),]
              hospName = dfsubset[hrank,1]
      } ## end of else loop
      
      ## Appending Hospital and State to the vector outputRankAllHosp
      outputRankAllHosp <- append(outputRankAllHosp, hospName)
      outputRankAllHosp <- append(outputRankAllHosp, stateName)
      
    } ## End of For Loop
  
  ##Coverting the final result vector to a matrix and then to a data frame.
  ##byrow = TRUE is to fill the data by rows.
  outputRankAllHosp <- as.data.frame(matrix(outputRankAllHosp,nrow = length(uniquestates),ncol = 2, byrow = TRUE))
  colnames(outputRankAllHosp) <- c("hospital","state")
 
  return(outputRankAllHosp)
  
}