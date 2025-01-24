#' Classification of olive tree water status from ZIM probes data
#'
#' @param model Indicate the model chosen for the classification of the Pp daily curves.
#' @param new_data Indicate the columns of a data frame with the variables obtained with the function "getpoints".
#' @return Tree water status (1, 2 or 3).
#' @import randomForest
#' @export
ZIM_status <- function(model = "rf1", new_data) {
  if (model == "rf1") {
    load("data/rf_inf2.RData")
    if (!all(names(new_data) %in% names(rf_inf2$forest$xlevels))) {
      stop("New data does not have the same features as the model.")
    }
    predictions = predict(rf_inf2, newdata = new_data)
    return(predictions)
  } else if (model == "rf2") {
    load("data/rf_st2.RData")
    if (!all(names(new_data) %in% names(rf$forest$xlevels))) {
      stop("New data does not have the same features as the model.")
    }
    predictions = predict(rf, newdata = new_data)
    return(predictions)
  } else if (model == "rf_pot") {
    load("data/rf_pot.RData")
    if (!all(names(new_data) %in% names(rf_pot$forest$xlevels))) {
      stop("New data does not have the same features as the model.")
    }
    predictions = predict(rf_pot, newdata = new_data)
    return(predictions)
  }
}
