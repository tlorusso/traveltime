traveltime_request <- function(appId, apiKey, location, traveltime, type="public_transport", departure){devtools::document()

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


  res2 <- jsonlite::fromJSON(as.character(response))

  if(res2$errorcode==16) stop(paste0(res2$description))

  # the shapes list contains all the polygons
  flat <- res2$results$shapes[[1]]$shell %>%
    purrr::map_dfr(bind_cols,.id="group")

   #keine names, daher suboptima
  # do.call(rbind,res2$results$shapes[[1]]$shell)
  # Reduce(rbind, res2$results$shapes[[1]]$shell)

  sf::st_as_sf(x = flat,
                      coords = c("lng", "lat"),
                      crs = "+proj=longlat +datum=WGS84")


}
