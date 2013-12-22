
####  make vignette
require(knitr)
require(markdown)
knit(paste0(getwd(), "/vignettes/expp.Rmd")  )
markdownToHTML("expp.md", paste0(getwd(), "/vignettes/expp.html") )
file.copy(paste0(getwd(), "/vignettes/expp.html"), paste0(getwd(), "/inst/doc") )
unlink("expp.md")

unlink("figure", TRUE)

vignette("expp")


####

# TODO: color EP individuals with red
# TODO: zoom in to a given area
# TODO: add zoom argument on plot(epp), zoom = x neighborhoods away, center = box no. for zoom.