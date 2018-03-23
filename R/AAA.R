
#' @importFrom graphics arrows axis par plot points text
#' @importFrom methods as new slot
#' @importFrom stats rnorm rpois

### 

.onAttach <- function(libname, pkgname) {
	dcf <- read.dcf(file=system.file("DESCRIPTION", package=pkgname) )
    
	packageStartupMessage("|-------------------------------------------------------------------------------------|")
	
	packageStartupMessage(paste('This is', pkgname, dcf[, "Version"] ))
  
	packageStartupMessage("For a step-by-step tutorial type vignette('expp')")
	
	packageStartupMessage("|-------------------------------------------------------------------------------------|")
}

