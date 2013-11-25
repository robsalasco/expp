


neighborsDataFrame <- function(nb) {

	x = min(  as.numeric(attributes(nb)$region.id)  )-1

	id = rep(1:length(nb), times = sapply(nb, length))
	id_neigh = unlist(nb)

	id = ifelse(id==0, id, id+x)
	id_neigh = ifelse(id_neigh==0, id_neigh, id_neigh+x)

	data.frame(id, id_neigh)

	}
			
higherNeighborsDataFrame <- function(nb, maxlag) {
	n = nblag(nb, maxlag = maxlag)
	n = lapply(n, neighborsDataFrame)
	d = mapply(FUN = function(x, rank) cbind(x, rank), x = n, rank = 1:maxlag, SIMPLIFY = FALSE)
	d = do.call(rbind, d)
	d = d[d$id_neigh > 0, ]
	d
	

}





















