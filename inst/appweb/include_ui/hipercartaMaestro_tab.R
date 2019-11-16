# autor -------------------------------------------------------------------
# carlos.perez7@udea.edu.co
# 01/02/2019 9:26:08 a. m.
# ***
# NUEVO: Tener en cuenta que el "x_tab" tiene un SOLO tabItem, esto debido a que la forma
# de procesamiento de R-Studio y Shiny generan error de ejecucion y/o compilacion
# ***
#
tabItem(tabName = "hipercartaMaestroTab",
  h2("Hipercartas para las Variables de an\u00E1lisis [De Julio a Agosto de 2018]."),
  dropdownButton(inputId = "mosaicoHiperOpsBtn",
     tags$h4("Opciones de Presentaci\u00F3n:"),
     selectInput("tipoSerie", label = "Presentar como", width="220px", # Para ajutar el ancho del Select!
                  choices = c("Cada Serie Independiente"="SERIE_IND", "Intervalo de Confianza"="INT_CONF"),
                  selected="INT_CONF"),
     checkboxInput("mosaicoShowGrid", label = "Usar Grid", value = FALSE),
     checkboxInput("mosaicoShowArea", label = "Usar \u00E1reas", value = FALSE),
     tags$i("Actualizaci\u00F3n autom\u00E1tica..."),
     circle = TRUE, status = "danger", icon = icon("gear"), width = "250px",
     size = "xs", tooltip = tooltipOptions(title = "Cambiar opciones...")
  ),
  wellPanel(style = "background: white",
     helpText("Clic y arrastrar para zoom in (doble clic para restaurar)."),
     fluidRow(
        column(width = 6, # 6 columnas por cada grafico, de 12 disponibles. Asi queda tipo mosaico 2x2.
          dygraphOutput("serieConductPlot") %>% withSpinner(type=4, color="cadetblue"),
          dygraphOutput("seriePHPlot") %>% withSpinner(type=4, color="cadetblue"),
          dygraphOutput("serieODPlot") %>% withSpinner(type=4, color="cadetblue")
        ),
        column(width = 6, # Usar 12 para visualizar todas de forma vertical. O quitar el fluidRow/column.
          dygraphOutput("serieTemperaPlot") %>% withSpinner(type=5, color="cadetblue"),
          dygraphOutput("serieTurbPlot") %>% withSpinner(type=5, color="cadetblue"),
          dygraphOutput("seriePotRedoxPlot") %>% withSpinner(type=5, color="cadetblue")
        )
     ) # end fluidrow
  )
)
# Este archivo es incluido en una seccion "body <- dashboardBody(..)" del "ui.R",
# por eso el cierre del tabItem no lleva coma ","
#
