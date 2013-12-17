
 
eppMatrix <- function(data,  pairs = ~ male + female) {
	
	m = as.character(pairs[[2]][2])
	f  = as.character(pairs[[2]][3])
	d = data.frame(male = as.character(data[, m]), 
				  female =  as.character(data[, f]),  
					stringsAsFactors = FALSE)
	class(d) = c("data.frame", 'eppMatrix')
	d
	
}
