# Modul for indikatorer fra kvalitetsregistre cdmongr
#
# Kun til bruk i Shiny
# returner Modulfunksjoner

kvalind_UI <- function(id){
  ns <- shiny::NS(id)
  fluidRow(
    column(12,
           fluidRow(
             column(6,
                    uiOutput(outputId = ns("valgtInd")),
                    selectInput(inputId = ns("plotType"), label = "Velg plott",
                                choices = c("Spagettiplott", "Abacusplott",
                                            "Panelplott"), multiple = F)
             ),
             column(6,
                    uiOutput(outputId = ns("valgtShus"))
             )
           ),
           plotOutput(ns("plot"))
    )
  )
}

kvalind_server <- function(input, output, session, ind_info, ind_navn, shus_valg){
  ns <- session$ns
  names(ind_navn) <- ind_info$title[match(paste0("cd_", ind_navn), ind_info$id)]
  
  output$valgtInd <- renderUI({
    if (!is.null(ind_navn)) {
      selectInput(inputId = ns("valgtInd_verdi"), label = "Velg indikator",
                  choices = ind_navn, multiple = FALSE)
    }
  })
  
  output$valgtShus <- renderUI({
    if (!is.null(shus_valg)) {
      selectInput(inputId = "valgtShus_verdi", label = "Velg sykehus",
                  choices = shus_valg, multiple = TRUE)
    }
  })
}







