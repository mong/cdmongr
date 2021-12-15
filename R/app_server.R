#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function( input, output, session ) {
  
  # orto <- cdmongr::get_ortopedi_data()
  ind <- read.csv(system.file("app/www/file162591f71.csv", package = "cdmongr"))

  callModule(leddprotese_server, "leddprotese_id", ind_info=ind)
  callModule(hjerte_server, "hjerte_id", ind_info=ind)
  callModule(traume_server, "traume_id", ind_info=ind)
  callModule(diabetes_server, "diabetes_id", ind_info=ind)
  callModule(hjerne_server, "hjerne_id", ind_info=ind)
  
}
