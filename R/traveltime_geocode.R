#' Geocode addresses using the traveltime API
#'
#' TODO: enable vectors of addresses to be passed through directly.
#' TODO: enable reverse geocoding
#' @importFrom httr GET content
#' @importFrom sf st_read
#'
#' @param address A character vector of length one containing the address query.
#'
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
traveltime_geocode <- function(address){

}
