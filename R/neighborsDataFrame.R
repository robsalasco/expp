
neighborsDataFrame <- function(nb) {
	
	ids = data.frame(id_neigh = attributes(nb)$region.id, pk = 1:length(nb), stringsAsFactors = FALSE )
	
	f <- function(x, id) { 
				zz = merge(data.frame( pk = x), ids)
				zz$id = id
				zz }
	
	res = mapply(FUN = f , x = nb, id = attributes(nb)$region.id , SIMPLIFY = FALSE)
		
	res = do.call(rbind, res)	
	
	res$pk = NULL
	
	res[, c("id", "id_neigh")]

	}

		
higherNeighborsDataFrame <- function(nb, maxlag) {
	
	n = nblag(nb, maxlag = maxlag)
	
	names(n) = 1:maxlag
	n = n[sapply(n, function(x) !all ( unlist(x) == 0 ) )]
	
	new_maxlag = length(n)
	if(maxlag > new_maxlag)
		warning( paste('maxlag of ', maxlag, 'is exceeding the number of possible lags, reverting to', new_maxlag, 'lags.') )

	#remove 0-length neighbors
	n = lapply(n, function(g) subset( g, card(g) > 0 ) )
	
	n = lapply(n, function(a) neighborsDataFrame(a)  )
	
	d = mapply(FUN = function(x, rank) cbind(x, rank), x = n, rank = 1:new_maxlag, SIMPLIFY = FALSE)
	d = do.call(rbind, d)
	d
	

}





















