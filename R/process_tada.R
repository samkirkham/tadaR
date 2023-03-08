#' Process TADA simulation data (smoothing, calculate velocity and tangential velocity)
#'
#' @description Smooths all model articulator variables and calculates absolute-valued velocity in x- and y-dimensions, as well as tangential velocity in x/y plane, for model articulatory variables. Smoothing and velocity calculation is done by calling tadaR::butter_filt and tadaR::get_velocity, which can also be used externally to this function.
#' @param d tibble produced by unnest_tada function
#' @param filter_type Filter type; either "low", "high", "pass" or "stop" (default is "low")
#' @param filter_order Order of the filter (default is 5 = 5th-order)
#' @param filter_cutoffs Cut-off frequency for low-pass filter (default is 20 Hz; for pass or stop filter cutoffs should be of length 2)
#' @param sampling_rate Sampling rate of TADA data (default is 200 Hz)
#' @param abs return absolute values for _vel columns (default is TRUE; _tvel returns the magnitude so is inherently absolute-valued even if abs=FALSE)
#' @return Returns the input object with the addition of _filt, _vel and _tvel variables for model articulator columns
#' @importFrom magrittr %>%
#' @export
process_tada <- function (d, filter_type="low", filter_order=5, filter_cutoffs=20, sampling_rate=200, abs=TRUE){

  # list of articulatory variable columns to process (should always be the same)
  articulator_cols <- c("TTx", "TTy", "TFx", "TFy", "TDx", "TDy", "TRx", "TRy", "ULx", "ULy", "LLx", "LLy", "JAWx", "JAWy")

  # run all following on 'd'
  d <- d %>%
    # run butter_filter on 'articulator_cols' list
    dplyr::mutate(dplyr::across(
      .cols=tidyselect::all_of(articulator_cols),
      .fns=tadaR::butterworth_filter, filter_type=filter_type, filter_order=filter_order, filter_cutoffs=filter_cutoffs, sampling_rate=sampling_rate,
      .names="{.col}_filt")) %>%
    # run get_velocity on filtered versions of 'articulator_cols' list
    dplyr::mutate(dplyr::across(
      .cols=paste0(tidyselect::all_of(articulator_cols), "_filt"), # adds '_filt' suffix to 'articulator_cols'
      .fns=tadaR::central_difference, sampling_rate=sampling_rate, abs=abs,
      .names="{.col}_vel"))

  # rename velocity columns '_vel' rather than '_filt_vel' (just a bit more convenient)
  names(d) <- gsub("_filt_vel", "_vel", names(d))

  # write function to calculate tangential velocity
  # note: this is an internal function that depends on a column list, so not likely to be useful outside of this specific function
  tada_tvel <- function(d, col_basename){
    col_x <- paste0(col_basename, "x_vel")
    col_y <- paste0(col_basename, "y_vel")
    col_new <- paste0(col_basename, "_tvel")
    d[[col_new]] <- sqrt(d[[col_x]]^2 + d[[col_y]]^2)
    return(d)
    }

  # loop ' tada_tvel' function over list of column basenames to create _tvel columns
  col_basenames <- c("TT", "TF", "TD", "TR", "UL", "LL", "JAW")
  for(i in 1:length(col_basenames)){
    d <- tada_tvel(d, col_basenames[i])
  }

  # return 'd' object
  return(d)
}
