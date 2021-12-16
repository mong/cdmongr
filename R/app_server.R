#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {

  ind <- read.csv(system.file("app/www/indikatorer.csv", package = "cdmongr"))
  shus <- read.csv(system.file("app/www/sykehus.csv", package = "cdmongr"))
  hf <- read.csv(system.file("app/www/hf.csv", package = "cdmongr"))
  rhf <- read.csv(system.file("app/www/rhf.csv", package = "cdmongr"))
  shus <- merge(shus, hf,
                by.x = "hf_orgnr", by.y = "orgnr", all.x = T, suffixes = c("", "_hf")) %>%
    merge(rhf, by.x = "rhf_orgnr", by.y = "orgnr", all.x = T, suffixes = c("", "_rhf"))

  shus_valg <- shus$orgnr[shus$rhf_orgnr == 883658752]
  names(shus_valg) <- shus$short_name[match(shus_valg, shus$orgnr)]
  
  callModule(kvalind_server, "leddprotese_id", ind_info = ind,
             ind_navn = c("hoftebrudd_protdislokbrudd", "hoftebrudd_stammefiks",
                          "hoftebrudd_ventetid48", "leddprotese_veldok_kne",
                          "leddprotese_veldokumentert_kopp"), shus_valg = shus_valg)
  callModule(kvalind_server, "hjerte_id", ind_info = ind,
             ind_navn = "hjerteinfarkt_reper_stemi_tid", shus_valg = shus_valg)
  callModule(kvalind_server, "traume_id", ind_info = ind,
             ind_navn = c("traume_rontgen_bekken", "traume_rontgen_thorax"), shus_valg = shus_valg)
  callModule(kvalind_server, "diabetes_id", ind_info = ind,
             ind_navn = c( "diabetes_voksne_hba1c_le_53", "diabetes_voksne_hba1c_ge_75",
                           "diabetes_voksne_grad_pros_aarsk"), shus_valg = shus_valg)
  callModule(kvalind_server, "hjerne_id", ind_info = ind,
             ind_navn = c("hjerneslag_beh_tromb", "hjerneslag_rapport_3mnd"), shus_valg = shus_valg)

  callModule(revurdering_server, "revurdering_id")
  # Heartbeat every 5 seconds, to avoid app to die when user is inactive.
    output$heartbeat <- renderText({
      invalidateLater(5000)
      Sys.time()
    })
}
