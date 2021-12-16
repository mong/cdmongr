#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {
  tagList(
    shiny::tags$head(
      # Make it fully scale inside iframe
      shiny::tags$script(src = "www/iframeResizer.contentWindow.min.js")
    ),
    navbarPage(id = "cdmongr_app_id",
               title = "",
               # Heartbeat outside app, to avoid app to die after 60 sec on AWS
               shiny::tags$div(style = "position: absolute; top: -100px;",
                               shiny::textOutput("heartbeat")
               ),
               shiny::tabPanel("Leddprotese",
                               shinyjs::useShinyjs(),
                               shinyalert::useShinyalert(),
                               h4("Kvalitetsindikatorer fra medisinske kvalitetsregistre innen muskel og skjelett"),
                               kvalind_ui(id = "leddprotese_id")
               ),
               shiny::tabPanel("Hjerteinfarkt",
                               h4("Kvalitetsindikatorer fra medisinske kvalitetsregistre innen hjerteinfarkt"),
                               kvalind_ui(id = "hjerte_id")
               ),
               shiny::tabPanel("Traumebehandling",
                               h4("Kvalitetsindikatorer fra medisinske kvalitetsregistre innen traume"),
                               kvalind_ui(id = "traume_id")
               ),
               shiny::tabPanel("Diabetes",
                               h4("Kvalitetsindikatorer fra medisinske kvalitetsregistre innen diabetes"),
                               kvalind_ui(id = "diabetes_id")
               ),
               shiny::tabPanel("Hjerneslag",
                               h4("Kvalitetsindikatorer fra medisinske kvalitetsregistre innen hjerneslag"),
                               kvalind_ui(id = "hjerne_id")
               ),
               shiny::tabPanel("Revurdering",
                               h4("Tjenester med usikker helsegevinst"),
                               revurdering_ui(id = "revurdering_id")
                               ),
               shiny::tabPanel("Innleie",
                               h4("Innleie av helsepersonell")                               )
    )
  )
}
