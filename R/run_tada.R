#' Runs TADA Matlab program from R and saves output files to hard drive
#'
#' @param tada_command Full input command to be run by tada (i.e. tada or gest function). Must be enclosed by quotation marks. See examples for various use cases.
#' @param target_dir Target directory in which to save output files and from which to read input files (directory must already exist)
#' @param matlab_path Optional: path to the Matlab installation on your computer (e.g. matlab_path="/Applications/MATLAB_R2021a.app/bin/"). This is a backup in case have_matlab() fails to find matlab's path on its own. Default is NULL.
#' @return Writes all output files to target_dir.
#' @examples
#' \dontrun{
#' # run gest on an input string to generate gestural/coupling specifications
#' # first gest argument is output filename, second argument is input string
#' # this generates TV<name>.O and PH<name>.O in target_dir
#' # note: gest can optionally take <language> and <prefix> arguments
#' run_tada("gest 'cat' 'cat'", target_dir="path/to/target/dir/", matlab_path="path/to/matlab")
#'
#' # run simulations on a pre-existing TV/PH file pair in target_dir
#' # saves output to target_dir
#' # e.g. this assumes that TVcat.O/PHcat.O exist (via gest) in target_dir
#' run_tada("tada 'cat'", target_dir="path/to/target/dir/")
#'
#' # run simulations on all TV/PH file pairs in target_dir
#' # saves simulations to target_dir
#' run_tada("tada 'all'", target_dir="path/to/target/dir/")
#'
#' # run gest & tada with orthographic input
#' # saves simulations to target_dir
#' # first argument is output filename, second argument is input string
#' run_tada("tada 'cat' 'cat'", target_dir="path/to/target/dir/")
#'
#' # run gest & tada with ARPABET input
#' # save simulations to target_dir
#' # first argument is output filename, second argument is input string
#' run_tada("tada 'cat' '(KAE1T)'", target_dir="path/to/target/dir/")
#' }
#' @note This function is written to be maximally flexible, so the input 'tada_command' is basically whatever you would type at the Matlab command line. This allows you to run either 'gest' or 'tada' or any other TADA functions that can be run from command line.
#' @note Note that the current way of defining target_dir is a bit hacky (i.e. getting/changing current directory multiple times). It works, but maybe not the best long term. Also consider ability to create target_dir if it doesn't already exist. This may help if you want to save each simulation to a different directory by looping over a list of words.
#' @export

run_tada <- function(tada_command, target_dir, matlab_path=NULL){
  if (dir.exists(target_dir)){
    options(matlab.path = matlab_path)
    original_dir <- getwd() # get current directory and save for later
    setwd(target_dir) # temporarily setwd() for where to save output files
    if (matlabr::have_matlab()){
      result <- matlabr::run_matlab_code(tada_command)
    } else{
        print("ERROR: Matlab path not found! Try running matlabr::get_matlab() to find the path.")
      }
    setwd(original_dir) # setwd back to original directory
  } else{
    print("ERROR: The target directory does not exist! Please either create the target directory or change the 'target_dir' argument and try again.")
  }
}
