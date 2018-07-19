#' API Wraper for the Traveltime API
#'
#' gets isochrones for traveltimemaps
#'
#' @param appId Traveltime-Plattform Application ID
#' @param apiKey Traveltime-Plattform API-Key
#' @param location vector of lat / long coordinates, example: c(47.233,8.234)
#' @traveltime traveltime in seconds
#' @type transportation mode
#' @departure time of departure, format: "2018-08-05T08:00:00Z"
#' @importFrom jsonlite fromJSON
#' @importFrom httr POST
#' @importFrom sf st_as_sf
#' @importFrom purrr map_dfr
#' @export
#' @rdname get_traveltime
#'
#' @return the results from the search
#' @family get_traveltime functions
#' @examples
#' \dontrun{
#' req <- traveltime_request(appId, apiKey,location=c(47.378610,8.54000),traveltime=1800,departure="2018-08-05T08:00:00Z")
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
