#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function( input, output, session ) {
  
  # orto <- cdmongr::get_ortopedi_data()
  ind <-read.csv(system.file("app/www/file162591f71.csv", package = "cdmongr"))
  orto_ind <- c("hoftebrudd_protdislokbrudd", 
                "hoftebrudd_stammefiks",
                "hoftebrudd_ventetid48",
                "leddprotese_veldok_kne",
                "leddprotese_veldokumentert_kopp")
  
  
  names(orto_ind) <- ind$title[match(paste0("cd_", orto_ind), ind$id)]
  
  output$valgtInd <- renderUI({
    # ns <- session$ns
    if (!is.null(orto_ind)) {
      selectInput(inputId = "valgtInd_verdi", label = "Velg indikator",
                  choices = orto_ind, multiple = FALSE)
    }
  })
  
  
  # Heartbeat every 5 seconds, to avoid app to die when user is inactive.
  output$clock <- shiny::renderText({
    shiny::invalidateLater(1)
    as.character(Sys.time())
  })
}
