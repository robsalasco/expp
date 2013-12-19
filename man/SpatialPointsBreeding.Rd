\name{SpatialPointsBreeding}
\alias{SpatialPointsBreeding}
\alias{SpatialPointsBreeding-class}
\alias{SpatialPointsBreeding,SpatialPolygons-method}
\alias{SpatialPointsBreeding,missing-method}
\alias{SpatialPointsBreeding,numeric-method}
\alias{plot,SpatialPointsBreeding,missing-method}

\title{Converts a \code{data.frame} to an object of class \code{SpatialPointsBreeding} }


\description{
Converts a \code{\link{data.frame}} to a \code{SpatialPointsBreeding} object.
The \code{SpatialPointsBreeding} class extends \code{\link[sp]{SpatialPointsDataFrame}} 
with three extra slots defining the id (i.e. nest or breeding box) and the pair identity
(i.e. male and female), respectively.
}


\usage{
SpatialPointsBreeding(data, proj4string , 
  coords = ~x + y, id = "id", breeding = ~male + female)
  
\S3method{plot}{SpatialPointsBreeding}(x, pch = 20, axes = FALSE, 
                add = FALSE, xlim = NULL, ylim = NULL, ..., cex = 1, 
                col = "grey", lwd = 1, bg = 1, pair.cex = .6)  
  
}


\arguments{
  \item{data}{
    a \code{\link{data.frame}}  containing the coordinates (e.g. "x", "y"), the location id, and the pair identity (e.g. "male", "female") toghether with any other optional variables (e.g. individuals or nest traits).
}

  \item{proj4string}{
    Projection method of the coordinates. See \code{\link[sp]{proj4string}} for details.
}

  \item{coords}{
   Formula defining the column names of the x and y coordinates, respectively.
}

  \item{id}{
  Column name of the location id (e.g. nest box number, den ID). Must be numeric.
}
  \item{breeding}{
  Formula defining the male and female ID in that order.
}
}

\value{
Item of the class 'SpatialPointsBreeding' with 8 slots.

  \item{id }{Location ID (see input)}
  \item{male }{ (Male IDs.)}
  \item{female }{Female IDs.}
  \item{data }{Original input data.frame excluding the coordinates, and all IDs.}
  \item{coords.nrs}{\code{\link[sp]{SpatialPoints}} }
  \item{coords }{Coordinates of the respective location.}
  \item{bbox }{\code{\link[sp]{Spatial}} }
  \item{proj4string }{Projection method of the coordinates. See \code{\link[sp]{proj4string}} for details.}
}


\seealso{\code{\link[expp]{epp}}}

\references{
Schlicht L., Valcu M. and Kempenaers B. 
  "Spatial patterns of extra-pair paternity: beyond paternity gain and loss" 
  (in prep.)
}

\examples{
d = data.frame(
  x = c(4, 17, 16, 41, 41, 43, 86, 62, 71, 92, 95,53, 34, 27, 53), 
  y = c(3, 18, 36, 6, 18, 50, 3, 21, 40, 43, 57, 62, 62, 45, 37), 
  id = 1:15,male = paste0('m', 1:15), female = paste0('f', 1:15), 
    stringsAsFactors = FALSE
)

b = SpatialPointsBreeding(d, id = 'id')	

plot(b)


} 
  

\keyword{ spatial }







