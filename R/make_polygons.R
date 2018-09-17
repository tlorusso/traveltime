make_polygons <- function(sf_points){

sfp %>%
    mutate(ID=row_number()) %>%
    group_by(group) %>%
    arrange(ID) %>%
    summarize(INT = first(ID), do_union = FALSE) %>%
    st_cast("POLYGON")

}


