#' API Wrapper for the Traveltime API - helper function
#'
#' traveltime_request calls the api and converts the response to an sf object

traveltime_request <- function(appId, apiKey, location, traveltime, type, departure){

  url <- "http://api.traveltimeapp.com/v4/time-map"


  requestBody <- paste0('{
                        "departure_searches" : [
                        {"id" : "request",
                        "coords": {"lat":', location[1], ', "lng":', location[2],' },
                        "transportation" : {"type" : ',type,'} ,
                        "travel_time" : ', traveltime, ',
                        "departure_time" : "', departure,'"
                        }
                        ] }')

  response <- httr::POST(url = url,
                     httr::add_headers('Content-Type' = 'application/json'),
                     httr::add_headers('Accept' = 'application/json'),
                     httr::add_headers('X-Application-Id' = appId),
                     httr::add_headers('X-Api-Key' = apiKey),
                     body = requestBody,
                     encode = "json")


  if (httr::http_type(response) != "application/json") {
    stop("API did not return json", call. = FALSE)
  }

  res2 <- jsonlite::fromJSON(as.character(response))

  # the shapes list contains all the polygons - convert to data.frame
  flat <- res2$results$shapes[[1]]$shell %>%
    purrr::map_dfr(bind_cols,.id="group")

  if (ncol(flat)!=3) {
    stop("request did not deliver isochrone coordinates - please check appId / apiKey and if the coordinates lie in a supported country.", call. = FALSE)
  }

  #convert to sf
  sf::st_as_sf(x = flat,
                 coords = c("lng", "lat"),
                crs = "+proj=longlat +datum=WGS84")


}
