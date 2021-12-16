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
                                choices = c("Spagettiplott", "Abacusplott",
                                            "Panelplott"), multiple = F)
             ),
             column(6,
                    uiOutput(outputId = ns("valgtShus"))
             )
           ),
           plotlyOutput('plot')
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
    ind_data <- get_data(registry = registry, indicator = i, selected_orgnr = shus_valg)
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
                  choices = shus_valg, multiple = TRUE)
    }
  })
  
  output$plot <- renderPlotly({
    aux <- forbered_plot(kvaldata=orto, indikator = input, 
                         shus_valg=shus_valg)
    plot1 <- aux %>% 
      highlight_key(~unit_name) %>%
      plot_ly(x=~year, y=~andel, color=~unit_name, type="scatter", mode="lines") %>%  
      highlight(on = "plotly_hover")
    })
  

  output$showdata <- shiny::renderDataTable(all_data %>%
                                            dplyr::filter(.data[["ind_id"]] %in% input$valgtInd_verdi))
}
