#' API Wrapper for the Traveltime API
#'
#' \code{get_traveltime} is the main function of the traveltimeR package. It retrieves traveltime-isochrones from the traveltime platform, which supports several modes of transport in several countries and brings them into r as polygons stored in sf-objects.
#'
#'   get_traveltime - retrieve isochrones for traveltimemaps from Traveltime API
#'
#' @param appId Traveltime-Plattform Application ID
#' @param apiKey Traveltime-Plattform API-Key
#' @param location vector of lat / long coordinates, coordinate system WGS84 / espg 4326, example: c(47.233,8.234).
#' @param traveltime traveltime in seconds
#' @param type transportation mode
#' @param departure time of departure, date in extended ISO-8601 format (incl. timezone), example: "2018-08-05T08:00:00Z"
#' @param arrival time of arrival, date in extended ISO-8601 format (incl. timezone), example: "2018-08-05T08:00:00Z"
#' @importFrom sf st_as_sf
#' @importFrom purrr map_dfr
#' @importFrom dplyr bind_cols
#' @importFrom dplyr "%>%"
#' @importFrom dplyr mutate
#' @export
#' @rdname traveltime_map
#' @details To call the API via the package you need to get an api-key here \url{http://docs.traveltimeplatform.com/overview/getting-keys/}.
#'          If you're not using the API for commercial use users can get 10,000 free API queries a month. The following transport modes are supported (type):"cycling"", "cycling_ferry", "driving", "driving+train", "driving_ferry", "public_transport", "walking", "walking+coach", "walking_bus", "walking_ferry" or "walking_train".
#' @return the results from the search
#' @examples
#'  \donttest{
#' traveltime30 <- traveltime_map(appId="yourAppID",
#' apiKey="yourApiKey",
#' location=c(47.378610,8.54000),
#' traveltime=1800,
#' type="public_transport",
#' departure="2018-10-05T08:00:00+01:00")
#'
#' #plot the isochrones
#' plot(traveltime30)
#' }
#'
#' @references \href{http://docs.traveltimeplatform.com/overview/introduction}{Traveltime Plattform API Docs}
#' @export

traveltime_map <- function(appId = "yourAppId", apiKey = "yourApiKey", location = NULL, traveltime = NULL, type = NULL, departure = NULL,arrival=NULL){

traveltimelist <- map_request(appId=appId,apiKey=apiKey,location=location,traveltime=traveltime,type=type,departure=departure,arrival=arrival)

make_polygons(traveltimelist) %>%
  sf::st_combine() %>%
  sf::st_sf(geometry=.) %>%
  dplyr::mutate(lat=location[1],lng=location[2],traveltime=traveltime,type=type,departure=ifelse(!is.null(departure),departure,NA),arrival=ifelse(!is.null(arrival),departure,NA))


}
