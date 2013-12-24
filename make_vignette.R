
####  make vignette
require(knitr)
require(markdown)

wd = setwd("~/gitHub/expp/vignettes/")

knit("westerholz.Rmd")
markdownToHTML("westerholz.md", "westerholz.html")
file.copy("westerholz.html",  "~/gitHub/expp/inst/doc", overwrite = TRUE)
file.copy("westerholz.md",  "~/gitHub/expp/inst/doc", overwrite = TRUE)
file.copy("westerholz.Rmd",  "~/gitHub/expp/inst/doc", overwrite = TRUE)
unlink("figure", TRUE)





setwd(wd)

vignette("westerholz")


####

