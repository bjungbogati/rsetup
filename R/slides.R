
# copy folders

copy_folder <- function(source, dest, incl_dirs) {
  old <- dir(path = here::here(source), pattern = incl_dirs, full.names = T)

  new <- gsub(source, dest, old)

  purrr::map2(.x = here::here(old), .y = here::here(new), R.utils::copyDirectory)
}


# copy_folder("docs", "slides2", "libs|imgs|figures")



## copy files

copy_file <- function(source, dest, pattern) {
  old  <- here::here(list.files(path = source, pattern = pattern, full.names = T))
  new <- gsub(source, dest, old)

  purrr::map2(.x = here::here(old), .y = here::here(new), file.rename)
}




# render slide to html

render_slide <- function(name = ".qmd", docs = "docs",
                          slides = "slides", ext = ".css|.html",
                          includes = "libs|figures", folder = F) {

  files <- list.files(path = docs, pattern = name, full.names = T)

  purrr::map(here::here(files), rmarkdown::render)

  if (folder == F & name != ".qmd") {
    copy_file(docs, slides, ext)
  } else {
    copy_folder(docs, slides, includes)
    copy_file(docs, slides, ext)
  }
}

# open documents
open_doc <- function(name, docs = "docs") {

  rstudioapi::navigateToFile(here::here(docs, paste0(name, ".qmd")))

}

# open html slides

open_slide <- function(name, slides = "slides") {

  browseURL(here::here(slides, paste0(name, ".html")))

}
