setGeneric("DirichletPolygons", function(x, boundary, ...)   standardGeneric("DirichletPolygons") )


.DirichletPolygons <- function(x, ids = x@id) {
	# x is a DirichletPolygons
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
          signature  = c(x = "SpatialPointsBreeding", boundary = "integer"), 
          definition = function(x, boundary, width) {
            
		z = data.frame(coordinates(x), id = x@id )

		bb = data.frame(id = boundary, o = 1:length(boundary) )
		bb = merge(bb, z, by = 'id')
		bb = bb[order(bb$o), ]
		bb = rbind(bb, bb[1, ])

		P = readWKT( paste( "POLYGON((", paste(paste(bb$x, bb$y), collapse = ','), "))" ) )

		if( missing(width) ) {
			# median distance between points
			z12 =  cbind(bb[-nrow(bb), c('x', 'y')], bb[-1, c('x', 'y')])
			width = mean(apply(z12, 1, function(x) spDists( as.matrix(t(x[1:2])), as.matrix(t(x[3:4])) ) ) )/2
			}
		
		P = gBuffer(P, width = width) 	
		
		spdf = .DirichletPolygons(x)		

		spdf = SpatialPolygonsDataFrame(gIntersection(spdf, P, byid = TRUE, id = as.character(x@id) ), data = spdf@data)

		spdf	
            
          }
)

setMethod("DirichletPolygons",  
          signature  = c(x = "SpatialPointsBreeding", boundary = "SpatialPolygons"), 
          definition = function(x, boundary) {
            
 			spdf = .DirichletPolygons(x)		  
            
            SpatialPolygonsDataFrame(gIntersection(spdf, boundary, byid = TRUE, id = as.character(x@id) ), data = spdf@data)
            
	
            
          }
)


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
			spdf = .DirichletPolygons(x)
			
            spdf = gIntersection(spdf, boundary, byid = TRUE, id = as.character(ids) )
            
            # SpatialPolygonsDataFrame
            dat = data.frame(ID = ids, row.names = ids)
            
            SpatialPolygonsDataFrame(spdf, dat)
            
          }
)



















