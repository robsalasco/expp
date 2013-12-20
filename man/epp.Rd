\name{epp}
\alias{epp}
\alias{epp-class}
\alias{as.data.frame,epp-method}
\alias{barplot,epp-method}

\title{Creating dataset for realized and unrealized EPP-pairs}

\description{
	Function that uses the breeding data, information about territory boundaries (if present), and the extra-pair paternity data to create a combined dataset with one line for every potential and realised extra-pair male-female combination.}

\usage{
	epp(breedingDat, polygonsDat = DirichletPolygons(breedingDat), eppPairs, rank = 3)
	as.data.frame(x)
	plot(x) 
	}

\arguments{
  \item{breedingDat}{
     A SpatialPointsBreeding object, created by the \code{SpatialPointsBreeding} function }
  \item{polygonsDat}{
     A DirichletPolygons object, created by the \code{DirichletPolygons} function}
  \item{eppDat}{
     An object of class \code{eppMatrix} }
  \item{maxlag}{
     A numeric value indicating the maximum breeding distance for which male-female combinations should be calculated.}
}


\value{
Returns an S4-class epp-object with 5 slots:

  \item{breedingDat}{
	Input breeding dataset.}
  \item{polygonsDat}{
	Either polygons are estimated automatically using Thiessen Polygons, or input breeding polygons.}
  \item{eppDat}{
	Input data.frame with all male-female combinations that had EPP together.}
  \item{maxlag}{
	Input rank. Defaults to 3.}
  \item{EPP}{
	\code{data.frame} containing columns for the focal male and female ("male", "female"), their breeding distance ("rank"), 
	and the parameters associated either with the male (column with prefix "_MALE") or the female 
	(column with prefix "_FEMALE") territory.}


}


\seealso{ vignette(expp) }


\examples{
  ### Simple example with three breeding pairs
  
  # create raw data
  set.seed(1310)
  b = data.frame(id = as.integer(10:12), x = rnorm(3), y = rnorm(3), 
  male = paste0("m",1:3), female =  paste0("f",1:3), xx = rnorm(3), stringsAsFactors=FALSE  )  
  eppPairs = data.frame(male = c("m1", "m2", "m1"), female=c("f3", "f1", "f2") )
  
  # prepare data
  breedingDat = SpatialPointsBreeding(b, id = 'id', coords = ~ x + y, breeding = ~ male + female)
  polygonsDat = DirichletPolygons(breedingDat)
  eppDat	  = eppMatrix(eppPairs, pairs = ~ male + female)
  
  # convert to epp class		
  x = epp(breedingDat, polygonsDat, eppDat, maxlag = 3)
  as.data.frame(x)
  
  #plot 
  plot(x) 
  
  ### Example on a random data set with n breeding pairs and  n/2 extra-pair paternity rate
  # create raw data
  set.seed(123)
  n = 20
  b = data.frame(id = 1:n, x = rnorm(n), y = rnorm(n), 
  male = paste0("m",1:n), female =  paste0("f",1:n), xx = rnorm(n), stringsAsFactors=FALSE  )  
  eppPairs = data.frame(male = sample(b$male, round(n/2) ), female = sample(b$female, round(n/2) ) )
  
  # prepare data
  breedingDat = SpatialPointsBreeding(b, id = 'id', coords = ~ x + y, breeding = ~ male + female)
  polygonsDat = DirichletPolygons(breedingDat)
  eppDat	  = eppMatrix(eppPairs, pairs = ~ male + female)
  
  # convert to epp class
  x = epp(breedingDat, polygonsDat, eppDat, maxlag = 10)
  
  # plot 
  plot(x)
  barplot(x) 
  barplot(x, relativeValues = TRUE) 
  

\dontrun{   
  ### Real data example
  # Raw datasets 
  data(westerholzBreeding)
  data(westerholzEPP)
  # select one year 
  year = 2010
  b = westerholzBreeding[westerholzBreeding$year_ == year, ]
  eppPairs = westerholzEPP[westerholzEPP$year_ == year, ]
  
  # prepare data
  breedingDat  = SpatialPointsBreeding(b, id = 'id', coords = ~ x + y, breeding = ~ male + female)
  polygonsDat = DirichletPolygons(breedingDat)
  eppDat = eppMatrix(eppPairs, pairs = ~ male + female)
  
  # convert to epp class
  x = epp(breedingDat, polygonsDat, eppDat, maxlag = 20)
  
  # plot
  plot(x)
  barplot(x) 
  
  # run model on epp probability		
  dat = as.data.frame(x)
  nrow(dat[dat$epp == 1, c('male', 'female')] )
  nrow(unique(eppPairs))
  
  if(require(lme4))
   (summary(glmer(epp ~ rank + male_age_MALE + (1|male) + (1|female), data = dat, family = binomial)))

}
  
}



\keyword{spatial}



















