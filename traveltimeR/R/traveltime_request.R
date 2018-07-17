traveltime_request <- function(appId, apiKey, location, driveTime){
  
  
  
  url <- "http://api.traveltimeapp.com/v4/time-map"
  
  
  requestBody <- paste0('{ 
                        "departure_searches" : [ 
                        {"id" : "Zurich", 
                        "coords": {"lat":', location[1], ', "lng":', location[2],' }, 
                        "transportation" : {"type" : "public_transport"} ,
                        "travel_time" : ', driveTime, ',
                        "departure_time" : "2018-08-05T08:00:00Z"
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