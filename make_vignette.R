
####  make vignette
require(knitr)
require(markdown)

wd = setwd("./vignettes/")
doc = "../inst/doc/"

v = c("expp")

for(i in 1) {
  knit(paste0(v[i],".Rmd"))
  markdownToHTML(paste0(v[i],".md")  , paste0(v[i],".html") )
  file.copy(     paste0(v[i],".html"),  doc, overwrite = TRUE)
  file.copy(     paste0(v[i],".md")  ,  doc, overwrite = TRUE)
  file.copy(     paste0(v[i],".Rmd") ,  doc, overwrite = TRUE)
  unlink("figure", TRUE)
  }

setwd(wd)

####

