\name{SpatialPointsBreeding}
\alias{SpatialPointsBreeding}

\title{
Converts a data.frame to an object of class SpatialPointsBreeding

}

\description{
Converts a data.frame to a SpatialPointsBreeding object
}
\usage{
SpatialPointsBreeding(data, proj4string = CRS(as.character(NA)), coords = ~x + y, id = "id", breeding = ~male + female)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{data}{
    data.frame with at least five columns stating the coordinates (e.g. "x", "y"), the location id (e.g. "id"), and the male and female ID (e.g. "male", "female"). Any other variableslinked to the location id can be included here (e.g. male traits).
}
  \item{proj4string}{
    Projection method of the coordinates. See ?proj4string for details.
}
  \item{coords}{
   Formula defining the column names of the x and y coordinates, respectively.
}
  \item{id}{
  Column name of the location id (e.g. nest box number, den ID). Must be numeric.
}
  \item{breeding}{
  Formula defining the column names of male and female IDs, respectively.
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
Item of the class 'SpatialPointsBreeding' with 8 slots.

  \item{id }{Location ID (see input)}
  \item{male }{ (Male IDs.)}
  \item{female }{Female IDs.}
  \item{data }{Original input data.frame excluding the coordinates, and all IDs.}
  \item{coords.nrs }{???}
  \item{coords }{Coordinates of the respective location.}
  \item{bbox }{??? Boundary box???}
  \item{proj4string }{Projection method of the coordinates. See ?proj4string for details.}
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


# data set
d = data.frame(
	x = c(4, 17, 16, 41, 41, 43, 86, 62, 71, 92, 95,53, 34, 27, 53), 
	y = c(3, 18, 36, 6, 18, 50, 3, 21, 40, 43, 57, 62, 62, 45, 37), 
	id = 1:15,
	male = paste0('m', 1:15), female = paste0('f', 1:15), 
	
	stringsAsFactors=FALSE
	)

b = SpatialPointsBreeding(d, id = 'id')	
	
plot(b)


  
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line







