% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/getpoints.R
\name{get_points}
\alias{get_points}
\title{Get the points for the models}
\usage{
get_points(Pp_ZIM)
}
\description{
This function extracts the parameters from the ZIM daily curves to be used in the classification models. The function was built to analyze data registered every 5 minutes.
@param Pp_ZIM Sequence of numbers provided by the ZIM probe in one day (from 00:00 to 23:59)
@return Eight parameters used as input variables for the random forest models available in this package.
@export
}
