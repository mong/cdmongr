library(magrittr)

#' @export
get_data <- function(registry, indicator, selected_orgnr, api = "https://prod-mong-api.skde.org/data", query = "indicators?context=caregiver&type=ind") {
  # Getting data
  ind_data <- jsonlite::fromJSON(paste(api, registry, query, sep = "/")) %>%
    dplyr::filter(ind_id == indicator) %>%
    dplyr::filter(orgnr %in% selected_orgnr | unit_level %in% c("rhf", "rhf"))

  return(ind_data)
}
