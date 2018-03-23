<!--
%\VignetteEngine{knitr::knitr}
%\VignetteIndexEntry{Blue Tits Case study}
-->

### Extra-pair paternity in Blue Tits (_Cyanistes caeruleus_): a case study from Westerholz, Bavaria, Germany

#### Supplement to Schlicht, Valcu and Kempenaers _"Spatial patterns of extra-pair paternity: beyond paternity gains and losses"_ (in prep.)


##### 1. Getting started
 * Download and install [R](http://cran.rstudio.com/).
 * Open R, and install _expp_ by copying the following line into your R console:  

```r
install.packages("expp")
```
  

 * To load _expp_ type:   

```r
require(expp)
```

##### 2. Load datasets
For info on the data-sets type: 

```r
help(bluetit_breeding)
help(bluetit_epp)
help(bluetit_boundary)
```


```r
data(bluetit_breeding)
head(bluetit_breeding[bluetit_breeding$year_ == 2011, ])
```

    year_  id       x       y female male layingDate male_age male_tarsus
351  2011  17 4417837 5334163   <NA> <NA>        102    adult          NA
352  2011 160 4417574 5334549   <NA> m383        103      juv      17.160
353  2011 261 4417593 5334857   f174 m348        101    adult      17.045
354  2011 174 4417433 5334600   f186 m238        103    adult      16.800
355  2011  80 4417728 5334311   f218 m361        101    adult      17.500
356  2011 262 4417552 5334861   f224 m280         99    adult      17.110
    study_area
351 Westerholz
352 Westerholz
353 Westerholz
354 Westerholz
355 Westerholz
356 Westerholz


```r
data(bluetit_epp)
head(bluetit_epp[bluetit_epp$year_ == 2011, ])
```


|    | year_|male |female |
|:---|-----:|:----|:------|
|130 |  2011|m280 |f174   |
|163 |  2011|m376 |f224   |
|181 |  2011|m374 |f251   |
|190 |  2011|m328 |f266   |
|193 |  2011|m355 |f275   |
|194 |  2011|m310 |f277   |


```r
data(bluetit_boundary)
summary(bluetit_boundary)
```

```
## Object of class SpatialPolygonsDataFrame
## Coordinates:
##       min     max
## x 4417139 4815230
## y 5334160 5351921
## Is projected: TRUE 
## proj4string :
## [+proj=tmerc +lat_0=0 +lon_0=12 +k=1 +x_0=4500000 +y_0=0
## +datum=potsdam +units=m +no_defs +ellps=bessel
## +towgs84=598.1,73.7,418.2,0.202,0.045,-2.455,6.7]
## Data attributes:
##      year_     
##  Min.   :1998  
##  1st Qu.:2001  
##  Median :2004  
##  Mean   :2004  
##  3rd Qu.:2008  
##  Max.   :2011
```

##### 3. Prepare data

###### 3.1 Split by year (each year needs to be processed separately)


```r
b = split(bluetit_breeding, bluetit_breeding$year_)
e = split(bluetit_epp, bluetit_epp$year_) 

# sample sizes by year

# number of breeding pairs
sapply(b, nrow)
```

```
## 1998 1999 2000 2001 2002 2003 2004 2007 2008 2009 2010 2011 
##   52   67   82   78  114  105  100   88   97   61  102   79
```

```r
# number of extra-pair events
sapply(e, nrow)
```

```
## 1998 1999 2000 2001 2002 2003 2004 2007 2008 2009 2010 2011 
##   17   38   33   41   54   50   36   29   27   33   34   33
```

```r
# For the sake of conciseness only two years are used in the folowing analyses
b = b[c("2009", "2010")]
e = e[c("2009", "2010")]
p = bluetit_boundary[bluetit_boundary$year_ %in% c("2009", "2010"), ]
```

###### 3.2 Run a couple of helper functions on both breeding data and extra-pair paternity data 

```r
breedingDat = lapply(b, SpatialPointsBreeding, coords= ~x+y, id='id', breeding= ~male + female, 
  proj4string = CRS(proj4string(p)))

eppDat = lapply(e, eppMatrix, pairs = ~ male + female)
```

###### 3.3. Compute Dirichlet polygons based on the `SpatialPointsBreeding` object


```r
polygonsDat = mapply(DirichletPolygons, x = breedingDat, boundary = split(p, p$year_)) 
```
********************************************************************************

##### 4. All the objects are now ready to be processed by the `epp` function.

```r
maxlag = 10
eppOut = mapply(FUN = epp, breedingDat, polygonsDat, eppDat, maxlag)
```


















