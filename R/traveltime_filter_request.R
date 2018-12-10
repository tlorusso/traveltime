#' #' API Wrapper for the Traveltime API
#' #'
#' #' traveltime_filter calls the traveltime-filter API module to calculate traveltime between coordinates
#' #'
#' #' @importFrom httr POST
#' #' @noRd
#'
traveltime_filter <- function(appId = "yourAppId", apiKey = "yourApiKey", from = NULL, to = NULL , traveltime = NULL, type = NULL, departure = NULL){
#
#   #checks : missing parameters?
  if (length(location)<2) stop("vector of longitude / latitude coordinates missing", call. = FALSE)
#   if (is.null(traveltime)) stop("traveltime missing - set traveltime (in seconds)", call. = FALSE)
  if (is.null(apiKey)) stop("apiKey is missing.", call. = FALSE)
  if (is.null(appId)) stop("appId is missing.", call. = FALSE)
  if (is.null(type)) stop("transport mode not defined - please choose a mode of transport", call. = FALSE)


url <- "http://api.traveltimeapp.com/v4/time-filter"

#
#

#get length of destination list to assign ids
ids <- c(1:length(to))

# compose matching strings for request body: "destination_x"
dest_ids <-paste0("destination_",ids)

to_list <- purrr::map(ids,~paste0('
                      {
                        "id": "destination_',.,'",
                        "coords": {
                        "lat": ', to[[.]][1],',
                        "lng": ', to[[.]][2],'
                        }
                        }'))


locations_body <- paste0(to_list, collapse=', ' )

# as.character(unlist(to_list))
#
# as.character(to_list)
#
# to_list

# as.character(locations_body)

requestBody <-  paste0('{
                        "locations": [
                        {
                        "id": "origin",
                        "coords": {
                        "lat":', from[1],',
                        "lng":', from[2],'
                        }
                        },',
                        locations_body,'
                        ],
                        "departure_searches": [
                        {
                        "id": "r traveltime api wrapper",
                        "departure_location_id": "origin",
                        "arrival_location_ids": ["',
                        paste(dest_ids,collapse='","'),
                        '"],
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
                        ]
                        }')
#
filter_response <- httr::POST(url = url,
                     httr::add_headers('Content-Type' = 'application/json'),
                     httr::add_headers('Accept' = 'application/json'),
                     httr::add_headers('X-Application-Id' = appId),
                     httr::add_headers('X-Api-Key' = apiKey),
                     body = requestBody,
                     encode = "json")


#
#
 if (httr::http_type(filter_response) != "application/json") {

       stop("API did not return json", call. = FALSE)
 }



respo2 <- httr::content(filter_response)

number_of_destinations <- length(respo2$results[[1]]$locations)

response <- tibble::tibble(
  from = list(from),
  to = to,
  traveltime = c(1:number_of_destinations) %>% map_dbl(~respo2$results[[1]]$locations[[.]][2]$properties[[1]]$travel_time),
  type=type,
  departure=departure
)



return(response)



 }
