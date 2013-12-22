
####  make vignette
require(knitr)
require(markdown)
knit("~/gitHub/expp/inst/doc/expp.Rmd")
markdownToHTML("expp.md", "~/gitHub/expp/inst/doc/expp.html")
unlink("figure", TRUE)
unlink("expp.md")


vignette("expp")

