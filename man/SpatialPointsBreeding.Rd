\name{SpatialPointsBreeding}
\alias{SpatialPointsBreeding}

\title{
Converts a data.frame to an object of class SpatialPointsBreeding
}

\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
SpatialPointsBreeding(data, proj4string = CRS(as.character(NA)), coords = ~x + y, id = "id", breeding = ~male + female)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{data}{
%%     ~~Describe \code{data} here~~
}
  \item{proj4string}{
%%     ~~Describe \code{proj4string} here~~
}
  \item{coords}{
%%     ~~Describe \code{coords} here~~
}
  \item{id}{
%%     ~~Describe \code{id} here~~
}
  \item{breeding}{
%%     ~~Describe \code{breeding} here~~
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
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
    set.seed(1310)
    b = data.frame(id = 1:3, x = rnorm(3), y = rnorm(3), 
      male = paste0("m",1:3), female =  paste0("f",1:3), xx = rnorm(3), stringsAsFactors=FALSE  )  
    breedingDat = SpatialPointsBreeding(b )
    polygonsDat = DirichletPolygons(breedingDat)
    eppPairs = data.frame(male = c("m1", "m2", "m1"), female=c("f3", "f1", "f2") )
    
    plot(polygonsDat)
    plot(breedingDat, add = T)

  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line







