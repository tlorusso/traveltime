#' API Wrapper for the Traveltime API
#'
#' \code{get_traveltime} is the main function of the traveltimeR package. It retrieves traveltime-isochrones from the traveltime platform, which supports several modes of transport in several countries and brings them into r as polygons stored in sf-objects.
#'
#'   get traveltime - isochrones for traveltimemaps from Traveltime API
#'
#' @param appId Traveltime-Plattform Application ID
#' @param apiKey Traveltime-Plattform API-Key
#' @param location vector of lat / long coordinates, example: c(47.233,8.234)
#' @param traveltime traveltime in seconds
#' @param type transportation mode
#' @param departure time of departure, format: "2018-08-05T08:00:00Z"
#' @importFrom jsonlite fromJSON
#' @importFrom httr POST
#' @importFrom sf st_as_sf
#' @importFrom purrr map_dfr
#' @importFrom dplyr "%>%"
#' @export
#' @rdname get_traveltime
#' @details To call the API via the package you need to get an api-key here \url{http://docs.traveltimeplatform.com/overview/getting-keys/}.
#'          If you're not using the API for commercial use users can get 10,000 free API queries a month.
#'
#' @return the results from the search
#' @family get_traveltime functions
#' @examples
#' traveltime30 <- get_traveltime(appId="yourAppID",
#' apiKey="yourApiKey",
#' location=c(47.378610,8.54000),
#' traveltime=1800,
#' type="public_transport",
#' departure="2018-10-05T08:00:00Z")
#' plot(traveltime30)
#'
#' @references \href{http://docs.traveltimeplatform.com/overview/introduction}{Traveltime Plattform API Docs}
#' @export

get_traveltime<- function(...){

traveltimelist <-traveltime_request(...)

splitlist <-traveltimelist %>%
  split(.$group)

polygonslist <- splitlist %>%
  purrr::map(~make_polygons(.))

do.call(rbind, polygonslist)

}
