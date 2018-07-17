#' API Wraper for the Traveltime API
#'
#' gets isochrones for traveltimemaps
#'
#' @param appId Traveltime-Plattform Application ID
#' @param apiKey Traveltime-Plattform API-Key
#' @param location vector of lat / long coordinates, example: c(47.233,8.234)
#' @driveTime traveltime (not implemented yet)
#' @transtype transportation mode (not implemented yet)
#' @importFrom jsonlite fromJSON
#' @importFrom httr POST
#' @importFrom sf st_as_sf
#' @importFrom purrr map_dfr
#' @export
#' @rdname get_traveltime
#'
#' @return the results from the search
#' @examples
#' \dontrun{
#' req <- traveltime_request(appId, apiKey,location,driveTime)
#' plot(poly)
#' }

get_traveltime<- function(...){

traveltimelist <-traveltime_request(...)


ttlist2 <-traveltimelist %>%
  split(.$group)

listnew <- ttlist2%>%
  map(~make_polygon(.))

do.call(rbind,listnew)


}
