
 
setClass("SpatialPointsBreeding", representation(
	id    = "integer", 
	male  = "character", 
	female = "character"
	),
	
	contains  = "SpatialPointsDataFrame",

	validity = function(object)	{

		if (length(table(object@id)[table(object@id) > 1]) )
			stop("only one id per line is allowed.")
		if(	any(object@id < 1) )			
			stop("id < 1 not allowed.")

		}
 )
#=====================================================================================================#


SpatialPointsBreeding <- function(data, proj4string = CRS(as.character(NA)), coords = ~ x + y, id = 'id', breeding = ~ male + female) {
	d = data
	d$k = 1:nrow(d)
	coordinates(d) <- coords
	proj4string(d) = proj4string
	
	ids = data[, id]
	
	m = as.character(breeding[[2]][2])
	f  = as.character(breeding[[2]][3])
	males = data[, m]
	females = data[, f]
	
	d@data[, m] = NULL
	d@data[, f] = NULL
	d@data[, id] = NULL
	
	
	new("SpatialPointsBreeding", d, id = ids, male = males, female= females)
}


#=====================================================================================================#


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


#=====================================================================================================#
	

setGeneric("DirichletPolygons", function(x, boundary, ...) 					standardGeneric("DirichletPolygons") )

setMethod("DirichletPolygons",  
	signature  = c(x = "SpatialPointsBreeding", boundary = "missing"), 
		definition = function(x, ...) {
		
	coords = coordinates(x)

	ids = x@id

	rr = ripras(coords, shape = "convex", ...)
	rr = cbind(x = rr$bdry[[1]]$x, y = rr$bdry[[1]]$y)
	boundary =  SpatialPolygons(list( Polygons(list( Polygon(rbind(rr, rr[1, ] )) ) , 1) ) )
	proj4string(boundary) = proj4string(x)
	
  # tiles
	polys  =  tile.list(deldir(coords[,1], coords[,2]))
	polys  = lapply(polys, function(a) list(Polygon(rbind(cbind(a$x, a$y), cbind(a$x[1], a$y[1]))))  )
	
  # SpatialPolygons
	spdf = mapply(FUN = function(x, ID) 
	  SpatialPolygons(list(Polygons(x, ID = ID)) ), ID = ids, x = polys)
  spdf = do.call(rbind, spdf)  
  spdf = gIntersection(spdf, boundary, byid = TRUE, id = as.character(ids) )
  
  # SpatialPolygonsDataFrame
  dat = data.frame(ID = ids, row.names = ids)

  SpatialPolygonsDataFrame(spdf, dat)

		}
	)



setMethod("DirichletPolygons",  
	signature  = c(x = "SpatialPointsBreeding", boundary = "SpatialPolygons"), 
		definition = function(x, boundary) {
		
	coords = coordinates(x)

	ids = x@id

	polys  =  tile.list(deldir(coords[,1], coords[,2]))
	polys  = lapply(polys, function(a) Polygon(rbind(cbind(a$x, a$y), cbind(a$x[1], a$y[1])))  )
	
	spdf = mapply(FUN = function(x, ID) SpatialPolygonsDataFrame(SpatialPolygons(list(Polygons(list(x), ID)), pO = ID ),data = data.frame(ID = ID, row.names = ID)), 
				  ID = ids, 
				  x = polys)
	spdf = do.call(rbind, spdf)			  

	spdf = SpatialPolygonsDataFrame(gIntersection(spdf, boundary, byid = TRUE, id = as.character(ids) ), data = spdf@data)
		
	spdf	
		
		}
	)


	
















