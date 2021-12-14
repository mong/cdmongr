#' The application User-Interface
#' 
#' @param request Internal parameter for `{shiny}`. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {
  tagList(
    fluidPage(
      h1("cdmongr"),
      shiny::textOutput("clock")
    )
  )
}
