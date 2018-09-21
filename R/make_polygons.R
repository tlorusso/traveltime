#' API Wrapper for the Traveltime API - helper function
#'
#' make_polygons converts grouped points to polygons

make_polygons <- function(sf_points){

sf_points %>%
    mutate(ID=row_number()) %>%
    group_by(group) %>%
    arrange(ID) %>%
    summarize(INT = first(ID), do_union = FALSE) %>%
    st_cast("POLYGON")

}


