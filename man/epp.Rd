\name{epp}
\alias{epp}

\title{
epp
}
\description{
epp
}
\usage{
epp(breedingDat, polygonsDat = DirichletPolygons(breedingDat), eppPairs, rank = 3)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{breedingDat}{
%%     ~~Describe \code{breedingDat} here~~
}
  \item{polygonsDat}{
%%     ~~Describe \code{polygonsDat} here~~
}
  \item{eppPairs}{
%%     ~~Describe \code{eppPairs} here~~
}
  \item{rank}{
%%     ~~Describe \code{rank} here~~
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
  b = data.frame(id = 10:12, x = rnorm(3), y = rnorm(3), 
    male = paste0("m",1:3), female =  paste0("f",1:3), xx = rnorm(3), stringsAsFactors=FALSE  )  
  breedingDat = SpatialPointsBreeding(b )
  polygonsDat = DirichletPolygons(breedingDat)
  eppPairs = data.frame(male = c("m1", "m2", "m1"), female=c("f3", "f1", "f2") )
  x = epp(breedingDat, polygonsDat, eppPairs, rank = 3)
  plot(x)

  # 
  n = 50
  b = data.frame(id = 1:n, x = rnorm(n), y = rnorm(n), 
    male = paste0("m",1:n), female =  paste0("f",1:n), xx = rnorm(n), stringsAsFactors=FALSE  )  
  breedingDat = SpatialPointsBreeding(b )
  polygonsDat = DirichletPolygons(breedingDat)
  eppPairs = data.frame(male = sample(b$male, round(n/10) ), female=sample(b$female, round(n/10) ) )
  
  x = epp(breedingDat, polygonsDat, eppPairs, rank = 5)
  plot(x)
  barplot(x)
  
  
  # westerholz
  data(westerholzBreeding)
  data(westerholzEPP)
  b = split(westerholzBreeding, westerholzBreeding$year_)
  e = split(westerholzEPP, westerholzEPP$year_)
  
  breedingDat = lapply(b, SpatialPointsBreeding, coords= ~x+y, id='id', breeding= ~male + female)
  polygonsDat = lapply(breedingDat, DirichletPolygons)
  
  d = epp(breedingDat[[2]], polygonsDat[[2]] , e[[2]], rank = 4 )
  table(d@EPP$epp)
  dim(e[[2]])
  
  require(lme4)
  fm = glmer(epp ~ rank + male_age_MALE + (1|male) + (1|female), d@EPP, family = binomial)
  summary(fm)

  require(effects)
  plot(allEffects(fm))
>>>>>>> 657defee5dd3d174e6d172a964662227af8166ba



}

% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line



















