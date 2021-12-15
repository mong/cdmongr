#' The application User-Interface
#' 
#' @param request Internal parameter for `{shiny}`. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {
  tagList(

    navbarPage(id = "cdmongr_app_id",

               title = "SKDE",
               
               shiny::tabPanel("Leddprotese",
                               shinyjs::useShinyjs(),
                               shinyalert::useShinyalert(),
                               h4("Kvalitetsindikatorer fra medisinske kvalitetsregistre innen muskel og skjelett"),
                               kvalind_UI(id="leddprotese_id")
               ),
               shiny::tabPanel("Hjerteinfarkt",
                               h4("Kvalitetsindikatorer fra medisinske kvalitetsregistre innen hjerteinfarkt"),
                               kvalind_UI(id="hjerte_id")
               ),
               shiny::tabPanel("Traumebehandling",
                               h4("Kvalitetsindikatorer fra medisinske kvalitetsregistre innen traume"),
                               kvalind_UI(id="traume_id")
               ),
               shiny::tabPanel("Diabetes",
                               h4("Kvalitetsindikatorer fra medisinske kvalitetsregistre innen diabetes"),
                               kvalind_UI(id="diabetes_id")
               ),
               shiny::tabPanel("Hjerneslag",
                               h4("Kvalitetsindikatorer fra medisinske kvalitetsregistre innen hjerneslag"),
                               kvalind_UI(id="hjerne_id")
               )
    )
  )
}
