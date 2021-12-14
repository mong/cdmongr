#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function( input, output, session ) {
  # Heartbeat every 5 seconds, to avoid app to die when user is inactive.
  output$clock <- shiny::renderText({
    shiny::invalidateLater(1)
    as.character(Sys.time())
  })
}
