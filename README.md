
# ZIMpackage

<!-- badges: start -->
https://img.shields.io/badge/license-LGPLv3-green
https://img.shields.io/badge/R%3E%3D-4.4.0-blue
<!-- badges: end -->

The ZIMpackage allows the use of the classification models obtained in the research paper (Fernandes et al., 2017) published in Computers and Electronics in Agriculture (https://doi.org/10.1016/j.compag.2017.09.005). 

These models allow the automatic classification of leaf-patch-clamp-pressure probes output variable (Pp) daily curves into three leaf water status: _state 1_ (low stress), _state 2_ (moderate stress) and _state 3_ (highly stressed) which was described by previous literature.

The package contains a function called `get_points()` which allow the pre-processing of the 5-minutes Pp data and extracts eight variables used as input into the random forest models.

The functions and the models present in this package were developed with the use of 5-minutes interval between measurements. However, it will probably work within a range of 1 to 10 minutes between measurements.

These variables are:
  - `slope_1`: the slope of the linear regression of the values between the maximum and minimum Pp;
  - `slope_2`: the slope of the linear regression of the Pp values between 16.15 GMT and the end of the day;
  - `max1`: the moment of the day when started the biggest fall of Pp value;
  - `pmax1`: the duration of the fall starting at max1;
  - `rat1`: the ratio between the beginning and the end of the fall of Pp values starting at max1 and lasting pmax1;
  - `max2`: the moment of the day when started the second biggest fall of Pp value;
  - `pmax2`: the duration of the fall starting at max2;
  - `rat2`: ratio between the beginning and the end of the fall on Pp values starting at max2 and lasting pmax2.

The function `ZIM_status()` requires the user to chose between the three models presented in the scientific article mentioned above:
  - model **"rf1"**: random forest model trained regarding the visual identification of curves from _states 1_, _2_ and _3_;
  - model **"rf2"**: random forest model trained regarding the identification of _state 2_ curves, which are usually misclassified even visually. This model was obtained with the use of stem water potential threshold values as described in the scientific paper mentioned above.
  - model **"rf_pot"***: random forest model trained regardless of the visual identification, but with the target result obtained by threshold values of stem water potential (<ins>SWP</ins>): _state 1_ - <ins>SWP</ins> > -1.2 MPa; _state 2_ - <ins>SWP</ins> from -1.2 until -1.7 MPa; _state 3_ - <ins>SWP</ins> < -1.7 MPa.

The model **rf2** is supposed to be used together with the model **rf1**, focusing on the daily curves classified as _state 2_.

## Installation

You can install the development version of ZIMpackage like so:

``` r
devtools::install.packages("rafadreux/ZIMpackage")
```

## Example

This is a basic example which shows you how to use the functions:

``` r
library(ZIMpackage)
my_points <- getpoints(x) # being x the values of Pp (output variable from the LPCP probes)

#the recommended use is to prepare the data into two collumns, one with the date (or DOY) and one with the Pp values (raw).
#this way, you can use functions such as aggregate or tapply to get the variables for many days.

pred <- ZIM_status(model = "rf1", new_data = my_points)

# similarly, the function ZIM_status can also be applied to many days, by using functions such as tapply and aggregate.
```

