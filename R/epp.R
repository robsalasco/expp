
setClass("epp", representation(
	breedingDat     = "SpatialPointsBreeding", 
	polygonsDat    	= "SpatialPolygonsDataFrame", 
	eppPairs      	= "data.frame", 
	rank 			= "numeric", 
	EPP				= "data.frame"
	),
	
	validity = function(object)	{
  	# if (object@rank < 1)
  	#		stop("rank must be greater than 0.")	
  
	# if(! identical(object@polygonsDat@data[, 1], object@breedingDat@id))
    #  stop( dQuote("polygonsDat@data[, 1]"), " does not match ",  dQuote("breedingDat@id") )
   
	# if( ncol(object@EPP) != 2 ) 
	#  stop(dQuote("EPP"), "data.frame should have two columns only.")
   
	 # if( length(intersect(object@breedingDat@male, object@EPP[, 1])) < 1 )
	#    stop("no EP males found in breedingDat")
  	
	#   if( length(intersect(object@breedingDat@female, object@EPP[, 2])) < 1 )
  	#  stop("no EP males found in breedingDat")
  	
    
		return(TRUE)
		}
 )
#=====================================================================================================#


epp <- function(breedingDat, polygonsDat, eppPairs, rank = 3) { 

    
	  #bricks 
		if( missing(polygonsDat) )   polygonsDat = DirichletPolygons(breedingDat)
		nb  = poly2nb(polygonsDat)
		hnb = higherNeighborsDataFrame(nb, maxlag = rank)
		b   = data.frame(breedingDat@data, id = breedingDat@id, male = breedingDat@male, female = breedingDat@female)
    
    # build up epp set
    d = merge(hnb, b, by = "id") 
    d = merge(d, b, by.x = 'id_neigh', by.y = 'id',  all.x = TRUE, suffixes= c("_S","_N") )
	  d$k_S = NULL; d$k_N = NULL
    d$z = paste(d$male_S, d$female_N)    

    e = data.frame(z = paste(eppPairs$male, eppPairs$female), epp = 1)


    d = merge(d, e, by = "z", all.x = TRUE)
    d$z = NULL
    d[is.na(d$epp), "epp"] = 0
    
    # fix names
    names(d) [which(names(d) == "male_S")] = "male"
    names(d) [which(names(d) == "female_N")] = "female"
    d$male_N = NULL; d$female_S = NULL    
    d = d[, union(c("id_neigh", "id", "rank", "male", "female", "epp"), names(d)) ]
    

    # new
		new("epp", breedingDat = breedingDat, polygonsDat = polygonsDat, eppPairs = eppPairs, rank = rank, EPP = d)
	}

#=====================================================================================================#


setMethod("plot", signature(x = "epp", y = "missing"),
          function(x,y,...) {
            plot(x@polygonsDat, border = "grey")
            plot(x@breedingDat, add = TRUE)
            epp = subset(x@EPP, epp == 1,select= c("id_neigh" , "id") )
            apply(epp, 1, function(e) points(x@breedingDat[x@breedingDat@id%in%e, ], type = "l", col = 2))
                        
          })

#=====================================================================================================#

  if (!isGeneric("barplot")) {
    setGeneric("barplot", function(height,...)
      standardGeneric("barplot"))
   }  
    

setMethod("barplot", "epp",
          function(height,...) {
            plot(xtabs(subset(x@EPP, epp == 1,select= "rank" )), ...)
            
            
          })

	
	
	
	
	





	
	
	
	
	
	
	




















