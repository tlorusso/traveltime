#' API Wrapper for the Traveltime API
#'
#' gets isochrones for traveltimemaps from Traveltime API

make_polygons <- function(sf_points){

sf_points %>%
    mutate(ID=row_number()) %>%
    group_by(group) %>%
    arrange(ID) %>%
    summarize(INT = first(ID), do_union = FALSE) %>%
    st_cast("POLYGON")

}


