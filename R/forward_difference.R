#' Calculate forward difference of a signal
#'
#' @param x numeric input
#' @param sampling_rate sampling rate in Hz (numeric)
#' @param replace_first numeric value used to replace NA in the first cell (default is NA)
#' @param abs return absolute values (default is FALSE)
#' @examples
#' \dontrun{
#' # create time object with 0.005s step size (sampling_rate=200)
#' t <- seq(0, 1, by=0.005)
#' # compute sine wave over t
#' y <- sin(2*pi*t)
#' # calculate forward difference
#' forward_difference(y, sampling_rate=200)
#' forward_difference(y, sampling_rate=200, abs=TRUE)
#' # replace first cell with the first value of y
#' forward_difference(y, sampling_rate=200, replace_first = dplyr::first(y))
#' }
#' @note As foward_difference calculates the difference between points, it does not by default return a difference value for the first value of a signal, because it cannot be differenced against a value that occurs before it. Use central_difference for reliable differencing across the entire signal.
#' @export
forward_difference <- function(x, sampling_rate, replace_first=NA, abs=FALSE){
  v <- (x - dplyr::lag(x, default=replace_first)) / (1/sampling_rate)
  if(abs==TRUE){
    v <- abs(v)
  }
  return(v)
}
