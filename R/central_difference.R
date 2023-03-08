#' Calculate central difference of a signal
#'
#' @param x numeric input
#' @param sampling_rate sampling rate in Hz (numeric)
#' @param endpoints calculate first and last values using backward/forward difference (default is TRUE)
#' @param abs return absolute values (default is FALSE)
#' @examples
#' \dontrun{
#' # create time object with 0.005s step size (sampling_rate=200)
#' t <- seq(0, 1, by=0.005)
#' # compute sine wave over t
#' y <- sin(2*pi*t)
#' # calculate central difference
#' central_difference(y, sampling_rate=200)
#' # calculate central difference with absolute values and plot against t
#' y_diff <- central_difference(y, sampling_rate=200, abs=TRUE)
#' plot(t, y_diff, type="l")
#' # do not calculate first/last values and instead return NA
#' central_difference(y, sampling_rate=200, endpoints=FALSE)
#' }
#' @note If `endpoints=TRUE` (default) then `x[1]` is calculated using backward_difference and `x[length(x)]` (last value in `x`) is calculated using the forward_difference. All other values are calculated using the central difference. If `endpoints=FALSE` then `x[1]` and `x[length(x)]` will be NA.
#' @export
central_difference <- function(x, sampling_rate, endpoints=TRUE, abs=FALSE){
  v <- (dplyr::lead(x) - dplyr::lag(x)) / (2/sampling_rate)
  if(endpoints==FALSE){} else{
    # replace first value with backward difference (only run on first 2 values)
    v[1] <- tadaR::backward_difference(x[1:2], sampling_rate=sampling_rate)[1]
    # replace last value with forward difference (only run on last 2 values)
    v[length(x)] <- tadaR::forward_difference(x[(length(x)-1):length(x)], sampling_rate=sampling_rate)[2]
  }
  if(abs==TRUE){
    v <- abs(v)
  }
  return(v)
}
