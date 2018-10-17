#' API Wrapper for the Traveltime API - helper function
#'
#' traveltime_request calls the api and converts the response to an sf object
#'
#' @importFrom httr POST
#' @noRd

traveltime_request <- function(appId = "yourAppId", apiKey = "yourApiKey", location = NULL, traveltime = NULL, type = NULL, departure = NULL){

  #checks : missing parameters?
  if (length(location)!=2) stop("vector of longitude / latitude coordinates missing", call. = FALSE)
  if (is.null(traveltime)) stop("traveltime missing - set traveltime (in seconds)", call. = FALSE)
  if (is.null(apiKey)) stop("apiKey is missing.", call. = FALSE)
  if (is.null(appId)) stop("appId is missing.", call. = FALSE)
  if (is.null(type)) stop("transport mode not defined - please choose a mode of transport", call. = FALSE)


  url <- "http://api.traveltimeapp.com/v4/time-map"


  requestBody <- paste0('{
                        "departure_searches" : [
                        {"id" : "request",
                        "coords": {"lat":', location[1], ', "lng":', location[2],' },
                        "transportation" : {"type" : "',type,'"} ,
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

  # extract content
  respo <-httr::content(response)


  # the shapes list contains all the polygons - convert to data.frame
flat <- c(1:length(respo$results[[1]]$shapes)) %>%
    purrr::map_dfr(., ~dplyr::bind_rows(respo$results[[1]]$shapes[[.x]]$shell),.id="group")


  if (ncol(flat)!=3) {
    stop("request did not deliver isochrone coordinates - please check appId / apiKey and / or if the coordinates lie in a supported country.", call. = FALSE)
  }

  #convert to sf object
  sf::st_as_sf(x = flat,
                 coords = c("lng", "lat"),
                 crs = "+proj=longlat +datum=WGS84")


}
