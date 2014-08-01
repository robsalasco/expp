\name{eppSimDat}
\alias{eppSimDat}

\title{
Type I error rate simulations
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

\dontrun{

require(lme4)

pval_glmer = vector(mode = "numeric", length = 0)
pval_glm = vector(mode = "numeric", length = 0)


for(i in 1:1000) {
  x = as.data.frame(eppSimDat(N = 80, meanClutch = 10, eppRate = 0.10, eppMax = 12, eppMales = 0.35, nLags = 3))
  
  fm1glmer = glmer(epp ~ rank + trait_MALE + trait_FEMALE + (1 | male) + (1 | female) , data = x, family = binomial, nAGQ =  3)
  fm0glmer = update(fm1glmer, epp ~ 1 + (1 | male) + (1 | female) )
  pval_glmer[i] = anova(fm0glmer, fm1glmer)$"Pr(>Chisq)"[2]
    
  fm1glm = glm(epp ~ rank + trait_MALE + trait_FEMALE  , data = x, family = binomial)
  fm0glm = update(fm1glm, epp ~ 1 )
  pval_glm[i] = anova(fm0glm, fm1glm, test = "Chisq")$"Pr(>Chi)"[2]
    
  print(i)
  
  # Type I error rate of glmer models
  print(table(pval_glmer<0.05)[2]/length(pval_glmer))
  
  # Type I error rate of the equivalent glm models
  print(table(pval_glm<0.05)[2]/length(pval_glm))
  
  
  
  
 }

# Type I error rate of glmer models
table(pval_glmer<0.05)[2]/length(pval_glmer)

# Type I error rate of the equivalent glm models
table(pval_glm<0.05)[2]/length(pval_glm)




}

}




% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
