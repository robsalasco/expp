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

	d = data.frame(
		x = c(4, 17, 16, 41, 41, 43, 86, 62, 71, 92, 95,53, 34, 27, 53), 
		y = c(3, 18, 36, 6, 18, 50, 3, 21, 40, 43, 57, 62, 62, 45, 37), 
		id = 1:15,
		male = paste0('m', 1:15), female = paste0('f', 1:15), 
		
		stringsAsFactors=FALSE
		)

	b = SpatialPointsBreeding(d, id = 'id')	

# boundary is inferred based on the Ripley-Rasson estimate of the spatial domain
	dp1 = DirichletPolygons(b)
	plot(dp1)
 
# boundary is given
	brdy2 = readWKT("POLYGON((28 71,67 68,70 49,84 49,90 74,111 65,107 36,78 28,98 15,98 -4,74 -7,-2 -8,0 31,28 71) )")
	dp2 = DirichletPolygons(b, boundary = brdy2)
	plot(dp2)

# boundary is inferred based on the boundary boxes
	# define boundary id-s using a 'Follow-The-Dots' strategy. 
	brdy3 = as.integer(c(1, 2, 4, 7, 9, 10, 11, 12, 13, 14, 3))
	
	dp3 = DirichletPolygons(b, boundary = brdy3)
	plot(dp3)
 
 plot(dp1)
 plot(dp2, add = TRUE, border = 2)
 plot(dp3, add = TRUE, border = 3)
 plot(b, add = TRUE)

% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line



























