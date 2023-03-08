#' Get velocity
#'
#' @description Calculate absolute-valued first difference of a signal.
#' @param x signal to differentiate
#' @param sampling_rate sampling rate of signal
#' @return Differenced signal
#' @note This function is deprecated, use `tadaR::central_difference` for a better estimate of velocity. If you wish to re-create this function entirely then use `tadaR::first_difference`
#' @export
get_velocity <- function(x, sampling_rate){
  .Deprecated("central_difference", package="tadaR")
  v <- ((x - dplyr::lag(x, default = dplyr::first(x))) / (1/sampling_rate))
  v_abs <- abs(v)
  return(v_abs)
}
