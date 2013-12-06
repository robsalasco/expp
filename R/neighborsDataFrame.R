

neighborsDataFrame <- function(nb) {

	ids = data.frame(id_neigh = attributes(nb)$region.id, pk = 1:length(nb), stringsAsFactors = FALSE )
	res = mapply(FUN = function(x, id) { 
		zz = merge(data.frame( pk = x), ids)
		zz$id = id
		zz } , x = nb , id = attributes(nb)$region.id   , SIMPLIFY = FALSE)
		
	res = do.call(rbind, res)	
	
	res$pk = NULL
	
	res[, c("id", "id_neigh")]

	}
			
higherNeighborsDataFrame <- function(nb, maxlag) {
	n = nblag(nb, maxlag = maxlag)
	
	n = n[sapply(n, function(x) !all ( unlist(x) == 0 ) )]
	
	maxlag = length(n)
	
	n = lapply(n, neighborsDataFrame)
	d = mapply(FUN = function(x, rank) cbind(x, rank), x = n, rank = 1:maxlag, SIMPLIFY = FALSE)
	d = do.call(rbind, d)
	d
	

}





















