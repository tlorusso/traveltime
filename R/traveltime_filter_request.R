#' #' API Wrapper for the Traveltime API - helper function
#' #'
#' #' traveltime_request calls the api and converts the response to an sf object
#' #'
#' #' @importFrom httr POST
#' #' @noRd
#'
# traveltime_filter_request <- function(appId = "yourAppId", apiKey = "yourApiKey", from = NULL, to = NULL , traveltime = NULL, type = NULL, departure = NULL){
#
#   #checks : missing parameters?
#   if (length(location)!=2) stop("vector of longitude / latitude coordinates missing", call. = FALSE)
#   if (is.null(traveltime)) stop("traveltime missing - set traveltime (in seconds)", call. = FALSE)
#   if (is.null(apiKey)) stop("apiKey is missing.", call. = FALSE)
#   if (is.null(appId)) stop("appId is missing.", call. = FALSE)
#   if (is.null(type)) stop("transport mode not defined - please choose a mode of transport", call. = FALSE)
#
#
 # url <- "http://api.traveltimeapp.com/v4/time-filter"
#
#
 # requestBody <- paste0('{
 #                        "locations": [
 #                        {
 #                        "id": "Zurich Mainstation",
 #                        "coords": {
 #                        "lat":   47.378610,
 #                        "lng": 8.54000
 #                        }
 #                        },
 #                        {
 #                        "id": "somewhere",
 #                        "coords": {
 #                        "lat": 47.378610,
 #                        "lng": 8.55000
 #                        }
 #                        }
 #                        ],
 #                        "departure_searches": [
 #                        {
 #                        "id": "forward search example",
 #                        "departure_location_id": "Zurich Mainstation",
 #                        "arrival_location_ids": [
 #                        "somewhere"
 #                        ],
 #                        "transportation": {
 #                        "type": "bus"
 #                        },
 #                        "departure_time": "2018-11-15T08:00:00Z",
 #                        "travel_time": 14400,
 #                        "properties": [
 #                        "travel_time"
 #                        ],
 #                        "range": {
 #                        "enabled": true,
 #                        "max_results": 3,
 #                        "width": 600
 #                        }
 #                        }
 #                        ],
 #                        "arrival_searches": [
 #                        {
 #                        "id": "backward search example",
 #                        "departure_location_ids": [
 #                        "Zurich Mainstation"
 #                        ],
 #                        "arrival_location_id": "somewhere",
 #                        "transportation": {
 #                        "type": "public_transport"
 #                        },
 #                        "arrival_time": "2018-11-15T08:00:00Z",
 #                        "travel_time": 1900,
 #                        "properties": [
 #                        "travel_time",
 #                        "distance",
 #                        "distance_breakdown"
 #                        ]
 #                        }
 #                        ]
 #                        }')
#
  # response2 <- httr::POST(url = url,
  #                    httr::add_headers('Content-Type' = 'application/json'),
  #                    httr::add_headers('Accept' = 'application/json'),
  #                    httr::add_headers('X-Application-Id' = appId),
  #                    httr::add_headers('X-Api-Key' = apiKey),
  #                    body = requestBody,
  #                    encode = "json")


#
#
#   if (httr::http_type(response) != "application/json") {
#     stop("API did not return json", call. = FALSE)

#
#   # extract content
  # respo2 <-httr::content(response2)
#
#   )

# }
