setGeneric("DirichletPolygons", function(x, boundary, ...)   standardGeneric("DirichletPolygons") )


setMethod("DirichletPolygons",  
          signature  = c(x = "SpatialPointsBreeding", boundary = "numeric"), 
          definition = function(x, boundary, width) {
            
		# boundary
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
		
		# polygons	
		cr = coordinates(x)
		pp = ppp(cr[, 1], cr[, 2], window = as(P, "owin") )
		dr = dirichlet( pp )
		drp = as(dr, "SpatialPolygons")
				
		SpatialPolygonsDataFrame(drp, data = x@data[, 'id', FALSE], match.ID = TRUE)	
		
          }
)

setMethod("DirichletPolygons",  
          signature  = c(x = "SpatialPointsBreeding", boundary = "SpatialPolygons"), 
          definition = function(x, boundary) {
            
			cr = coordinates(x)
			pp = ppp(cr[, 1], cr[, 2], window = as(boundary, "owin") )
			dr = dirichlet( pp )
			drp = as(dr, "SpatialPolygons")
						
			SpatialPolygonsDataFrame(drp, data = x@data[, 'id', FALSE], match.ID = TRUE)		  

          }
)


setMethod("DirichletPolygons",  
          signature  = c(x = "SpatialPointsBreeding", boundary = "missing"), 
          definition = function(x, ...) {
            
			cr = coordinates(x)
			pp = ppp(cr[, 1], cr[, 2], window = ripras(cr, shape = "convex", ...) )
			dr = dirichlet( pp )
			drp = as(dr, "SpatialPolygons")
					
			SpatialPolygonsDataFrame(drp, data = x@data[, 'id', FALSE], match.ID = TRUE)
			
		            
          }
)



