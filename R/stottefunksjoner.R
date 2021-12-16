#' Forberd data for grafisk fremstilling
#' 
#' @param kvaldata Original data
#' @param indikator Indicator
#' @param shus_valg Hospital
#'
#' @export
#' 
forbered_plot <- function(kvaldata, indikator, shus_valg) {
  plotdata <- kvaldata[kvaldata$orgnr %in% shus_valg & kvaldata$ind_id == indikator, ] %>% 
    dplyr::group_by(unit_name, year) %>% 
    dplyr::summarise(andel = sum(var)*100)
}