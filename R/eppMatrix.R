
setClass("eppMatrix", representation(
	pairs = "matrix"
	),

	validity = function(object)	{
		stopifnot( nrow (object@pairs) != 2 )
		stopifnot( any( is.na(object@pairs) ) )
		}
  
 )