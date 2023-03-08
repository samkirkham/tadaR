#' Obtains audio from read_tada object and returns in long format
#'
#' @description Unnests read_tada audio object into long format object
#' the output of this can be attached to an unnested TADA object (output of unnest_tada) that has *then* been converted to long format and has the columns Sample/Time/Variable
#' unnest_tada does not work for obtaining audio due to sampling rate differences between audio and articulatory data
#' @param d tibble produced by read_tada function
#' @return long format object with columns Sample/Time/Variable/Value
#' @export

getAudioLong <- function(d){
  audio <- data.frame(1:nrow(d$audio$SIGNAL))
  colnames(audio) <- c("Sample")
  audio$Time <- audio$Sample/10000 # sr = 10000
  audio$Variable <- c("Audio")
  audio$Value <- d$audio$SIGNAL
  audio <- data.frame(audio)
  return(audio)
}
