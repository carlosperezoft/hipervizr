# autor -------------------------------------------------------------------
# carlos.perez7@udea.edu.co
# 01/02/2019 9:26:08 a. m.
# ***
# NUEVO: Tener en cuenta que el "x_tab" tiene un SOLO tabItem, esto debido a que la forma
# de procesamiento de R-Studio y Shiny generan error de ejecucion y/o compilacion
# ***
#
tabItem(tabName = "cartaControlDetalle",
  h2("Hiper Carta con detalle de Cartas de Control [Estaciones de Medici\u00F3n]"),
  wellPanel(style = "background: white",
     helpText("Clic y arrastrar para zoom in (doble clic para restaurar)."),
     # UTIL: El uso de box(..) evita mayor parametrizacion en el layout "fluidRow":
     fluidRow(
        box(title = "Hipercarta (General)", status = "primary", solidHeader = TRUE, collapsible = TRUE,
          dropdownButton(tags$h3("Ajustes Hipercarta"),
             selectInput("ccTipoCarta", label = "Tipo de Serie a Presentar", width="220px", # Para ajutar el ancho del Select!
                  choices = c("Cada Serie Independiente", "Intervalo de Confianza"),
                  selected = "Intervalo de Confianza"),
             checkboxInput("ccShowgridCheck", label = "Usar Grid", value = FALSE),
             circle = TRUE, status = "danger", icon = icon("gear"), width = "250px",
             size = "xs", tooltip = tooltipOptions(title = "Ajustes Hipercarta...")
           ),
           dygraphOutput("hipercartaBasePlot", width = "100%", height = "450") %>% withSpinner(type=4, color="cadetblue")
        ),
        box(title = "Carta de Control (Detalle)", status = "success", solidHeader = TRUE, collapsible = TRUE,
           dropdownButton(tags$h3("Ajustes Carta de Control"),
             selectInput("ccTipoDia", label = "Tipo de D\u00EDa", width="220px", # Para ajutar el ancho del Select!
                  choices = c("Todos"=0, "T\u00EDpico Laboral"=1, "S\u00E1bado"=2, "Domingo-Festivo"=3),
                  selected = 0),
             selectInput("ccMes", label = "Mes", width="220px", # Para ajutar el ancho del Select!
                  choices = c("Todos"=0, "Enero"=1, "Febrero"=2, "Marzo"=3, "Abril"=4, "Mayo"=5, "Junio"=6,
                                         "Julio"=7, "Agosto"=8, "Septiembre"=9, "Octubre"=10, "Noviembre"=11, "Diciembre"=12),
                  selected = 0),
             selectInput("ccDiaSemana", label = "D\u00EDa de Semana", width="220px", # Para ajutar el ancho del Select!
                  choices = c("Todos"=0, "Lunes"=1, "Martes"=2, "Mi\u00E9rcoles"=3,
                                         "Jueves"=4, "Viernes"=5, "S\u00E1bado"=6, "Domingo"=7),
                  selected = 0),
             circle = TRUE, status = "danger", icon = icon("gear"), width = "250px",
             size = "xs", tooltip = tooltipOptions(title = "Ajustes Carta de Control...")
           ),
           dygraphOutput("cartaControlSSTPlot", width = "100%", height = "450") %>% withSpinner(type=5, color="cadetblue")
       )
     ) # end fluidrow
  )
)
# Este archivo es incluido en una seccion "body <- dashboardBody(..)" del "ui.R",
# por eso el cierre del tabItem no lleva coma ","
#
