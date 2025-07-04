
# download course file and unzip it
get_course <- function(url_path, set_path) {
  options(Ncpus = 4)

  # if (require(rsetup)) { remove.packages("rsetup") }

  usethis::use_course(
    url = url_path,
    destdir = set_path
  )
}

# get course from url and activate the project
# set_project <- function(url_path, set_path) {
#
#   # usethis::create_project(dir)
#   rsetup::get_course(url_path, set_path)
#
#   usethis::proj_activate(set_path)
# }


set_project <- function(url_path, set_path) {
  # Check if .Rproj exists, otherwise download course

    rsetup::get_course(url_path, set_path)

  # Normalize paths for comparison
  current_path <- normalizePath(here::here(), winslash = "/", mustWork = FALSE)
  target_path  <- normalizePath(set_path, winslash = "/", mustWork = FALSE)

  if (current_path != target_path) {
    # If no project is currently active (blank RStudio), activate in new session
    if (is.null(usethis::proj_get(FALSE))) {
      usethis::proj_activate(set_path)
    } else {
      # Otherwise just switch project in the same session
      usethis::proj_set(set_path, force = TRUE)
    }
  } else {
    message("Project already active at: ", target_path)
  }
}



# get project path from user
set_path <- function() {
  if (.Platform$OS.type == "windows") {
    utils::choose.dir("", caption = "Choose a Suitable Folder")
    # choose.files()
  }

  else {
    rstudioapi::selectDirectory(
      caption = "Select Directory",
      label = "Select",
      path = ""
    )
  }
}

# install tinytex dependency for tinytex pdf
install_pdf <- function() {
  tinytex::install_tinytex(version = "latest")
}


# add local jobs using function
run_jobs <- function(){
  path <- file.choose()

  # path <- "C:\Users\m1s1n\Documents\R\r-course-2021\00_participants\00_getting_started\install_packages.R"
  rstudioapi::jobRunScript(path, importEnv = TRUE)
}
