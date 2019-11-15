# autor -------------------------------------------------------------------
# carlos.perez7@udea.edu.co
# carlos.perezoft@gmail.com
# 25/10/2019 2:42:08 p. m.
# ***
# NUEVO: Tener en cuenta que el "x_tab" tiene un SOLO tabItem, esto debido a que la forma
# de procesamiento de R-Studio y Shiny generan error de ejecucion y/o compilacion
# ***
#
tabItem(tabName = "controlEstacionTab",
  h2("Hipercarta con control de Par\u00E1metros por estaci\u00F3n mensualmente."),
  wellPanel(style = "background: white",
     helpText("Clic y arrastrar para zoom in (doble clic para restaurar). An\u00E1lisis de un par\u00E1metro teniendo la Hipercarta como referencia."),
     # UTIL: El uso de box(..) evita mayor parametrizacion en el layout "fluidRow":
     fluidRow(
        box(title = "Hipercarta (Referencia)", status = "success", solidHeader = TRUE, collapsible = TRUE, width = 12,
          dropdownButton(tags$h3("Ajustes Hipercarta"),
             selectInput("hipercartaEstacionesSel", label = "Hipercarta", width="220px", # Para ajutar el ancho del Select!
                     choices=c("Conductividad"="MEDIA_Condu", "pH"="MEDIA_ph",
                               "Oxig. Disuelto"="MEDIA_od", "Turbiedad"="MEDIA_turb",
                               "Pot. Redox"="MEDIA_pot_redox", "Temperatura"="MEDIA_tempera"),
                     selected="MEDIA_Condu"),
             selectInput(inputId='hiperEstacionFiltroEstacion', label='Estaci\u00F3n',
                  choices=c("San Miguel"="1_SAN_MIGUEL", "Anc\u00F3n Sur"="2_ANCON_SUR", "Aula Ambiental"="3_AULA_AMBIENTAL"),
                  selected = "1_SAN_MIGUEL"),
             selectInput("hcEstacionesMes", label = "Mes", width="220px", # Para ajutar el ancho del Select!
                  choices = c("Enero"=1, "Febrero"=2, "Marzo"=3, "Abril"=4, "Mayo"=5, "Junio"=6,
                              "Julio"=7, "Agosto"=8, "Septiembre"=9, "Octubre"=10, "Noviembre"=11, "Diciembre"=12),
                  selected = 0, multiple = TRUE),
             sliderInput(inputId="hiperEstacionDiaMes", label = "D\u00EDa del Mes",
                         min=1, max=31, value=21),
             selectInput("hcEstacionesTipoCarta", label = "Presentar como", width="220px", # Para ajutar el ancho del Select!
                  choices = c("Cada Serie Independiente"="SERIE_IND", "Intervalo de Confianza"="INT_CONF"),
                  selected = "INT_CONF"),
             checkboxInput("hcEstacionesShowgridCheck", label = "Usar Grid", value = FALSE),
             tags$i("Actualizaci\u00F3n autom\u00E1tica..."),
             circle = TRUE, status = "danger", icon = icon("gear"), width = "250px",
             size = "xs", tooltip = tooltipOptions(title = "Ajustes Hipercarta...")
           ),
           dygraphOutput("hipercartaEstacionesPlot", width = "100%", height = "450") %>% withSpinner(type=4, color="cadetblue")
        )
     ) # end fluidrow
  )
)
# Este archivo es incluido en una seccion "body <- dashboardBody(..)" del "ui.R",
# por eso el cierre del tabItem no lleva coma ","
#
