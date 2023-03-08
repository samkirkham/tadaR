#' Create a TADA function argument to pass to Matlab
#'
#' @description Convenience function for constructing TADA code that can be passed to run_tada(tada_command = ...). It creates arguments of the form "tada <output_file> <input_string>" or "gest <output_file> <input_string>" when gest=TRUE.
#' @param output_name Output filename. If input_string=NULL then this will also be used for the input_string argument.
#' @param input_string Optional input string. If NULL then 'output_name' will be used (default is NULL)
#' @param gest Logical. gest=FALSE builds a 'tada ...' argument, gest=TRUE builds a 'gest ...' argument (default is NULL)
#' @return Character vector corresponding to a TADA tada/gest command
#' @examples
#' \dontrun{
#' # creates the command "tada 'cat' 'cat'"
#' tada_stimulus("cat")
#' # creates the command "gest 'cat' 'cat'"
#' tada_stimulus("cat", gest=TRUE)
#' # create the command "tada 'cat' '(KAE1T)'"
#' tada_stimulus("cat", "(KAE1T)")
#' }
#' @export
tada_stimulus <- function(output_name, input_string=NULL, gest=FALSE){
  if(gest==FALSE){
    fnc = "tada"
  } else{
    fnc = "gest"
  }
  if(is.null(input_string)){
    paste0(fnc, " ", "\'", output_name, "\'" , " ", "\'", output_name, "\'")
  } else{
    paste0(fnc, " ", "\'", output_name, "\'" , " ", "\'", input_string, "\'")
  }
}
