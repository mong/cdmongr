library(magrittr)

get_data <- function(registry, indicator, api = "https://prod-mong-api.skde.org/data", query = "indicators?context=caregiver&type=ind") {
  # Getting data

  ind_data <- jsonlite::fromJSON(paste(api, registry, query, sep = "/")) %>%
    dplyr::filter(ind_id == indicator)

  return(ind_data)
}

get_ortopedi_data <- function() {
  ind_1 <- get_data(registry = "hoftebrudd", indicator = "hoftebrudd_protdislokbrudd")
  ind_2 <- get_data(registry = "hoftebrudd", indicator = "hoftebrudd_stammefiks")
  ind_3 <- get_data(registry = "hoftebrudd", indicator = "hoftebrudd_ventetid48")
  ind_4 <- get_data(registry = "leddprotese", indicator = "leddprotese_veldok_kne")
  ind_5 <- get_data(registry = "leddprotese", indicator = "leddprotese_veldokumentert_kopp")
  return(rbind(ind_1, ind_2, ind_3, ind_4, ind_5))  
}

get_diabetes_data <- function() {
  ind_1 <- get_data(registry = "diabetes", indicator = "diabetes_voksne_hba1c_ge_75")
  ind_2 <- get_data(registry = "diabetes", indicator = "diabetes_voksne_hba1c_le_53")
  return(rbind(ind_1, ind_2))
}

get_hjerneslag_data <- function() {
  ind_1 <- get_data(registry = "hjerneslag", indicator = "hjerneslag_beh_tromb")
  ind_2 <- get_data(registry = "hjerneslag", indicator = "hjerneslag_rapport_3mnd")
  return(rbind(ind_1, ind_2))
}

get_hjerteinfarkt_data <- function() {
  ind_1 <- get_data(registry = "hjerteinfarkt", indicator = "hjerteinfarkt_reper_stemi_tid")
  return(ind_1)
}

get_traume_data <- function() {
  ind_1 <- get_data(registry = "traume", indicator = "traume_rontgen_bekken")
  ind_2 <- get_data(registry = "traume", indicator = "traume_rontgen_thorax")
  return(rbind(ind_1, ind_2))
}
