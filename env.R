# Preparation de l'environnement

install.packages.manual <- function(PATH_to_Package.tar.gz)
{
  install.packages(PATH_to_Package.tar.gz, character.only=TRUE, repos = NULL, type="source")
}



librairies <-  c(
  "chron", "CDFt", "latex2exp", "lubridate","ncdf4", "PCICt", "qmap", "rWind",
  "MASS", "scales", "glue", "dplyr",  "purrr", "tidyverse", 
  "ggplot2", "stringr", "RColorBrewer", "data.table", "Metrics","car", "zoo", "extRemes",
  "gamlss", "gamlss.dist", "gamlss.add")


for (lib in librairies) 
{
  cat(lib, "...\n")
  if(require(lib, character.only=TRUE, quietly=TRUE))
  {
    cat(lib, " is loaded correctly ! \n")
  } else {
    cat("Trying to install ", lib, "\n")
    install.packages(lib)
    if(require(lib, character.only=TRUE, quietly=TRUE))
    {
      cat(lib, " installed and loaded ! \n")
    } else {
      stop("!!! could not install ", lib, " !!!")
    }
  }
  cat("\n")
}

install.packages.manual("ncdf4.helpers.tar.gz")
