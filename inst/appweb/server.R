# autor -------------------------------------------------------------------
# carlos.perez7@udea.edu.co
# 01/02/2019 9:26:08 a. m.
#
# NOTA: las inclusiones son relativas a la ubicion del archivo. "server.R"
source('include_server/utils_server.R', local=TRUE)

# INICIO SERVER
shinyServer(function(input, output, session) {
  #
  # NOTA1: Inicializa los listeners del paquete shinyhelper, para
  # asociar ayura en linea con ".md" files. Esto en la ubicacion
  # relativa al "server.R"; en el directorio: "/help_files/" (nombre por defecto).
  #
  observe_helpers(help_dir = "help_files")
  #
  source('include_server/coord-paralelas_densidad-2D.R', local=TRUE)
  source('include_server/distrib-estaciones-2D-server.R', local=TRUE)
  #
  # GRAFICOS DE SERIES - SINCRONIZADOS --------------------------------------
  # SE USA LA FUNCION source(..) con el acceso especifico al codigo fuente (tipo include de java)
  # es posible usar el acceso especifico $value, pero no afecta; funciona igual. En la interfaz
  # grafica UI si es necesario.
  source('include_server/graficos_series.R', local=TRUE)
  source('include_server/control-estacion-server.R', local=TRUE)
  source('include_server/control-dia-actual-online-server.R', local=TRUE)
  #
  ## ELEMENTOS DE AYUDA:
  output$basicsHelpText <- renderText( # La funcion renderText entrega el texto HTML, renderPrint tambien aplica
    paste0(tags$b("Proyecto:"),
       br(), "Red R\u00EDo",
       br(), tags$b("Facultad de Ingenier\u00EDa"),
       br(), "* Copyright \u00A9 2019 U. de A. *",
       hr(), img(src = "images/UdeA_Escudo.jpg"),
       hr(), "Estaciones en Tiempo Real",
       br(), "Red de monitoreo ambiental en la cuenca hidrogr\u00E1fica del R\u00EDo Aburr\u00E1 Medell\u00EDn"
    )
  )
  ## FIN AYUDA
  #
  # FINALIZACION DE SESION WEB ----------------------------------------------
  # Finaliza la ejecucion de la APP en R-Studio al cerrar la Ventana PPAL:
  session$onSessionEnded(function() {
    stopApp()
  })
  #
  ## FIN SERVER
})

