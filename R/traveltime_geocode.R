#' Geocode addresses using the traveltime API
#'
#' TODO: enable vectors of addresses to be passed through directly, along with time limit
#' TODO: enable reverse geocoding
#' TODO: refine time limit
#'
#' @importFrom httr GET content
#' @importFrom sf st_read
#'
#' @param address A character vector of length one containing the address query.
#'
#' @inheritParams
#' @examples
#' \dontrun{
#' whiteHouse <- c("1600 Pennsylvania Avenue NW, Washington, DC, 20500, United States", "The White House")
#' # returns the same address
#' traveltime_geocode(whiteHouse[1])
#' traveltime_geocode(whitehouse[2])
#'
#' # loop over a list of addresses
#' lapply(whiteHouse, traveltime_geocode)
#'
#'
#' }
#' @export
traveltime_geocode <- function(appId = "yourAppId", apiKey = "yourApiKey", address){
  #req one row
  req <- httr::GET(url = "http://api.traveltimeapp.com/v4/geocoding/search",
      httr::add_headers("X-Application-Id"= tt_appid, "X-Api-Key"= tt_appkey),
    query = list(query=address, within_country="United States"))
  # return the json response as text
  return(httr::content(req))

}
