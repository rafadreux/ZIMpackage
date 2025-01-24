#'  Get the points for the models
#'
#'  This function extracts the parameters from the ZIM daily curves to be used in the classification models. The function was built to analyze data registered every 5 minutes.
#'  @param Pp_ZIM Sequence of numbers provided by the ZIM probe in one day (from 00:00 to 23:59)
#'  @return Eight parameters used as input variables for the random forest models available in this package.
#'  @export
get_points <- function(Pp_ZIM){
  f21 = rep(1/21,21)
  x2 <- stats::filter(Pp_ZIM,f21,method="convolution",sides=2) #moving average
  h1 <- seq(0,23.99,by=24/length(x2))
  l <- length(h1)
  l1 <- l-20
  x3 <- x2[11:(l-10)] #removes NAs introduced after moving average
  h2 <- h1[11:(l-10)]
  x4 <- which.max(x3) #maximum Pp value
  x5 <- which.min(x3) #minimum Pp value
  x6 <- summary(lm(x3[x4:x5]~h2[x4:x5]))[[4]][2,1] #slope of the linear model between minimum and maximum values
  x7 <- max(x3,na.rm=T)/min(x3,na.rm=T) #ratio between maximum and minimum values
  x8 <- c(x3[l1/4]/x3[3],x3[l1/2]/x3[l1/4],x3[l1*0.75]/x3[l1/2],x3[l1]/x3[l1*0.75])
  x9 <- summary(lm(x3[195:l1]~h2[195:l1]))[[4]][2,1] #slope of the linear model obtained from late afternoon until the end of the day
  x10 <- min(x3[120:l1])/min(x3,na.rm=T) #ratio between the minimum after midday and the daily minimum
  a1 <- diff(x3,lag=1)<0 #gets the difference between measurements
  a2 <- which(a1)
  a3 <- which(diff(a2)>1)
  le <- length(a2)-1
  a4 <- diff(c(0,a3,le))
  a5 <- max(a4)
  a6 <- which(a4==a5)
  if(length(a6)>1){ # b1 is the biggest point of inflection (followed by descending values)
    b1 <- a2[a6[1]]
  }else{
    if(a6==1){b1 <- a2[a6]
    } else {
      b1 <- a2[sum(a4[1:a6-1])+1]
    }
  }
  a7 <- x2[b1+a5-1]/x2[b1] #ratio between the point of inflection (b1) and the lowest value after the inflection
  a8 <- sort(a4,decreasing=T)
  if(length(a8)>=3){
    if(a8[2]==a8[3]) {
      a9 <- a2[sum(a4[1:which(a4==a8[2])[1]-1])+1]
      a10 <- a2[sum(a4[1:which(a4==a8[2])[2]-1])+1]
      a11 <- which.max(c(x2[a9+a8[2]]/x2[a9],x2[a10+a8[3]]/x2[a10]))
      if(a11==1){
        a12 <- a9
        a13 <- x2[a12+a8[2]]/x2[a12]
        a14 <- a8[2]
      } else {
        a12 <- a10
        a13 <- x2[a12+a8[3]]/x2[a12]
        a14 <- a8[3]
      }
    } else if(a8[1]==a8[2]){
      a9 <- a2[sum(a4[1:which(a4==a8[1])[2]-1])+1]
      a12 <- x3[a9+a8[2]]/x3[a9]
      a14 <- a8[2]
    } else {
      a9 <- a2[sum(a4[1:which(a4==a8[2])-1])+1]
      a12 <- x3[a9+a8[2]]/x3[a9]
      a14 <- a8[2]
    }
    if(a8[2]==a8[3]){
      return(c(slope_1 = x9, slope_2 = x6, max1 = b1, pmax1 = a5, rat1 = a7,
               max2 = a12, pmax2 = a14, rat2 = a13))
    } else {
      return(c(slope_1 = x9, slope_2 = x6, max1 = b1, pmax1 = a5, rat1 = a7,
               max2 = a9, pmax2 = a14, rat2 = a12))
    }
  } else if (length(a8)==2){
    a9 <- a2[sum(a4[1:which(a4==a8[2])-1])+1]
    a12 <- a8[2]
    a14 <- x2[a9+a8[2]]/x2[a9]
    return(c(slope_1 = x9, slope_2 = x6, max1 = b1, pmax1 = a5, rat1 = a7,
             max2 = a9, pmax2 = a12, rat2 = a14))
  } else {
    a9 <- NA
    a12 <- NA
    a14 <- NA
    return(c(slope_1 = x9, slope_2 = x6, max1 = b1, pmax1 = a5, rat1 = a7,
             max2 = a9, pmax2 = a12, rat2 = a14))
  }
}
