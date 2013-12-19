
 


SpatialPointsBreeding <- function(data, 
                                  proj4string = CRS(as.character(NA)), 
                                  coords = ~ x + y, 
                                  breeding = ~ male + female, 
                                  id
							) {
	d = data
	row.names(d) = NULL
	d$k = 1:nrow(d)
	coordinates(d) <- coords
	proj4string(d) = proj4string
	
	ids = data[, id]
	
	m = as.character(breeding[[2]][2])
	f  = as.character(breeding[[2]][3])
	males = data[, m]
	females = data[, f]
	
	d@data[, m]  = NULL
	d@data[, f]  = NULL
	d@data[, id] = NULL


	
	new("SpatialPointsBreeding", d, id = ids, male = males, female= females)
}



if (!isGeneric("plot")) setGeneric("plot", function(x, y, ...) standardGeneric("plot"))

	
setMethod("plot", signature(x = "SpatialPointsBreeding", y = "missing"),
          function(x, pch = 20, axes = FALSE, add = FALSE, 
                   xlim = NULL, ylim = NULL, ..., cex = 1, col = "grey", lwd = 1, bg = 1, pair.cex = .6) {
            if (! add)
              plot(as(x, "Spatial"), axes = axes, xlim = xlim, ylim = ylim, ...)
            cc = coordinates(x)
            points(cc[,1], cc[,2], pch = pch, cex = cex, col = col, lwd = lwd, bg = bg)
            text(cc[,1], cc[,2], x@id, pos = 4, cex = cex)
            text(cc[,1], cc[,2], x@female, pos = 1,  cex =  pair.cex)
            text(cc[,1], cc[,2], x@male, pos = 3,  cex = pair.cex)
            
          })



	











