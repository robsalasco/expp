
#' Convert a \code{data.frame} to an eppMatrix object.
#' 
#' Converts a \code{data.frame} to a eppMatrix object using a
#' \code{~male+female} formula.
#' 
#' 
#' @aliases eppMatrix eppMatrix-class
#' @param data a \code{data.frame}
#' @param pairs a formula indicating the extra-pair male and the extra-pair female in that order.
#' @return An object of class \code{eppMatrix} with two slots.
#' @section Slots: \describe{ 
#' \item{list("male")}{Object of class \code{"character"}: extra-pair male ID }
#' \item{:}{Object of class \code{"character"}: extra-pair male ID } 
#' \item{list("female")}{Object of class \code{"character"}:extra-pair female ID}
#' \item{:}{Object of class\code{"character"}:extra-pair female ID} }
#' @seealso \code{\link[expp]{epp}}
#' @keywords spatial
#' @examples
#' 
#' eppPairs = data.frame(male = c("m1", "m2", "m1"), female=c("f3", "f1", "f2") )
#' e = eppMatrix(eppPairs,  pairs = ~ male + female)
#' class(e)
#' showClass("eppMatrix")
#' 
#' data(bluetit_breeding)
#' data(bluetit_epp)
#' b = bluetit_breeding[bluetit_breeding$year_ == 2010, ]
#' eppPairs = bluetit_epp[bluetit_epp$year_ == 2010, ]
#' 
#' breedingDat  = SpatialPointsBreeding(b, id = 'id', coords = ~ x + y, breeding = ~ male + female)
#' eppDat = eppMatrix(eppPairs, pairs = ~ male + female)
#' 
#' plot(breedingDat, eppDat)
#' 
#' 
#' 
#' @export eppMatrix
eppMatrix <- function(data,  pairs = ~ male + female) {
	
	m = as.character(pairs[[2]][2])
	f  = as.character(pairs[[2]][3])
  
  # TODO: remove repeated lines, warn
  
  new('eppMatrix', male = as.character(data[, m]), female = as.character(data[, f]) )
	
  }













