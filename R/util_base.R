# autor -------------------------------------------------------------------
# carlos.perez7@udea.edu.co
# 01/02/2019 9:48:36 a. m.
# launchApp
# Funcion de prueba para ejecutar la app web R-Shiny
#
launchApp <- function() {
  ## NOTA: Se pueden inicializar las propiedades de ejecucion
  ## dese la consola de R, esto deja las opciones a nivel GLOBAL en la instancia de R.
  options(shiny.launch.browser = TRUE)
  options(shiny.host = "127.0.0.1")
  options(shiny.port = 9090)
  #
  # NOTA: De manera directa en la invocacion se pueden usar en el runApp(..)
  shiny::runApp(appDir = system.file("appweb", package = "hipervizr"),
                launch.browser = TRUE, host = "127.0.0.1", port = 9090)
}
