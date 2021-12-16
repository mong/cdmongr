# Modul for revurderingsfane
#
# Kun til bruk i Shiny
# returner Modulfunksjoner

revurdering_ui <- function(id) {
  ns <- shiny::NS(id)
  fluidRow(
    column(12,
      fluidRow(
        column(6,
          uiOutput(outputId = ns("valgtInd")),
          selectInput(inputId = ns("plotType"), label = "Velg plott",
                      choices = c("Panelplot", "Abacusplott",
                                  "Spagettiplott"),
                      multiple = F
                      )
          ),
        column(6,
          uiOutput(outputId = ns("valgtShus"))
          )
        ),
      shiny::uiOutput(outputId = ns("figure"))
      )
    )
  }

revurdering_server <- function(input, output, session) {
  ns <- session$ns

  output$valgtInd <- renderUI({
    selectInput(inputId = ns("valgtInd_verdi"), label = "Velg indikator",
                choices = c("Utvikling over tid for helseforetak",
                            "utvikling over tid for sykehus"),
                multiple = FALSE)
  })

  output$valgtShus <- renderUI({
    selectInput(inputId = "valgtShus_verdi", label = "Velg helseforetak",
                choices = c("Finnmark", "UNN", "Nordland", "Helgeland"),
                multiple = TRUE)
  })

  output$figure <- shiny::renderUI({
    shiny::HTML("<img src='www/panel.png' alt='Panel plot' width='100%'>")
  })
}
