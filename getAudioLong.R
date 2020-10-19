# Sam Kirkham 2019-11-22
# Functions for reading + processing Matlab files from TADA (TAsk Dynamic Application)


### getAudioLong ###
# FUNCTION: transforms audio object from TADA into a usable long format, which can be attached to an unnested TADA object (output of unnestTADA) that has *then* been converted to long format and has the columns Sample/Time/Variable/Value
# INPUT: data object produced by readTADA
# OUTPUT: long object with columns Sample/Time/Variable/Value
getAudioLong <- function(d){
  audio <- data.frame(1:nrow(d$audio$SIGNAL))
  colnames(audio) <- c("Sample")
  audio$Time <- audio$Sample/10000 # sr = 10000
  audio$Variable <- c("Audio")
  audio$Value <- d$audio$SIGNAL
  audio <- data.frame(audio)
  return(audio)
}