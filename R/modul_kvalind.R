# Modul for indikatorer fra kvalitetsregistre cdmongr
#
# Kun til bruk i Shiny
# returner Modulfunksjoner

leddprotese_UI <- function(id){
  ns <- shiny::NS(id)
  fluidRow(
    column(6,
           uiOutput(outputId = ns("valgtInd")),
           selectInput(inputId = ns("plotType"), label = "Velg plott",
                       choices = c("Spagettiplott", "Abacusplott",
                                   "Panelplot"), multiple = F)
    ),
    column(6,
           selectInput(inputId = ns("velgHF"), label = "Velg helseforetak",
                       choices = c("shus1", "shus2",
                                   "shus3"), multiple = F)
    )
  )
}


leddprotese_server <- function(input, output, session, ind_info){
  
  ind_navn <- c("hoftebrudd_protdislokbrudd", 
                "hoftebrudd_stammefiks",
                "hoftebrudd_ventetid48",
                "leddprotese_veldok_kne",
                "leddprotese_veldokumentert_kopp")
  names(ind_navn) <- ind_info$title[match(paste0("cd_", ind_navn), ind_info$id)]

  output$valgtInd <- renderUI({
    ns <- session$ns
    if (!is.null(ind_navn)) {
      selectInput(inputId = ns("valgtInd_verdi"), label = "Velg indikator",
                  choices = ind_navn, multiple = FALSE)
    }
  })
}

hjerte_server <- function(input, output, session, ind_info){
  
  ind_navn <- "hjerteinfarkt_reper_stemi_tid"
  names(ind_navn) <- ind_info$title[match(paste0("cd_", ind_navn), ind_info$id)]
  
  output$valgtInd <- renderUI({
    ns <- session$ns
    if (!is.null(ind_navn)) {
      selectInput(inputId = ns("valgtInd_verdi"), label = "Velg indikator",
                  choices = ind_navn, multiple = FALSE)
    }
  })
}


traume_server <- function(input, output, session, ind_info){
  
  ind_navn <- c("traume_rontgen_bekken", "traume_rontgen_thorax")
  names(ind_navn) <- ind_info$title[match(paste0("cd_", ind_navn), ind_info$id)]
  
  output$valgtInd <- renderUI({
    ns <- session$ns
    if (!is.null(ind_navn)) {
      selectInput(inputId = ns("valgtInd_verdi"), label = "Velg indikator",
                  choices = ind_navn, multiple = FALSE)
    }
  })
}

diabetes_server <- function(input, output, session, ind_info){
  
  ind_navn <- c("diabetes_voksne_grad_pros_aarsk", "diabetes_voksne_hba1c_ge_75",
                "diabetes_voksne_hba1c_le_53")
  names(ind_navn) <- ind_info$title[match(paste0("cd_", ind_navn), ind_info$id)]
  
  output$valgtInd <- renderUI({
    ns <- session$ns
    if (!is.null(ind_navn)) {
      selectInput(inputId = ns("valgtInd_verdi"), label = "Velg indikator",
                  choices = ind_navn, multiple = FALSE)
    }
  })
}

hjerne_server <- function(input, output, session, ind_info){
  
  ind_navn <- c("hjerneslag_beh_tromb", "hjerneslag_rapport_3mnd")
  names(ind_navn) <- ind_info$title[match(paste0("cd_", ind_navn), ind_info$id)]
  
  output$valgtInd <- renderUI({
    ns <- session$ns
    if (!is.null(ind_navn)) {
      selectInput(inputId = ns("valgtInd_verdi"), label = "Velg indikator",
                  choices = ind_navn, multiple = FALSE)
    }
  })
}







