#' #' API Wrapper for the Traveltime API - helper function
#' #'
#' #' traveltime_request calls the api and converts the response to an sf object
#' #'
#' #' @importFrom httr POST
#' #' @noRd
#'
#' traveltime_request <- function(appId = "yourAppId", apiKey = "yourApiKey", location = NULL, traveltime = NULL, type = NULL, departure = NULL){
#'
#'   #checks : missing parameters?
#'   if (length(location)!=2) stop("vector of longitude / latitude coordinates missing", call. = FALSE)
#'   if (is.null(traveltime)) stop("traveltime missing - set traveltime (in seconds)", call. = FALSE)
#'   if (is.null(apiKey)) stop("apiKey is missing.", call. = FALSE)
#'   if (is.null(appId)) stop("appId is missing.", call. = FALSE)
#'   if (is.null(type)) stop("transport mode not defined - please choose a mode of transport", call. = FALSE)
#'
#'
#'   url <- "http://api.traveltimeapp.com/v4/routes"
#'
#'   requestBody <- paste0('{
#'   "locations": [
#'                         {
#'                         "id": "London center",
#'                         "coords": {
#'                         "lat": 51.508930,
#'                         "lng": -0.131387
#'                         }
#'                         },
#'                         {
#'                         "id": "Hyde Park",
#'                         "coords": {
#'                         "lat": 51.508824,
#'                         "lng": -0.167093
#'                         }
#'                         },
#'                         {
#'                         "id": "ZSL London Zoo",
#'                         "coords": {
#'                         "lat": 51.536067,
#'                         "lng": -0.153596
#'                         }
#'                         }
#'                         ],
#'                         "departure_searches": [
#'                         {
#'                         "id": "departure search example",
#'                         "departure_location_id": "London center",
#'                         "arrival_location_ids": [
#'                         "Hyde Park",
#'                         "ZSL London Zoo"
#'                         ],
#'                         "transportation": {
#'                         "type": "driving"
#'                         },
#'                         "departure_time": "2018-11-13T08:00:00Z",
#'                         "properties": ["travel_time", "distance", "route"]
#'                         }
#'                         ],
#'                         "arrival_searches": [
#'                         {
#'                         "id": "arrival search example",
#'                         "departure_location_ids": [
#'                         "Hyde Park",
#'                         "ZSL London Zoo"
#'                         ],
#'                         "arrival_location_id": "London center",
#'                         "transportation": {
#'                         "type": "public_transport"
#'                         },
#'                         "arrival_time": "2018-11-13T08:00:00Z",
#'                         "properties": ["travel_time", "distance", "route", "fares"],
#'                         "range": {
#'                         "enabled": true,
#'                         "max_results": 1,
#'                         "width": 1800
#'                         }
#'                         }
#'                         ]
#' }')
#'
#'   response <- httr::POST(url = url,
#'                      httr::add_headers('Content-Type' = 'application/json'),
#'                      httr::add_headers('Accept' = 'application/json'),
#'                      httr::add_headers('X-Application-Id' = appId),
#'                      httr::add_headers('X-Api-Key' = apiKey),
#'                      body = requestBody,
#'                      encode = "json")
#'
#'
#'   if (httr::http_type(response) != "application/json") {
#'     stop("API did not return json", call. = FALSE)
#'   }
#'
#'   # extract content
#'   respo <-httr::content(response)
#'
#'   )
