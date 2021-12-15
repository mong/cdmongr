#' The application User-Interface
#' 
#' @param request Internal parameter for `{shiny}`. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {
  tagList(
    # fluidPage(
    #   h1("cdmongr"),
    #   p(paste0("cdmongr v", installed.packages()["cdmongr", 3])),
    #   shiny::textOutput("clock")
    # )
    
    navbarPage(id = "cdmongr_app_id",
               
               # title = div(a(includeHTML(system.file('www/logo.svg', package='rapbase'))),
               #             regTitle),
               # windowTitle = regTitle,
               # theme = "rap/bootstrap.css",
               title = "SKDE",
               
               shiny::tabPanel("Leddprotese",
                               shinyjs::useShinyjs(),
                               shinyalert::useShinyalert(),
                               h4("Kvalitetsindikatorer fra medisinske kvalitetsregistre innen muskel og skjelett"),
                               fluidRow(
                                 column(6,
                                        uiOutput(outputId = "valgtInd"),
                                        selectInput(inputId = "plotType", label = "Velg plott",
                                                    choices = c("Spagettiplott", "Abacusplott",
                                                                "Panelplot"), multiple = F)
                                 ),
                                 column(6,
                                        selectInput(inputId = "velgHF", label = "Velg helseforetak",
                                                    choices = c("shus1", "shus2",
                                                                "shus3"), multiple = F)
                                 )
                               )
               )
               
               
    )
  )
}
