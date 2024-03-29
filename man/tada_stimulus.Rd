% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tada_stimulus.R
\name{tada_stimulus}
\alias{tada_stimulus}
\title{Create a TADA function argument to pass to Matlab}
\usage{
tada_stimulus(output_name, input_string = NULL, gest = FALSE)
}
\arguments{
\item{output_name}{Output filename. If input_string=NULL then this will also be used for the input_string argument.}

\item{input_string}{Optional input string. If NULL then 'output_name' will be used (default is NULL)}

\item{gest}{Logical. gest=FALSE builds a 'tada ...' argument, gest=TRUE builds a 'gest ...' argument (default is NULL)}
}
\value{
Character vector corresponding to a TADA tada/gest command
}
\description{
Convenience function for constructing TADA code that can be passed to run_tada(tada_command = ...). It creates arguments of the form "tada <output_file> <input_string>" or "gest <output_file> <input_string>" when gest=TRUE.
}
\examples{
\dontrun{
# creates the command "tada 'cat' 'cat'"
tada_stimulus("cat")
# creates the command "gest 'cat' 'cat'"
tada_stimulus("cat", gest=TRUE)
# create the command "tada 'cat' '(KAE1T)'"
tada_stimulus("cat", "(KAE1T)")
}
}
