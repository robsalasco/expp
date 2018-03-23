## ----eval=FALSE----------------------------------------------------------
#  install.packages("expp")

## ----echo=FALSE, message=FALSE-------------------------------------------
require(rgeos); require(sp); require(spdep); require(deldir)
par(mar = c(0,0,1,0) )

## ----message=FALSE-------------------------------------------------------
require(expp)

## ----eval=FALSE----------------------------------------------------------
#  help(bluetit_breeding)
#  help(bluetit_epp)
#  help(bluetit_boundary)

## ---- eval = FALSE-------------------------------------------------------
#  data(bluetit_breeding)
#  head(bluetit_breeding[bluetit_breeding$year_ == 2011, ])

## ---- echo=FALSE, results='asis'-----------------------------------------
data(bluetit_breeding)
head(bluetit_breeding[bluetit_breeding == 2011, ])
data(bluetit_breeding)

## ---- eval = FALSE-------------------------------------------------------
#  data(bluetit_epp)
#  head(bluetit_epp[bluetit_epp$year_ == 2011, ])

## ---- echo=FALSE, results='asis'-----------------------------------------
data(bluetit_epp)
knitr::kable(head(bluetit_epp[bluetit_epp == 2011, ]))

## ------------------------------------------------------------------------
data(bluetit_boundary)
summary(bluetit_boundary)

## ------------------------------------------------------------------------
b = split(bluetit_breeding, bluetit_breeding$year_)
e = split(bluetit_epp, bluetit_epp$year_) 

# sample sizes by year

# number of breeding pairs
sapply(b, nrow)

# number of extra-pair events
sapply(e, nrow)

# For the sake of conciseness only two years are used in the folowing analyses
b = b[c("2009", "2010")]
e = e[c("2009", "2010")]
p = bluetit_boundary[bluetit_boundary$year_ %in% c("2009", "2010"), ]


## ----tidy=FALSE----------------------------------------------------------
breedingDat = lapply(b, SpatialPointsBreeding, coords= ~x+y, id='id', breeding= ~male + female, 
  proj4string = CRS(proj4string(p)))

eppDat = lapply(e, eppMatrix, pairs = ~ male + female)



## ------------------------------------------------------------------------
polygonsDat = mapply(DirichletPolygons, x = breedingDat, boundary = split(p, p$year_)) 

## ------------------------------------------------------------------------
maxlag = 10
eppOut = mapply(FUN = epp, breedingDat, polygonsDat, eppDat, maxlag)

