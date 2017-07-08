#' Class SpatialPointsBreeding.
#' Class \code{SpatialPointsBreeding}.
#' @name        SpatialPointsBreeding
#' @rdname      SpatialPointsBreeding
#' @exportClass SpatialPointsBreeding
setClass("SpatialPointsBreeding", representation(
	id    		= "numeric",
	male  		= "character", 
	female 		= "character"
	),
	
	contains  = "SpatialPointsDataFrame",

	validity = function(object)	{

		if (length(table(object@id)[table(object@id) > 1]) )
			stop("only one id per line is allowed.")
		if(	any(object@id < 1) )			
			stop("id < 1 not allowed.")
		
		return(TRUE)
		# TODO
			# polygynous males
			# multiple br. att.
		}, 
  
  prototype = list(id_boundary= FALSE)		
 )
 
#' Class eppMatrix
#' Class \code{eppMatrix}.
#' @name        eppMatrix
#' @rdname      eppMatrix
#' @exportClass eppMatrix
setClass("eppMatrix", representation(
	male   = "character", 
	female  = "character" 
	),

	validity = function(object)	{
	if( length( intersect(object@male, object@female) ) > 0 ) stop("the same id cannot be male and female in the same time .")
	if ( any( is.na(object@male) ) ) stop("NA values are not allowed.")
	if ( any( is.na(object@female) ) ) stop("NA values are not allowed.")

	return(TRUE)
	}
	)

#' Class epp
#' Class \code{epp}.
#' @name        epp
#' @rdname      epp
#' @exportClass epp
setClass("epp", representation(
	breedingDat     = "SpatialPointsBreeding", 
	polygonsDat    	= "SpatialPolygonsDataFrame", 
	eppDat      	= "eppMatrix", 
	maxlag 			= "numeric", 
	EPP				= "data.frame"
	),
	
	validity = function(object)	{
	   # TODO
		return(TRUE)
		}
 )

