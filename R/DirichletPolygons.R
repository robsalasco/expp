setGeneric("DirichletPolygons", function(x, boundary, ...)   				standardGeneric("DirichletPolygons") )


.DirichledPolygons <- function(x, ids = x@id) {
	# ID is a DirichletPolygons
            coords = coordinates(x)
            polys  =  tile.list(deldir(coords[,1], coords[,2]))
            polys  = lapply(polys, function(a) Polygon(rbind(cbind(a$x, a$y), cbind(a$x[1], a$y[1])))  )
            spdf = mapply(FUN = function(x, ID) SpatialPolygonsDataFrame(SpatialPolygons(list(Polygons(list(x), ID)), pO = ID ),
					data = data.frame(ID = ID, row.names = ID)), 
                    ID = ids, 
                    x = polys)
            do.call(rbind, spdf)	
}


setMethod("DirichletPolygons",  
          signature  = c(x = "SpatialPointsBreeding", boundary = "missing"), 
          definition = function(x, ...) {
            
            coords = coordinates(x)
            ids = x@id
			# ripras boundary
            rr = ripras(coords, shape = "convex", ...)
            rr = cbind(x = rr$bdry[[1]]$x, y = rr$bdry[[1]]$y)
            boundary =  SpatialPolygons(list( Polygons(list( Polygon(rbind(rr, rr[1, ] )) ) , 1) ) )
            proj4string(boundary) = proj4string(x)
            
            # tiles
			spdf = .DirichledPolygons(x)
			
            spdf = gIntersection(spdf, boundary, byid = TRUE, id = as.character(ids) )
            
            # SpatialPolygonsDataFrame
            dat = data.frame(ID = ids, row.names = ids)
            
            SpatialPolygonsDataFrame(spdf, dat)
            
          }
)


setMethod("DirichletPolygons",  
          signature  = c(x = "SpatialPointsBreeding", boundary = "SpatialPolygons"), 
          definition = function(x, boundary) {
            
 			spdf = .DirichledPolygons(x)		  
            
            SpatialPolygonsDataFrame(gIntersection(spdf, boundary, byid = TRUE, id = as.character(x@id) ), data = spdf@data)
            
	
            
          }
)


setMethod("DirichletPolygons",  
          signature  = c(x = "SpatialPointsBreeding", boundary = "integer"), 
          definition = function(x, boundary) {
            
		  
            
            spdf = SpatialPolygonsDataFrame(gIntersection(spdf, boundary, byid = TRUE, id = as.character(ids) ), data = spdf@data)
            
            spdf	
            
          }
)


















