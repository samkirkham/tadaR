#' Butterworth filter
#'
#' @description Construct Butterworth filter and fit to signal with initial conditions.
#' @param x input signal to filter
#' @param filter_type Filter type; either "low", "high", "pass" or "stop" (default is "low")
#' @param filter_order Order of the filter (default is 5)
#' @param filter_cutoffs Cut-off frequency for low-pass filter (default is 20)
#' @param sampling_rate Sampling rate of signal (default is 200)
#' @return Returns the filtered signal
#' @note: This function depends on 'gsignal' package as the 'signal' package implementations do a poor job with the initial state and lead to highly inaccurate signal edges. For example, gsignal::filter and gsignal::filtfilt give same results (only difference is that filtfilt gives 1D array as return, so doesn't need to index 'y' variable as is done inside this function)
#' @export
butterworth_filter <- function(x, filter_type="low", filter_order=5, filter_cutoffs=20, sampling_rate=200){
  bf <- gsignal::butter(n = filter_order, w = filter_cutoffs/(sampling_rate/2), type = filter_type, output = "Sos") # build filter w/ user-specified arguments
  zi <- gsignal::filter_zi(bf) # construct initial conditions
  x_filt <- gsignal::filter(bf, x, zi * x[1]) # filter signal
  return(x_filt$y) # filtered signal is stored in x_filt$y column
}
