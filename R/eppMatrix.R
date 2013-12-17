
setClass("eppMatrix", representation(
   male   = "character", 
  female  = "character" 
),

validity = function(object)	{
  if( length( intersect(object@male, object@female) ) > 0 ) stop("the same id cannot be in the same time male and female.")
  if ( any( is.na(object@male) ) ) stop("NA values are not allowed.")
  if ( any( is.na(object@female) ) ) stop("NA values are not allowed.")
  
  return(TRUE)
}
)
 
eppMatrix <- function(data,  pairs = ~ male + female) {
	
	m = as.character(pairs[[2]][2])
	f  = as.character(pairs[[2]][3])
  
  new('eppMatrix', male = as.character(data[, m]), female = as.character(data[, f]) )
	
  }













