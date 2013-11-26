\name{epp}
\alias{epp}

\title{
Creating dataset for realized and unrealized EPP-pairs
}
\description{
Function that combines the breeding data, information about territory boundaries (if present), and the extra-pair paternity data and creates a combined dataset with one line for every male-female combination (apart from the social pair).
}
\usage{
epp(breedingDat, polygonsDat = DirichletPolygons(breedingDat), eppPairs, rank = 3)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{breedingDat}{
     A SpatialPointsBreeding object, created by the function SpatialPointsBreeding()
}
  \item{polygonsDat}{
     A DirichletPolygons object, create by the function DirichletPolygons()
}
  \item{eppPairs}{
     A data.frame with two cloumns listing all male-female combinations that had EPP. Column names must be 'male' and 'female'. 
}
  \item{rank}{
     A numeric value indicating the maximum breeeding distance for which male-female combinations should be calculated.
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
Returns an S4-class epp-object with 5 slots. The first 4 slots contain the input data (breedingDat, polygonsDat, eppPairs, and rank), the fifth slot is called "EPP" and contains the dataset that can be used for further analyses.

  \item{breedingDat }{Input breeding dataset.}
  \item{polygonsDat }{Polygons that are either estimated automatically using Thiessen Polygons, or input breeding polygons.}
  \item{eppPairs }{Input data.frame with EPP data.}
  \item{rank }{Input rank. Defaults to 3.}
  \item{EPP }{Data.frame containing columns for the focal male and female ("male", "female"), their breeding distance ("rank"), and the parameters associated either with the male (column name ends with "_MALE") or the female (column name ends with "_FEMALE") territory. These can be further transformed (see Examples).}


}
\references{
%% potential references: Thiessen polygons, 
}
\author{
%%  ~~who you are~~
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
  
  #example with three breeding pairs
  set.seed(1310)
  b = data.frame(id = 10:12, x = rnorm(3), y = rnorm(3), 
    male = paste0("m",1:3), female =  paste0("f",1:3), xx = rnorm(3), stringsAsFactors=FALSE  )  
  breedingDat = SpatialPointsBreeding(b )
  polygonsDat = DirichletPolygons(breedingDat)
  eppPairs = data.frame(male = c("m1", "m2", "m1"), female=c("f3", "f1", "f2") )
  x = epp(breedingDat, polygonsDat, eppPairs, rank = 3)
 
  #plot method
  plot(x) #red lines indicate EPP events
  
  #example with 50 breeding pairs
  n = 50
  b = data.frame(id = 1:n, x = rnorm(n), y = rnorm(n), 
    male = paste0("m",1:n), female =  paste0("f",1:n), xx = rnorm(n), stringsAsFactors=FALSE  )  
  breedingDat = SpatialPointsBreeding(b )
  polygonsDat = DirichletPolygons(breedingDat)
  eppPairs = data.frame(male = sample(b$male, round(n/10) ), female=sample(b$female, round(n/10) ) )
  
  x = epp(breedingDat, polygonsDat, eppPairs, rank = 5)
  
  #plot methods
  plot(x) #red lines indicate EPP events
  barplot(x) #observed number fo EPP events per breeding distance
  barplot(x, relativeValues = TRUE) #proportion of realized (vertical lines) vs. available (dashed line) male-female combinations
  
  
  # Example using real data from our study site "Westerholz" including two years of data
  data(westerholzBreeding)
  data(westerholzEPP)
  b = split(westerholzBreeding, westerholzBreeding$year_)
  e = split(westerholzEPP, westerholzEPP$year_)
  
  breedingDat = lapply(b, SpatialPointsBreeding, coords= ~x+y, id='id', breeding= ~male + female)
  polygonsDat = lapply(breedingDat, DirichletPolygons)
  
  d = mapply(epp, breedingDat, polygonsDat , e, rank = 4 )
  dat = data.frame(rbind(d[[1]]@EPP, d[[2]]@EPP))
  barplot(d[[1]])
  barplot(d[[1]], relativeValues = TRUE)
  table(dat$epp)
  dim(e[[2]])
  
  require(lme4)
  fm = glmer(epp ~ rank + male_age_MALE + (1|male) + (1|female) + (1|year__MALE), data = dat, family = binomial)
  summary(fm)

  require(effects)
  plot(allEffects(fm))



}

% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line



















