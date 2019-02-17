# autor -------------------------------------------------------------------
# carlos.perez7@udea.edu.co
# 01/02/2019 9:26:08 a. m.
# ***
# NUEVO: Tener en cuenta que el "x_tab" tiene un SOLO tabItem, esto debido a que la forma
# de procesamiento de R-Studio y Shiny generan error de ejecucion y/o compilacion
# ***
#
tabItem(tabName = "hipercartaMaestro",
  h2("Cartas Variable-Total-Variable [Hipercarta]"),
  wellPanel(style = "background: white",
     helpText("Clic y arrastrar para zoom in (doble clic para restaurar)."),
     fluidRow(
        column(width = 6, # 6 columnas por cada grafico, de 12 disponibles. Asi queda tipo mosaico 2x2.
          dygraphOutput("serieBaseHiperPlot") %>% withSpinner(type=4, color="cadetblue"),
          dygraphOutput("serieSSTHiperPlot") %>% withSpinner(type=5, color="cadetblue")
        ),
        column(width = 6, # Usar 12 para visualizar todas de forma vertical. O quitar el fluidRow/column.
          dygraphOutput("serieConductHiperPlot") %>% withSpinner(type=4, color="cadetblue"),
          dygraphOutput("serieTemperaHiperPlot") %>% withSpinner(type=5, color="cadetblue")
        )
     ) # end fluidrow
  ),
  wellPanel(style = "background: white", helpText("Datos Seleccionados Hipercarta"),
    fluidRow(
       box(title = "Opciones Hipercarta", status = "primary", solidHeader = TRUE, collapsible = TRUE,
         selectInput("tipoSerie", label = "Tipo de Serie a Presentar", width="220px", # Para ajutar el ancho del Select!
                     choices = c("Cada Serie Independiente", "Intervalo de Confianza"),
                     selected = "Intervalo de Confianza"),
         checkboxInput("showgrid", label = "Usar Grid", value = TRUE)
       ),
       box(title = "Opciones Hipercarta", status = "success", solidHeader = TRUE, collapsible = TRUE,
         div(strong("Desde: "), textOutput("dySerieFrom", inline = TRUE)),
         div(strong("Hasta: "), textOutput("dySerieTo", inline = TRUE)),
         div(strong("t-seleccionado: "), textOutput("dySerieClicked", inline = TRUE)),
         div(strong("SST_tr Punto Seleccionado: "), textOutput("dySeriePoint", inline = TRUE))
       )
    ) # end fluidRow
  )
)
# Este archivo es incluido en una seccion "body <- dashboardBody(..)" del "ui.R",
# por eso el cierre del tabItem no lleva coma ","
#
