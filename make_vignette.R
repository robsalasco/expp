
####  make vignette
require(knitr)
require(markdown)

wd = setwd("~/gitHub/expp/vignettes/")

v = c("westerholz")

for(i in 1:2) {
  knit(paste0(v[i],".Rmd"))
  markdownToHTML(paste0(v[i],".md")  , paste0(v[i],".html") )
  file.copy(     paste0(v[i],".html"),  "~/gitHub/expp/inst/doc", overwrite = TRUE)
  file.copy(     paste0(v[i],".md")  ,  "~/gitHub/expp/inst/doc", overwrite = TRUE)
  file.copy(     paste0(v[i],".Rmd") ,  "~/gitHub/expp/inst/doc", overwrite = TRUE)
  unlink("figure", TRUE)
  }

setwd(wd)

vignette("westerholz")
vignette("expp_intro")

####

