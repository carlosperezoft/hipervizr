# autor -------------------------------------------------------------------
# carlos.perez7@udea.edu.co
# 21/07/2018 1:35:51 p. m.
#
# NOTA: Esta opcion de invicacion de menu de ayuda es generica usando el tipo
# predefinido de "notifications". Es limitado pues no permite usar un TAB panel o una OututUI.
# -- Se puede en su defecto invocar una pagina HTML externa con el window.open(..).
# -- Tambien se puede invocar un elemento en "localhost" ubicado en la carpeta "www" de la
#    la aplicacion WEB Shiny dashboard (en este caso se probo con /ayuda/*)
#
msgHelpMenu <- dropdownMenu(
  type = "notifications",
  icon = icon("question-circle"),
  badgeStatus = NULL,
  headerText = "AYUDA GENERAL HIPERVIZ-R:",

  notificationItem("Gu\u00EDa de Uso", icon = icon("question-circle"),
        href = "javascript:window.open('/ayuda/hipervizr-intro.html', '_blank')"),
  notificationItem("SALIR...", icon = icon("gear"),
                   href = "javascript:setTimeout(function(){window.close();},500);")

)
