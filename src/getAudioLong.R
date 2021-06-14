#' Obtains audio from readTADA object and returns in long format
#'
#' @description Unnests readTADA audio object into long format object
#' the output of this can be attached to an unnested TADA object (output of unnestTADA) that has *then* been converted to long format and has the columns Sample/Time/Variable
#' unnestTADA does not work for obtaining audio due to sampling rate differences between audio and articulatory data
#' @param d tibble produced by readTADA function
#' @return long format object with columns Sample/Time/Variable/Value

getAudioLong <- function(d){
  audio <- data.frame(1:nrow(d$audio$SIGNAL))
  colnames(audio) <- c("Sample")
  audio$Time <- audio$Sample/10000 # sr = 10000
  audio$Variable <- c("Audio")
  audio$Value <- d$audio$SIGNAL
  audio <- data.frame(audio)
  return(audio)
}