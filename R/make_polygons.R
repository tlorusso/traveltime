#' helper function - make_polygons converts grouped points to polygons
#' @importFrom sf st_cast
#'
#' @noRd

make_polygons <- function(sf_points){

sf_points %>%
    dplyr::mutate(ID=dplyr::row_number()) %>%
    dplyr::group_by(group) %>%
    dplyr::arrange(ID) %>%
    dplyr::summarize(INT = dplyr::first(ID), do_union = FALSE) %>%
    sf::st_cast("POLYGON") %>%
    dplyr::select(-INT)

}


