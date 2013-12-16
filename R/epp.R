
setClass("epp", representation(
	breedingDat     = "SpatialPointsBreeding", 
	polygonsDat    	= "SpatialPolygonsDataFrame", 
	eppPairs      	= "data.frame", 
	rank 			= "numeric", 
	EPP				= "data.frame"
	),
	
	validity = function(object)	{
  	   
		return(TRUE)
		}
 )
#=====================================================================================================#

epp <- function(breedingDat, polygonsDat, eppPairs, rank = 3) { 

    # validity
    if(! identical(polygonsDat@data[, 1], breedingDat@id))
      stop( "the 1st column of ", dQuote("polygonsDat"), " should be identical with ",  dQuote("breedingDat"), " id." )
    
        
    if( length(intersect(breedingDat@male, eppPairs[, 1])) < 1 )
      stop("no extra-pair males found in breedingDat.")
    
    if( length(intersect(breedingDat@female, eppPairs[, 2])) < 1 )
       stop("no extra-pair females found in breedingDat.")
    
    
  	# bricks
  	if( missing(polygonsDat) )   polygonsDat = DirichletPolygons(breedingDat)
  	nb  = poly2nb(polygonsDat, row.names = polygonsDat@data$ID)
  	hnb = higherNeighborsDataFrame(nb, maxlag = rank)
  	b   = data.frame(breedingDat@data, id = breedingDat@id, male = breedingDat@male, female = breedingDat@female)

    # build up epp set
    d = merge(hnb, b, by = "id") 
    d = merge(d, b, by.x = 'id_neigh', by.y = 'id',  all.x = TRUE, suffixes= c("_MALE","_FEMALE") )
    d$k_MALE = NULL; d$k_FEMALE = NULL
    d$z = paste(d$male_MALE, d$female_FEMALE)    
    
    e = data.frame(z = paste(eppPairs$male, eppPairs$female), epp = 1)
    
    
    d = merge(d, e, by = "z", all.x = TRUE)
    d$z = NULL
    d[is.na(d$epp), "epp"] = 0
    
    # fix names
    names(d) [which(names(d) == "male_MALE")] = "male"
    names(d) [which(names(d) == "female_FEMALE")] = "female"
    d$male_FEMALE = NULL; d$female_MALE = NULL    
	
	names(d) [which(names(d) == "id")] = "id_MALE"
	names(d) [which(names(d) == "id_neigh")] = "id_FEMALE"
	
    d = d[, union(c("id_FEMALE", "id_MALE", "rank", "male", "female", "epp"), names(d)) ]
    
	
    # new
	new("epp", breedingDat = breedingDat, polygonsDat = polygonsDat, eppPairs = eppPairs, rank = rank, EPP = d)
	
	
	
	
	}

#=====================================================================================================#


setMethod("plot", signature(x = "epp", y = "missing"),
          function(x,y,...) {
            plot(x@polygonsDat, border = "grey")
            plot(x@breedingDat, add = TRUE)
            epp = subset(x@EPP, epp == 1,select= c("id_FEMALE" , "id_MALE") )
            apply(epp, 1, function(e) points(x@breedingDat[x@breedingDat@id%in%e, ], type = "l", col = 2))
            
          })

#=====================================================================================================#

  if (!isGeneric("barplot")) {
    setGeneric("barplot", function(height,...)
      standardGeneric("barplot"))
   }  
    

setMethod("barplot", signature(height = "epp"),
          function(height, relativeValues = FALSE, ...) {
            
            if(relativeValues == FALSE) {
                p = table(height@EPP[,c('rank', 'epp')])[,2]
                plot(p, type = 'h', axes = FALSE, ylab ='No. of EPP events', xlab = 'Distance', ...)
                axis(1, at = 1:max(height@EPP$rank), labels = 1:max(height@EPP$rank))
                axis(2, at = 0:(max(p)), labels = 0:(max(p)))
              }
            
            if(relativeValues == TRUE) {
                p = table(height@EPP[,c('rank', 'epp')])
                p[,1] = p[,1]+p[,2]
                p = apply(p, MARGIN = 2, FUN = function(x) x/sum(x))
                plot(p[,2], type = 'h', axes = FALSE, ylab ='', xlab = '', ...)
                par(new = TRUE)
                plot(p[,1], type = 'l', axes = FALSE, ylab ='Proportion of EPP events', xlab = 'Distance', lty = 2, ...)
                axis(1, at = 1:max(height@EPP$rank), labels = 1:max(height@EPP$rank))
                axis(2, labels = (0:10)/10, at = (0:10)/10)  
            }
            
          })

	
	
	
	
	





	
	
	
	
	
	
	




















