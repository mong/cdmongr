# Modul for indikatorer fra kvalitetsregistre cdmongr
#
# Kun til bruk i Shiny
# returner Modulfunksjoner

kvalind_ui <- function(id) {
  ns <- shiny::NS(id)
  fluidRow(
    column(12,
           fluidRow(
             column(6,
                    uiOutput(outputId = ns("valgtInd")),
                    selectInput(inputId = ns("plotType"), label = "Velg plott",
                                choices = c("Tidstrend", "Abacusplott",
                                            "Panelplott"), multiple = F)
             ),
             column(6,
                    uiOutput(outputId = ns("valgtShus"))
             )
           ),
           # shiny::dataTableOutput(outputId = ns("showdata"))
           plotly::plotlyOutput(ns('plot'))
    )
  )
}

#' @importFrom rlang .data
kvalind_server <- function(input, output, session, ind_info, ind_navn, shus_valg) {
  ns <- session$ns
  names(ind_navn) <- ind_info$title[match(ind_navn, ind_info$id)]

  # extract data
  all_data <- NULL
  for (i in ind_navn) {
    registry <- strsplit(i, "_")[[1]][1]
    if (registry == "diabetes") {
      registry <- "diabetes_voksne"
    }
    ind_data <- cdmongr::get_data(registry = registry, indicator = i, selected_orgnr = shus_valg)
    if (is.null(all_data)) {
      all_data <- ind_data
    } else {
      all_data <- rbind(all_data, ind_data)
    }
  }

  output$valgtInd <- renderUI({
    if (!is.null(ind_navn)) {
      selectInput(inputId = ns("valgtInd_verdi"), label = "Velg indikator",
                  choices = ind_navn, multiple = FALSE)
    }
  })

  output$valgtShus <- renderUI({
    if (!is.null(shus_valg)) {
      selectInput(inputId = "valgtShus_verdi", label = "Velg sykehus",
                  choices = shus_valg, multiple = TRUE, selected = shus_valg)
    }
  })
  
  plotdata <- reactive({
    forbered_plot(kvaldata=all_data, indikator = input$valgtInd_verdi,
                  shus_valg=if (!is.null(input$valgtShus_verdi)) {input$valgtShus_verdi} else {shus_valg})
  })

  output$plot <- plotly::renderPlotly(
    plotdata() %>%
      plotly::highlight_key(~unit_name) %>%
      plotly::plot_ly(x=~year, y=~andel, color=~unit_name, type="scatter", mode="lines") %>%
      plotly::layout(xaxis=list(tickvals=~year,ticktext=~year)) %>%
      plotly::highlight(on = "plotly_hover")
  )

#
#   output$showdata <- shiny::renderDataTable(all_data %>%
#                                               dplyr::filter(.data[["ind_id"]] %in% input$valgtInd_verdi))
}
