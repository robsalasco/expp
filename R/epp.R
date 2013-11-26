
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
  	
    # TODO: order in polygonsDat@data$ID should be the same as in breedingDat@id
    
		return(TRUE)
		}
 )
#=====================================================================================================#
# breedingDat = breedingDat[[1]]; polygonsDat = polygonsDat[[1]] ; eppPairs = e[[1]]; rank = 4

epp <- function(breedingDat, polygonsDat, eppPairs, rank = 3) { 

    
	#bricks
	if( missing(polygonsDat) )   polygonsDat = DirichletPolygons(breedingDat)
	nb  = poly2nb(polygonsDat, row.names = polygonsDat@data$ID)
	hnb = higherNeighborsDataFrame(nb, maxlag = rank)
	b   = data.frame(breedingDat@data, id = breedingDat@id, male = breedingDat@male, female = breedingDat@female)

    # build up epp set
    d = merge(hnb, b, by = "id") 
    d = merge(d, b, by.x = c('id_neigh', 'year_'), by.y = c('id', 'year_'),  all.x = TRUE, suffixes= c("_MALE","_FEMALE") )
	  d$k_S = NULL; d$k_N = NULL
    d$z = paste(d$male_MALE, d$female_FEMALE)    

    e = data.frame(z = paste(eppPairs$male, eppPairs$female), epp = 1)


    d = merge(d, e, by = "z", all.x = TRUE)
    d$z = NULL
    d[is.na(d$epp), "epp"] = 0
    
    # fix names
    names(d) [which(names(d) == "male_MALE")] = "male"
    names(d) [which(names(d) == "female_FEMALE")] = "female"
    d$male_FEMALE = NULL; d$female_MALE = NULL    
    d = d[, union(c("id", "id_neigh", "rank", "male", "female", "epp"), names(d)) ]
	  names(d) [which(names(d) == "id")] = "id_male"
	  names(d) [which(names(d) == "id_neigh")] = "id_female"
    
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
            p = table(x@EPP[,c('rank', 'epp')])[,2]
            plot(p, type = 'h', axes = FALSE, ylab ='No. of EPP events', ...)
            axis(1, at = 1:max(x@EPP$rank), labels = 1:max(x@EPP$rank))
            axis(2, at = 0:(max(p)), labels = 0:(max(p)))
            
          })

	
	
	
	
	





	
	
	
	
	
	
	




















