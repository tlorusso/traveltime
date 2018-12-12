#' API Wrapper for the Traveltime API - helper function
#'
#' traveltime_request calls the api and converts the response to an sf object
#'
#' @importFrom httr POST
#' @noRd

map_request <- function(appId = "yourAppId", apiKey = "yourApiKey", location = NULL, traveltime = NULL, type = NULL, departure = NULL, arrival=NULL,holes=FALSE){

  #checks : missing parameters
  if (length(location)!=2) stop("vector of longitude / latitude coordinates missing", call. = FALSE)
  if (is.null(traveltime)) stop("traveltime missing - set traveltime (in seconds)", call. = FALSE)
  if (is.null(apiKey)) stop("apiKey is missing.", call. = FALSE)
  if (is.null(appId)) stop("appId is missing.", call. = FALSE)
  if (is.null(type)) stop("transport mode not defined - please choose a mode of transport", call. = FALSE)
  if (is.null(departure)&is.null(arrival)) stop("please set a departure- or arrival time", call. = FALSE)
  if (!is.null(departure)&!is.null(arrival)) stop("set departure OR arrival time only", call. = FALSE)

  url <- "http://api.traveltimeapp.com/v4/time-map"

  direction <- ifelse(!is.null(arrival),"arrival","departure")

  time <- ifelse(!is.null(arrival),arrival,departure)

# Default settings used in the online app:  https://app.traveltimeplatform.com/
  # `departure_searches[*].pt_change_delay` of 60[s]
  # a walking time `departure_searches[*].walking_time` of 25[minutes]
  # range enabled `departure_searches[*].range` with a width of 30 [minutes].

  requestBody <- paste0('{"',direction,'_searches" : [
                        {"id" : "request",
                        "coords": {"lat":', location[1], ', "lng":', location[2],' },
                        "transportation" : {"type" : "',type,'"} ,
                        "pt_change_delay": 60 ,
                        "walking_time" : 1500,
                        "range": {"enabled": true, "width": 1800 },
                        "travel_time" : ', traveltime, ',
                        "',direction,'_time" : "', time,'"
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

# if(isTRUE(holes)){

#  the same as shell only?
#
# holesdf <<- purrr::map(respo[1]$results[[1]]$shapes, "holes")%>%
#                 Filter(function(x) length(x) > 0, .) %>%
#                 purrr::map_dfr(purrr::flatten_df,.id="group")
#
# holesdf <<-sf::st_as_sf(x = flat,
#                coords = c("lng", "lat"),
#                crs = "+proj=longlat +datum=WGS84")
#
#
#  }


  if (ncol(flat)!=3) {
    stop("request did not deliver isochrone coordinates - please check appId / apiKey and / or if the coordinates lie in a supported country. Also, departure time must lie in the future.", call. = FALSE)
  }


  #convert to sf object
  sf::st_as_sf(x = flat,
                 coords = c("lng", "lat"),
                 crs = "+proj=longlat +datum=WGS84")

  # how to pass to pass holes to parent environement?
  # sf::st_as_sf(x = holes,
  #              coords = c("lng", "lat"),
  #              crs = "+proj=longlat +datum=WGS84")


}
