# autor -------------------------------------------------------------------
# carlos.perez7@udea.edu.co
# 01/02/2019 9:26:08 a. m.
#
# Inclusion de la librerias propias para la ejecucion de la aplicacion
# Shiny WEB hipervizr:
#
# Se inicializa esta variable de entorno en R-Studio para que permita un tope maximo
# de DLLs (WINDOWS) cargadas por Session LOCAL de R:
Sys.setenv(R_MAX_NUM_DLLS = 512)
#
suppressPackageStartupMessages({
  library(shinydashboard, quietly=TRUE)
  library(shinycssloaders, quietly=TRUE)
  library(shinyWidgets, quietly=TRUE)
  library(shinyhelper, quietly=TRUE)
  library(shinyBS, quietly=TRUE)
  library(markdown, quietly=TRUE)
  library(htmlwidgets, quietly=TRUE)
  library(dplyr, quietly=TRUE)
  library(reshape2, quietly=TRUE)
  library(RColorBrewer, quietly=TRUE)
  library(jsonlite, quietly=TRUE)
  library(plotly, quietly=TRUE)
  library(ggplot2, quietly=TRUE)
  library(parcoords, quietly=TRUE)
  library(dygraphs, quietly=TRUE)
  library(readxl, quietly=TRUE)
  library(corrplot, quietly=TRUE)
  library(qgraph, quietly=TRUE)
})
#
## Cargar las funciones propias del paquete semviz ubicadas en /R dir base:
#
for (file in list.files(system.file("R", package = "hipervizr"), pattern = "\\.(r|R)$", full.names = TRUE)) {
  source(file, local = TRUE)
}
#
# Se especifica el numero de digitos por defecto al visualizar datos numericos
# NOTA: El valor de 4 conserva el estandar de lavaan en los datos numericos.
options(digits=4)
#
# Se establece el tema de fondo por defecto para los graficos con ggplot:
theme_set(theme_bw())  # tema black_white !
#
