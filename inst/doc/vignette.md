<!--
%\VignetteEngine{knitr::docco_linear}
%\VignetteIndexEntry{An Introduction to formatR}
-->


# Instructions for the usage of the package expp


**Supplement to "Spatial patterns of extra-pair paternity: beyond paternity gains and losses"**"

**For latest version see wignette('expp')**

**ADD URL**

## 1. Download R version R 3.0.2, for example from [cran.studio.com] (http://cran.rstudio.com/).

## 2. Open R, and install package expp from the repository "???", or copy the following line of code into your R console:
  
  
  ```r
  install.packages("expp", repos = "http://rforge.net")
  ```

  
## 3. Load package.
  
  ```r
  require(expp)
  ```
  
  ```
  ## Loading required package: expp
  ## Loading required package: spdep
  ## Loading required package: sp
  ## Loading required package: Matrix
  ## Loading required package: rgeos
  ## rgeos version: 0.3-2, (SVN revision 413M)
  ##  GEOS runtime version: 3.3.8-CAPI-1.7.8 
  ##  Polygon checking: TRUE 
  ## 
  ## Loading required package: deldir
  ## deldir 0.1-1
  ## Loading required package: spatstat
  ## Loading required package: mgcv
  ## Loading required package: nlme
  ## This is mgcv 1.7-26. For overview type 'help("mgcv-package")'.
  ## Loading required package: abind
  ## Loading required package: tensor
  ## Loading required package: polyclip
  ## polyclip 1.2-0
  ## 
  ## spatstat 1.34-1       (nickname: 'Window Cleaner') 
  ## For an introduction to spatstat, type 'beginner'
  ## ---------------------------------------------------------------------------------------
  ## This is expp 1.0
  ## ---------------------------------------------------------------------------------------
  ```


## 4. Load raw datasets
  
  ```r
  data(westerholzBreeding)
  data(westerholzEPP)
  ```

  
## 5. `epp()` only works on individual years. Since we have two years of data, we need to split out data sets up ...  
  
  ```r
  b = split(westerholzBreeding[, !names(westerholzBreeding) == "year_"], westerholzBreeding$year_)
  # remove the column year_ in this step!
  str(b)
  ```
  
  ```
  ## List of 2
  ##  $ 2009:'data.frame':	56 obs. of  8 variables:
  ##   ..$ id        : int [1:56] 277 82 59 97 234 48 77 191 206 224 ...
  ##   ..$ x         : num [1:56] 4417476 4417816 4417518 4417227 4417757 ...
  ##   ..$ y         : num [1:56] 5335000 5334307 5334309 5334376 5334753 ...
  ##   ..$ layingDate: int [1:56] 99 106 104 103 107 100 103 101 107 103 ...
  ##   ..$ male_age  : chr [1:56] "adult" "adult" "adult" "adult" ...
  ##   ..$ female_age: chr [1:56] "adult" "adult" "adult" "adult" ...
  ##   ..$ female    : chr [1:56] "f11" "f23" "f7" "f18" ...
  ##   ..$ male      : chr [1:56] "m16" "m48" "m10" "m28" ...
  ##  $ 2010:'data.frame':	96 obs. of  8 variables:
  ##   ..$ id        : int [1:96] 214 95 1 81 77 220 202 59 47 45 ...
  ##   ..$ x         : num [1:96] 4417785 4417285 4417157 4417782 4417618 ...
  ##   ..$ y         : num [1:96] 5334719 5334377 5334225 5334306 5334357 ...
  ##   ..$ layingDate: int [1:96] 111 107 112 105 110 114 110 109 142 102 ...
  ##   ..$ male_age  : chr [1:96] "adult" "adult" "adult" "adult" ...
  ##   ..$ female_age: chr [1:96] "juv" "adult" "juv" "adult" ...
  ##   ..$ female    : chr [1:96] "f63" "f18" "f69" "f38" ...
  ##   ..$ male      : chr [1:96] "m35" "m28" "m41" "m13" ...
  ```
  
  ```r
  #################################### e = split(westerholzEPP[,!names(westerholzEPP)=='year_'],
  #################################### westerholzEPP$year_)
  e = split(westerholzEPP[, c("male", "female")], westerholzEPP$year_)
  ## remove the column year_ in this step!
  str(e)
  ```
  
  ```
  ## List of 2
  ##  $ 2009:'data.frame':	29 obs. of  2 variables:
  ##   ..$ male  : chr [1:29] "m16" "m16" "m16" "m41" ...
  ##   ..$ female: chr [1:29] "f29" "f53" "f36" "f47" ...
  ##  $ 2010:'data.frame':	32 obs. of  2 variables:
  ##   ..$ male  : chr [1:32] "m13" "m6" "m15" "m38" ...
  ##   ..$ female: chr [1:32] "f24" "f110" "f28" "f73" ...
  ```


## 6. ... transform the data sets into the right formats ...
  
  ```r
  breedingDat = lapply(b, SpatialPointsBreeding, coords = ~x + y, id = "id", breeding = ~male + 
      female)
  
  polygonsDat = lapply(breedingDat, DirichletPolygons)
  ```
  
  ```
  ## 
  ##      PLEASE NOTE:  The components "delsgs" and "summary" of the 
  ##      object returned by deldir() are now DATA FRAMES rather than 
  ##      matrices (as they were prior to release 0.0-18). 
  ##      See help("deldir").
  ##  
  ##      PLEASE NOTE: The process that deldir() uses for determining
  ##      duplicated points has changed from that used in version
  ##      0.0-9 of this package (and previously). See help("deldir").
  ```

  
## 7. ... and apply the epp-function to each of the years individually. Please note that we removed the 'year_' column in step 5. We now have to add it again.
  
  ```r
  d = list()
  for (i in 1:length(breedingDat)) {
      d[[i]] = epp(breedingDat[[i]], polygonsDat[[i]], e[[i]], rank = 3)  #run epp()
      d[[i]]@EPP$year_ = names(b)[[i]]  #add year
  }
  ```

  
## 8. We can then paste the two years of data together.
  
  ```r
  dat = data.frame(rbind(d[[1]]@EPP, d[[2]]@EPP))
  # dat = as.data.frame(d) #combine the data sets for the individual years
  ```

  
## 9. We now have two data sets. "d" lists the output of the function epp() for the two years, including the input data. "dat" contains the combined data of the two seasons excluding the input data.
  
## 10. We can then plot the data of each year. The package supplies two different types of plots for class "epp" (output of function epp()  ).  
  plot() will plot the study area, the territory borders, and the EPP (as red lines).
  
  ```r
  plot(d[[1]])
  ```
  
  ![plot of chunk unnamed-chunk-8](figure/unnamed-chunk-8.png) 
  
  ```
  ## NULL
  ```

  barplot() will by default (relativeValues = FALSE) plot the number of EPP events for each breeding distance. 
  
  ```r
  barplot(d[[1]])
  ```
  
  ![plot of chunk unnamed-chunk-9](figure/unnamed-chunk-9.png) 

  With the setting "relativeValues = TRUE" the proportion of EPP events within each breeding distance are plotted, and the proportion of available mates within each breeding distance is added as a dashed line. The maximal distance that is plotted depends on the setting of "rank" in step 7.
  
  ```r
  barplot(d[[1]], relativeValues = TRUE)
  ```
  
  ![plot of chunk unnamed-chunk-10](figure/unnamed-chunk-10.png) 


## 11. Since EPP is most frequent among direct neighbours, estimates for all other variable are most meaningful if they are assessed for direct neighbours. We therefore subtract '1' from the breeding distance, so that direct neighbours get scored as '0'. This transformation is important if interactions are modeled.
  
  ```r
  if (min(dat$rank == 1)) dat$rank = dat$rank - 1
  ```


## 12. As a next step, variables can be transformed to be relative to the surroundings of the males or the females. We here present breeding asynchrony as an example.  
  
  ```r
  center = function(x) {
      return(x - mean(x, na.rm = TRUE))
  }
  scale2 = function(x) {
      return(x/(2 * sd(x, na.rm = TRUE)))
  }
  
  # laying dates -> asynchrony
  dat$asynchrony = abs(dat$layingDate_MALE - dat$layingDate_FEMALE)
  
  # asynchrony -> relative asynchrony within the breeding distance of the
  # focal pair
  MALE_splitBy = paste(dat$year_, dat$id_MALE, dat$male, dat$rank, sep = "_")
  dat$relative_asynchrony_MALE = unsplit(lapply(split(dat$asynchrony, MALE_splitBy), 
      center), MALE_splitBy)
  dat$relative_asynchrony_MALE = scale2(dat$relative_asynchrony_MALE)
  
  FEMALE_splitBy = paste(dat$year_, dat$id_FEMALE, dat$female, dat$rank, sep = "_")
  dat$relative_asynchrony_FEMALE = unsplit(lapply(split(dat$asynchrony, FEMALE_splitBy), 
      center), FEMALE_splitBy)
  dat$relative_asynchrony_FEMALE = scale2(dat$relative_asynchrony_FEMALE)
  ```


## 13. We can now make sure the sample size is sufficient for the number of variables we aim to include into the model.
  
  ```r
  table(dat$epp, dat$year_)  #sample size as the number of '0' and '1' in the epp column
  ```
  
  ```
  ##    
  ##     2009 2010
  ##   0 1385 2601
  ##   1   27   29
  ```

  
## 14. And finally, we can run the model (this may take a while depending on your system!).
  
  ```r
  require(lme4)
  ```
  
  ```
  ## Loading required package: lme4
  ## Loading required package: lattice
  ## 
  ## Attaching package: 'lme4'
  ## 
  ## Das folgende Objekt ist maskiert from 'package:nlme':
  ## 
  ##     lmList
  ```
  
  ```r
  dat$age2 = ifelse(dat$male_age_MALE == "juv", 1, 2)
  
  # NOT RUN fm = glmer(epp ~ rank + male_age_MALE + relative_asynchrony_MALE +
  # relative_asynchrony_FEMALE + (1|male) + (1|female) + (1|year_), data =
  # dat, family = binomial)
  summary(fm)
  ```
  
  ```
  ## Error: Fehler bei der Auswertung des Argumentes 'object' bei der Methodenauswahl
  ## für Funktion 'summary': Fehler: Objekt 'fm' nicht gefunden
  ```

  
## 15. Finally, you can plot the model output using for example the R package "effects".
  
  ```r
  require(effects)
  ```
  
  ```
  ## Loading required package: effects
  ## Loading required package: grid
  ## Loading required package: colorspace
  ## 
  ## Attaching package: 'colorspace'
  ## 
  ## Das folgende Objekt ist maskiert from 'package:spatstat':
  ## 
  ##     coords
  ```
  
  ```r
  plot(allEffects(fm))
  ```
  
  ```
  ## Error: Fehler bei der Auswertung des Argumentes 'x' bei der Methodenauswahl
  ## für Funktion 'plot': Fehler in allEffects(fm) : Objekt 'fm' nicht gefunden
  ```


