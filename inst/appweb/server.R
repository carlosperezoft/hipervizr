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

  # COORDENADAS PARALELAS ---------------------------------------------------
  output$iris_pairs <- renderPlot({
    rows <- rownames(iris)

    # example from ?pairs
    pairs(
      iris[rows,-5]
      , main = "Anderson's Iris Data -- 3 species"
      , pch = 21
      , bg = RColorBrewer::brewer.pal(3,'Set1')[unclass(iris[rows,]$Species)]
    )
  })

  output$paralCoordsPlot <- renderParcoords({
    tryCatch({
      pc <- parcoords(reorderable = TRUE,
        iris[,c(5,1:4)]  # order columns so species first
        , rownames=F
        , brushMode="1d"
        , color = list(
          colorScale = htmlwidgets::JS(sprintf(
            'd3.scale.ordinal().range(%s).domain(%s)'
            ,jsonlite::toJSON(RColorBrewer::brewer.pal(3,'Set1'))
            ,jsonlite::toJSON(as.character(unique(iris$Species)))
          ))
          ,colorBy = "Species"
        )
      )
    },
    error = function(e) {
      print(sprintf("Inner error: %s", e))
    },
    warning = function(e) {
      print(sprintf("Inner warning: %s", e))
    },
    finally = {
      print(sprintf("Inner tryCatch all done, result is %s", "EJECUCION EXITOSA!"))
    })
  })

  # GRAFICOS DE SERIES - SINCRONIZADOS --------------------------------------
  # SE USA LA FUNCION source(..) con el acceso especifico al codigo fuente (tipo include de java)
  # es posible usar el acceso especifico $value, pero no afecta; funciona igual. En la interfaz
  # grafica UI si es necesario.
  source('include_server/graficos_series.R', local=TRUE)

  ## ELEMENTOS DE AYUDA:
  output$basicsHelpText <- renderText( # La funcion renderText entrega el texto HTML, renderPrint tambien aplica
    paste0(tags$b("Autor:"), # la funcion paste0, concatena cada renglon, sin espacios entre cada cadena
       br(), "Carlos Alberto Pérez Moncada",
       br(), tags$b("Correo electr\u00F3nico:"),
       br(), tags$a("carlos.perez7@udea.edu.co", # NO usar el atributo "title="impide que se active el link!
                    href= "https://www.linkedin.com/in/carlos-alberto-perez-moncada-07b6b630/",
                    target="_blank",icon("linkedin-square", "fa-2x")), br(),
       br(), tags$b("Director del Proyecto: Juan Delgado Lastra"),
       br(), tags$b("Programa: Maestría en Ingeniería con énfasis en Informática"),
       hr(), tags$a(tags$b("AYUDA localhost..."), # NO usar el atributo "title="impide que se active el link!
                    href = "/ayuda/rmarkdown_test.html", target = "_blank",
                    # NO usar el atributo "icon=" explicitamente, impide que se active el icono!
                    icon("question-circle")),
       br() # Es necesario agregar un elemento HTML final para que el link sea presentado!
    )
  )
  ## FIN AYUDA

  # Elementos graficos en PLOTLY JS (GGPLOT2)
  source('include_server/mosaico_plotly_server.R', local=TRUE)
  # FIN QGRAPH

  # FINALIZACION DE SESION WEB ----------------------------------------------
  # Finaliza la ejecucion de la APP en R-Studio al cerrar la Ventana PPAL:
  session$onSessionEnded(function() {
    stopApp()
  })
  #
  ## FIN SERVER
})

