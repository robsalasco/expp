
####  make vignette
require(knitr)
require(markdown)

setwd("~/gitHub/expp/vignettes/")

knit("expp.Rmd")
markdownToHTML("expp.md", "expp.html")


file.copy("expp.html",  "~/gitHub/expp/inst/doc", overwrite = TRUE)
file.copy("expp.md",  "~/gitHub/expp/inst/doc", overwrite = TRUE)
file.copy("expp.Rmd",  "~/gitHub/expp/inst/doc", overwrite = TRUE)


unlink("figure", TRUE)

vignette("expp")


####

