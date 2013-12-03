\name{DirichletPolygons}
\alias{DirichletPolygons}

\title{
Estimation of Dirichlet Polygons
}
\description{
Estimates Dirichlet polygons baes on a SpatialPointsBreeding object.
}
\usage{
DirichletPolygons(x, boundary = "missing")
}

\arguments{
  \item{x}{
  SpatialPointsBreeding object (see SpatialPointsBreeding).
}
  \item{boundary}{
  ..., defaults to a convex window (see ?ripras for details).
}
  
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
Returns a SpatialPointsDataFrame object (see ?SpatialPointsDataFrame for details). This output can be used as the second item ("polygonsDat") in the epp() function.
}
\references{
%% ~put references to the literature/web site here ~
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
###example with three breeding pairs
  
  #create raw datasets
      set.seed(1310)
      b = data.frame(id = 10:12, x = rnorm(3), y = rnorm(3), male = paste0("m",1:3), female =  paste0("f",1:3), xx = rnorm(3), stringsAsFactors=FALSE  )  
      eppPairs = data.frame(male = c("m1", "m2", "m1"), female=c("f3", "f1", "f2") )
  
  #transform data
      breedingDat = SpatialPointsBreeding(b )
      polygonsDat = DirichletPolygons(breedingDat)
      x = epp(breedingDat, polygonsDat, eppPairs, rank = 3)
 
  #plot data
      plot(x) #red lines indicate EPP events


% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
