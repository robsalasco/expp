\name{SpatialPointsBreeding-class}
\Rdversion{1.1}
\docType{class}
\alias{SpatialPointsBreeding-class}
\alias{DirichletPolygons,SpatialPointsBreeding,missing-method}
\alias{DirichletPolygons,SpatialPointsBreeding,SpatialPolygons-method}

\title{Class \code{"SpatialPointsBreeding"}}
\description{
%%  ~~ A concise (1-5 lines) description of what the class is. ~~
}
\section{Objects from the Class}{
Objects can be created by calls of the form \code{new("SpatialPointsBreeding", ...)}.
%%  ~~ describe objects here ~~ 
}
\section{Slots}{
  \describe{
    \item{\code{id}:}{Object of class \code{"integer"} ~~ }
    \item{\code{male}:}{Object of class \code{"character"} ~~ }
    \item{\code{female}:}{Object of class \code{"character"} ~~ }
    \item{\code{data}:}{Object of class \code{"data.frame"} ~~ }
    \item{\code{coords.nrs}:}{Object of class \code{"numeric"} ~~ }
    \item{\code{coords}:}{Object of class \code{"matrix"} ~~ }
    \item{\code{bbox}:}{Object of class \code{"matrix"} ~~ }
    \item{\code{proj4string}:}{Object of class \code{"CRS"} ~~ }
  }
}
\section{Extends}{
Class \code{"\linkS4class{SpatialPointsDataFrame}"}, directly.
Class \code{"\linkS4class{SpatialPoints}"}, by class "SpatialPointsDataFrame", distance 2.
Class \code{"\linkS4class{Spatial}"}, by class "SpatialPointsDataFrame", distance 3.
Class \code{"\linkS4class{SpatialPointsNULL}"}, by class "SpatialPointsDataFrame", distance 3.
}
\section{Methods}{
  \describe{
    \item{DirichletPolygons}{\code{signature(x = "SpatialPointsBreeding", boundary = "missing")}: ... }
    \item{DirichletPolygons}{\code{signature(x = "SpatialPointsBreeding", boundary = "SpatialPolygons")}: ... }
	 }
}
\references{
%%  ~~put references to the literature/web site here~~
}
\author{
%%  ~~who you are~~
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%%  ~~objects to See Also as \code{\link{~~fun~~}}, ~~~
%%  ~~or \code{\linkS4class{CLASSNAME}} for links to other classes ~~~
}
\examples{
showClass("SpatialPointsBreeding")
}
\keyword{classes}
