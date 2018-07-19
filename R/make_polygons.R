make_polygons <- function(sf_points){


sfp2 <- st_sfc(st_geometry(sf_points)) %>%
    st_cast("MULTIPOINT", ids = "group") %>%
    st_cast("LINESTRING",ids="group")

  st_sf(sfp2) %>%
    # mutate(geometry=sfp2) %>%
    mutate(id=sf_points$group[1])


}


