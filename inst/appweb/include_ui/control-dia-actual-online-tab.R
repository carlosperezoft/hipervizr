# autor -------------------------------------------------------------------
# carlos.perez7@udea.edu.co
# carlos.perezoft@gmail.com
# 16/11/2019 11:32:08 a. m.
# ***
# NUEVO: Tener en cuenta que el "x_tab" tiene un SOLO tabItem, esto debido a que la forma
# de procesamiento de R-Studio y Shiny generan error de ejecucion y/o compilacion
# ***
#
tabItem(tabName = "controlDiaActualOnlineTab",
  h3("Hipercarta con control de Par\u00E1metros por D\u00EDa Actual - ONLINE."),
  wellPanel(style = "background: white",
     helpText("Clic y arrastrar para zoom in (doble clic para restaurar). An\u00E1lisis de un par\u00E1metro teniendo la Hipercarta como referencia."),
     # UTIL: El uso de box(..) evita mayor parametrizacion en el layout "fluidRow":
     fluidRow(
        box(title = "Hipercarta (Referencia)", status = "success", solidHeader = TRUE, collapsible = TRUE, width = 12,
          dropdownButton(tags$h3("Ajustes por Medici\u00F3n"),
             selectInput("hcDiaOnlineSel", label = "Par\u00E1metro", width="220px", # Para ajutar el ancho del Select!
                     choices=c("Conductividad"="MEDIA_Condu", "pH"="MEDIA_ph",
                               "Oxig. Disuelto"="MEDIA_od", "Turbiedad"="MEDIA_turb",
                               "Pot. Redox"="MEDIA_pot_redox", "Temperatura"="MEDIA_tempera"),
                     selected="MEDIA_Condu"),
             selectInput(inputId='hcDiaOnlineFiltroEstacion', label='Estaci\u00F3n-Hipercarta',
                  choices=c("San Miguel"="1_SAN_MIGUEL", "Anc\u00F3n Sur"="2_ANCON_SUR", "Aula Ambiental"="3_AULA_AMBIENTAL"),
                  selected = "1_SAN_MIGUEL"),
             selectInput("hcDiaOnlineTipoCarta", label = "Presentar como", width="220px", # Para ajutar el ancho del Select!
                  choices = c("Cada Serie Independiente"="SERIE_IND", "Intervalo de Confianza"="INT_CONF"),
                  selected = "INT_CONF"),
             checkboxInput("hcDiaOnlineShowgridCheck", label = "Usar Grid", value = FALSE),
             tags$i("Actualizaci\u00F3n autom\u00E1tica..."),
             circle = TRUE, status = "danger", icon = icon("gear"), width = "250px",
             size = "xs", tooltip = tooltipOptions(title = "Ajustes Hipercarta...")
           ),
           dygraphOutput("hcDiaOnlinePlot", width = "100%", height = "450") %>% withSpinner(type=4, color="cadetblue")
        )
     ) # end fluidrow
  )
)
# Este archivo es incluido en una seccion "body <- dashboardBody(..)" del "ui.R",
# por eso el cierre del tabItem no lleva coma ","
#
