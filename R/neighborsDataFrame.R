

neighborsDataFrame <- function(nb) {
	
	ids = data.frame(id_neigh = attributes(nb)$region.id, pk = 1:length(nb), stringsAsFactors = FALSE )
	
	f <- function(x, id) { 
				assign('x', x, envir=.GlobalEnv)
				assign('id', id, envir=.GlobalEnv)
				zz = merge(data.frame( pk = x), ids)
				zz$id = id
				zz }
	
	res = mapply(FUN = f , x = nb, id = attributes(nb)$region.id , SIMPLIFY = FALSE)
		
	res = do.call(rbind, res)	
	
	res$pk = NULL
	
	res[, c("id", "id_neigh")]

	}

#nb = n[[2]]
# plot(nb, coordinates(breedingDat) )
# plot(polygonsDat, add = T)
# plot(breedingDat, add = T)



		
higherNeighborsDataFrame <- function(nb, maxlag) {
	n = nblag(nb, maxlag = maxlag)
	
	
	n = n[sapply(n, function(x) !all ( unlist(x) == 0 ) )]
	
	new_maxlag = length(n)
	if(maxlag > new_maxlag)
		warning( paste('maxlag of ', maxlag, 'is exceeding the number of possible lags, reverting to', new_maxlag, 'lags.') )
		
	n = lapply(n, neighborsDataFrame)
	d = mapply(FUN = function(x, rank) cbind(x, rank), x = n, rank = 1:new_maxlag, SIMPLIFY = FALSE)
	d = do.call(rbind, d)
	d
	

}





















