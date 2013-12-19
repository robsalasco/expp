\name{westerholzEPP}
\alias{westerholzEPP}
\docType{data}
\title{
westerholzEPP/Data on extra-pair paternity (EPP)
}
\description{
Data.frame containing all male-female combinations that had EPP together. The data set contains two seasons.
}
\usage{data(westerholzEPP)}
\format{
  A data frame with 61 observations on the following 3 variables.
  \describe{
    \item{\code{year_}}{numeric. The year of the observation.}
    \item{\code{female}}{character. The female involved in the respective EPP event.}
    \item{\code{male}}{character. The male invilved in the respective EPP event.}
  }
}
\details{
This data set excludes all social pairs and shows only EPP pairs.
}
\source{
%%  ~~ reference to a publication or URL from which the data were obtained ~~
}
\references{
%%  ~~ possibly secondary sources and usages ~~
}
\examples{
data(westerholzEPP)

head(westerholzEPP)

}
\keyword{datasets}
