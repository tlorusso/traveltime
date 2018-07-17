#' API Wraper for the Traveltime API
#'
#' gets isochrones for traveltimemaps
#'
#' @param method2order method to order colors (\code{"hsv"} or \code{"cluster"})
#' @param cex character expansion for the text
#' @param mar margin paramaters; vector of length 4 (see \code{\link[graphics]{par}})
#'
#' @return None
#'
#' @author Karl W Broman, \email{kbroman@@biostat.wisc.edu}
#' @references \url{http://en.wikipedia.org/wiki/List_of_Crayola_crayon_colors}
#' @seealso \code{\link{brocolors}}
#' @keywords hplot
#'
#' @examples
#'
#' @export
#' @importFrom grDevices rgb2hsv
#' @importFrom graphics par plot rect text
#'


get_traveltime<- function(...){
  
traveltimelist <-traveltime_request(...)


ttlist2 <-traveltimelist %>% 
  split(.$group) 

listnew <- ttlist2%>% 
  map(~make_polygon(.)) 

do.call(rbind,listnew)

  
}