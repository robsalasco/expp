setGeneric("DirichletPolygons", function(x, boundary, ...)   				standardGeneric("DirichletPolygons") )

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




















