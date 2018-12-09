#' #' API Wrapper for the Traveltime API - helper function
#' #'
#' #' traveltime_request calls the api and converts the response to an sf object
#' #'
#' #' @importFrom httr POST
#' #' @noRd
#'
filter_request <- function(appId = "yourAppId", apiKey = "yourApiKey", from = NULL, to = NULL , traveltime = NULL, type = NULL, departure = NULL){
#
#   #checks : missing parameters?
#   if (length(location)!=2) stop("vector of longitude / latitude coordinates missing", call. = FALSE)
#   if (is.null(traveltime)) stop("traveltime missing - set traveltime (in seconds)", call. = FALSE)
#   if (is.null(apiKey)) stop("apiKey is missing.", call. = FALSE)
#   if (is.null(appId)) stop("appId is missing.", call. = FALSE)
#   if (is.null(type)) stop("transport mode not defined - please choose a mode of transport", call. = FALSE)
#
#
url <- "http://api.traveltimeapp.com/v4/time-filter"
#
#

#
#
# locations <-list(c(47.378610,8.54000),c(47.378610,8.54000))
#
#', .[1],',


ids <-paste0("destination",c(1:length(to)))

to_list <<- purrr::map2(to,ids,~paste0('
                      {
                        "id": "',ids,'",
                        "coords": {
                        "lat": ', .[1],',
                        "lng": ', .[2],'
                        }
                        }'))

locations_body <-paste(to_list, collapse=', ' )


requestBody <<-  paste0('{
                        "locations": [
                        {
                        "id": "destination",
                        "coords": {
                        "lat":', from[1],',
                        "lng":', from[2],'
                        }
                        },',
                        locations_body,'
                        ],
                        "departure_searches": [
                        {
                        "id": "forward search example",
                        "departure_location_id": "origin",
                        "arrival_location_ids": [',
                        paste(ids,collapse='", "'),
                        '],
                        "transportation": {
                        "type": "bus"
                        },
                        "departure_time": "2018-11-15T08:00:00Z",
                        "travel_time": 14400,
                        "properties": [
                        "travel_time"
                        ],
                        "range": {
                        "enabled": true,
                        "max_results": 3,
                        "width": 600
                        }
                        }
                        ],
                        "arrival_searches": [
                        {
                        "id": "backward search example",
                        "departure_location_id": [
                        "destination"
                        ],
                        "arrival_location_ids":',paste(ids,collapse='", "'),',
                        "transportation": {
                        "type": "public_transport"
                        },
                        "arrival_time": "2018-11-15T08:00:00Z",
                        "travel_time": 1900,
                        "properties": [
                        "travel_time",
                        "distance",
                        "distance_breakdown"
                        ]
                        }
                        ]
                        }')
#
response_filter <- httr::POST(url = url,
                     httr::add_headers('Content-Type' = 'application/json'),
                     httr::add_headers('Accept' = 'application/json'),
                     httr::add_headers('X-Application-Id' = appId),
                     httr::add_headers('X-Api-Key' = apiKey),
                     body = requestBody,
                     encode = "json")


#
#
 # if (httr::http_type(response) != "application/json") {
 #
 #       stop("API did not return json", call. = FALSE)
 # }
#
#   # extract content
  # respo2 <-httr::content(response2)
#

   # )
 }
