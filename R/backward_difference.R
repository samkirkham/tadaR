#' Calculate backward difference of a signal
#'
#' @param x numeric input
#' @param sampling_rate sampling rate in Hz (numeric)
#' @param replace_last numeric value used to replace NA in last cell (default is NA)
#' @param abs return absolute values (default is FALSE)
#' @examples
#' \dontrun{
#' # create time object with 0.005s step size (sampling_rate=200)
#' t <- seq(0, 1, by=0.005)
#' # compute sine wave over t
#' y <- sin(2*pi*t)
#' # calculate backward difference
#' backward_difference(y, sampling_rate=200)
#' backward_difference(y, sampling_rate=200, abs=TRUE)
#' # replace last cell with the last value of y
#' backward_difference(y, sampling_rate=200, replace_last = dplyr::last(y))
#' }
#' @note As backward_difference calculates the difference between points, it does not by default return a difference value for the final value of a signal, because it cannot be differenced against a value that follows it. Use central_difference for reliable differencing across the entire signal.
#' @export
backward_difference <- function(x, sampling_rate, replace_last=NA, abs=FALSE){
  v <- (dplyr::lead(x, default=replace_last) - x) / (1/sampling_rate)
  if(abs==TRUE){
    v <- abs(v)
  }
  return(v)
}
