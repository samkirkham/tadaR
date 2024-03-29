% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/unnest_tada.R
\name{unnest_tada}
\alias{unnest_tada}
\title{Converts nested tibble created by read_tada to unnested columns for each articulatory variable}
\usage{
unnest_tada(d)
}
\arguments{
\item{d}{tibble produced by read_tada function}
}
\value{
long format tibble with one column per tract variable
}
\description{
Unnests read_tada object into long format
Note that the audio signal is excluded from this object due to a different sampling rate (see getAudioLong function to unnest audio object)
see TADA manual for what each abbreviation corresponds to: https://sail.usc.edu/~lgoldste/ArtPhon/TADA\%20stuff/TADA_manual_v09.pdf
}
