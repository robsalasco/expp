\name{eppSimDat}
\alias{eppSimDat}

\title{
%%  ~~function to do ... ~~
}

\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
eppSimDat(x)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{
%%     ~~Describe \code{x} here~~
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
# Type I error rate

require(lme4)

NSIM = 20
o = list()

for(i in 1:NSIM) {
  x = as.data.frame(exppSimDat(N = 20))
  fm = glmer(epp ~ rank + trait_MALE + trait_FEMALE + (1 | male) + (1 | female) , data = x, family = binomial)
  o[[i]] = summary(fm) $ coefficients
  print(i)
  }

# Type I error rate for rank
pval = sapply(o, function(x) x[2, 4])
table(pval<0.05)[2]/NSIM

# Type I error rate for trait_MALE
pval = sapply(o, function(x) x[3, 4])
table(pval<0.05)[2]/NSIM

# Type I error rate for trait_FEMALE
pval = sapply(o, function(x) x[4, 4])
table(pval<0.05)[2]/NSIM


}




% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
