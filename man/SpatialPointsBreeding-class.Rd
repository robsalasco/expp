\name{SpatialPointsBreeding-class}
\Rdversion{1.1}
\docType{class}
\alias{SpatialPointsBreeding-class}
\alias{DirichletPolygons,SpatialPointsBreeding,missing-method}
\alias{DirichletPolygons,SpatialPointsBreeding,SpatialPolygons-method}

\title{Class \code{"SpatialPointsBreeding"}}

\description{
Class \code{SpatialPointsBreeding} extends \code{\link[sp]{SpatialPointsDataFrame}} directly with three extra slots which define the breeding location (e.g. a nest) and a breeding pair identity (male and female respectively). 
}

\section{Objects from the Class}{
Objects can be created by calls of the form \code{new("SpatialPointsBreeding", ...)} but the user should use the \code{\link[expp]{SpatialPointsDataFrame}} function directly. 


}
\section{Slots}{
  \describe{
    \item{\code{id}:}{Object of class \code{"integer"}, an unique point id, usualy the breeding location (e.g. a nest). }
    \item{\code{male}:}{Object of class \code{"character"}, male identity (e.g. the ring number). }
    \item{\code{female}:}{Object of class \code{"character"} , female identity (e.g. the ring number). }
    \item{\code{data}:}{Object of class \code{"data.frame"}, see \code{\link[sp]{SpatialPointsDataFrame}} }
    \item{\code{coords.nrs}:}{Object of class \code{"numeric"} , see \code{\link[sp]{SpatialPoints}} }
    \item{\code{coords}:}{Object of class \code{"matrix"} , see \code{\link[sp]{SpatialPoints}} }
    \item{\code{bbox}:}{Object of class \code{"matrix"} , see \code{\link[sp]{Spatial}} }
    \item{\code{proj4string}:}{Object of class \code{"CRS"} , see \code{\link[sp]{Spatial}} }
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
Schlicht L., Valcu M. and Kempenaers B. "Spatial patterns of extra-pair paternity: beyond paternity gain and loss" (in prep.)
}

\author{
Mihai Valcu 
}

\seealso{
\code{\link[expp]{SpatialPointsDataFrame}}
\code{\link[expp]{DirichletPolygons}}

}

\examples{
showClass("SpatialPointsBreeding")
}
\keyword{classes}




