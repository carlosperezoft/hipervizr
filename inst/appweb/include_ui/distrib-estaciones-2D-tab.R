# autor -------------------------------------------------------------------
# carlos.perezoft@gmail.com
# 23/10/2019 21:16:08 p. m.
#
tabItem(tabName="distrib-estaciones-2DTab",
   h3("An\u00E1lisis comparativo por estaci\u00F3n para par\u00E1metros medidos durante un Mes"),
   navbarPage(tags$b("Descriptivo-2D"),
     navbarMenu("Distribuci\u00F3n Estaciones",
        tabPanel("Box Plot", icon = icon("cube"),
           helpText("An\u00E1lisis tipo Box-Plot. Compara el par\u00E1metro seleccionado para las estaciones especificadas."),
           bsPopover(id="boxplotEstacionesPlot", title="Box-Plot", placement = "top", trigger = "hover",
                     content=paste("Se presentan: los valores, la media y la desviaci\u00F3n est\u00E1ndar punteadas.",
                                   "Clic en el nombre de la Estaci\u00F3n para activar/desactivar su box-plot.")),
           dropdownButton(inputId = "boxplotEstacionesOpsBtn",
              tags$h4("Opciones de Presentaci\u00F3n:"),
              selectInput("boxplotEstacionesParam", label = "Par\u00E1metro", width="220px", # Para ajutar el ancho del Select!
                     choices=c("Conductividad"="MEDIA_Condu", "pH"="MEDIA_ph",
                               "Oxig. Disuelto"="MEDIA_od", "Turbiedad"="MEDIA_turb",
                               "Pot. Redox"="MEDIA_pot_redox", "Temperatura"="MEDIA_tempera"),
                     selected="MEDIA_Condu"),
              sliderTextInput(inputId = "boxplotEstacDiaMes", label = "D\u00EDa del Mes (T: todos)",
                   choices = c("T", seq(1:31)), grid = TRUE),
              selectInput("boxplotEstacDiaSem", label = "D\u00EDa de Semana", width="220px", # Para ajutar el ancho del Select!
                  choices = c("Lunes"=1, "Martes"=2, "Mi\u00E9rcoles"=3,
                                         "Jueves"=4, "Viernes"=5, "S\u00E1bado"=6, "Domingo"=7),
                  selected = 0, multiple = TRUE),
              awesomeCheckbox(inputId = "boxplotEstacionPtosCheck",
                          label = "Ver Puntos de Media", value = FALSE, status = "success"),
              tags$i("Actualizaci\u00F3n autom\u00E1tica..."),
              circle = TRUE, status = "danger", icon = icon("gear"), width = "250px",
              size = "xs", tooltip = tooltipOptions(title = "Cambiar opciones...")
           ),
           plotlyOutput("boxplotEstacionesPlot", width = "100%", height = "500px") %>% withSpinner(type=5, color="cadetblue")
        ),
        tabPanel("Distribuci\u00F3n de Densidad", icon = shiny::icon("stats", lib = "glyphicon"),
           helpText("Distribuci\u00F3n de Densidad (suavizado). Compara el par\u00E1metro seleccionado para las estaciones especificadas."),
           dropdownButton(inputId = "densidadEstacionOpsBtn",
              tags$h4("Opciones de Presentaci\u00F3n:"),
              selectInput("densidadEstacionesParam", label = "Par\u00E1metro", width="220px", # Para ajutar el ancho del Select!
                     choices=c("Conductividad"="MEDIA_Condu", "pH"="MEDIA_ph",
                               "Oxig. Disuelto"="MEDIA_od", "Turbiedad"="MEDIA_turb",
                               "Pot. Redox"="MEDIA_pot_redox", "Temperatura"="MEDIA_tempera"),
                     selected="MEDIA_Condu"),
              sliderTextInput(inputId = "densidadEstacDiaMes", label = "D\u00EDa del Mes (T: todos)",
                   choices = c("T", seq(1:31)), grid = TRUE),
              selectInput("densidadEstacDiaSem", label = "D\u00EDa de Semana", width="220px", # Para ajutar el ancho del Select!
                  choices = c("Lunes"=1, "Martes"=2, "Mi\u00E9rcoles"=3,
                                         "Jueves"=4, "Viernes"=5, "S\u00E1bado"=6, "Domingo"=7),
                  selected = 0, multiple = TRUE),
              tags$i("Actualizaci\u00F3n autom\u00E1tica..."),
              circle = TRUE, status = "danger", icon = icon("gear"), width = "250px",
              size = "xs", tooltip = tooltipOptions(title = "Cambiar opciones...")
           ),
           plotlyOutput("distriDensiEstacionesPlot", width = "100%", height = "500px") %>% withSpinner(type=4, color="cadetblue")
        ),
        tabPanel("Viol\u00EDn", icon = icon("music", lib = "glyphicon"),
           helpText("An\u00E1lisis tipo Viol\u00EDn. Compara el par\u00E1metro seleccionado para las estaciones especificadas"),
           bsPopover(id="violinEstacionesPlot", title="Viol\u00EDn-Plot", placement = "top", trigger = "hover",
                     content="Se presenta: Un Box-Plot enmarcado con una distribuci\u00F3n de densidad suavizada (Kernel Density)."),
           dropdownButton(inputId = "violinEstacionesOpsBtn",
              tags$h4("Opciones de Presentaci\u00F3n:"),
              selectInput("violinEstacionesParam", label = "Par\u00E1metro", width="220px", # Para ajutar el ancho del Select!
                     choices=c("Conductividad"="MEDIA_Condu", "pH"="MEDIA_ph",
                               "Oxig. Disuelto"="MEDIA_od", "Turbiedad"="MEDIA_turb",
                               "Pot. Redox"="MEDIA_pot_redox", "Temperatura"="MEDIA_tempera"),
                     selected="MEDIA_Condu"),
              sliderTextInput(inputId = "violinEstacDiaMes", label = "D\u00EDa del Mes (T: todos)",
                   choices = c("T", seq(1:31)), grid = TRUE),
              selectInput("violinEstacDiaSem", label = "D\u00EDa de Semana", width="220px", # Para ajutar el ancho del Select!
                  choices = c("Lunes"=1, "Martes"=2, "Mi\u00E9rcoles"=3,
                                         "Jueves"=4, "Viernes"=5, "S\u00E1bado"=6, "Domingo"=7),
                  selected = 0, multiple = TRUE),
              tags$i("Actualizaci\u00F3n autom\u00E1tica..."),
              circle = TRUE, status = "danger", icon = icon("gear"), width = "250px",
              size = "xs", tooltip = tooltipOptions(title = "Cambiar opciones...")
           ),
           plotlyOutput("violinEstacionesPlot", width = "100%", height = "500px") %>% withSpinner(type=5, color="cadetblue")
        )
     ) #,
     # tabPanel("Contornos", icon = icon("paperclip"),
     #    helpText("An\u00E1lisis por medio de contornos (Densidad 2D)."),
     #    dropdownButton(inputId = "contornoMedidaOpsBtn",
     #      tags$h4("Opciones de Presentaci\u00F3n:"),
     #      # Nota: En el listado de choices se usa una lista c("label"="id_txt"). En el server el input entrega el "id_txt".
     #      selectInput("contornoEjeXHipercarta", label = "Hipercarta eje X", width="220px", # Para ajutar el ancho del Select!
     #              choices=c("t sub-j"="id_t", "Conductividad"="MEDIA_Condu", "pH"="MEDIA_ph",
     #                        "Oxig. Disuelto"="MEDIA_od", "Turbiedad"="MEDIA_turb",
     #                        "Pot. Redox"="MEDIA_pot_redox", "Temperatura"="MEDIA_tempera"),
     #              selected="id_t"),
     #      selectInput("contornoEjeYHipercarta", label = "Hipercarta eje Y", width="220px", # Para ajutar el ancho del Select!
     #              choices=c("Conductividad"="MEDIA_Condu", "pH"="MEDIA_ph",
     #                        "Oxig. Disuelto"="MEDIA_od", "Turbiedad"="MEDIA_turb",
     #                        "Pot. Redox"="MEDIA_pot_redox", "Temperatura"="MEDIA_tempera"),
     #              selected="MEDIA_Condu"),
     #      selectInput(inputId='contornoMedidaMethod', label='Estilo de Representaci\u00F3n',
     #                  choices=c("Poligono", "Contorno", "Espectral"), selected = "Espectral"),
     #      awesomeCheckbox(inputId = "contornoMedidaPuntosCheck",
     #                      label = "Ver Puntos de Media", value = FALSE, status = "success"),
     #      tags$i("Actualizaci\u00F3n autom\u00E1tica..."),
     #      circle = TRUE, status = "danger", icon = icon("gear"), width = "250px",
     #      size = "xs", tooltip = tooltipOptions(title = "Cambiar opciones...")
     #    ),
     #    plotlyOutput("contornosDensidadPlot", width = "100%", height = "500px") %>% withSpinner(type=4, color="cadetblue")
     # ),
     # navbarMenu("Correlaci\u00F3n",
     #    tabPanel("Correlograma", icon = icon("th-large"),
     #       helpText("An\u00E1lisis por medio de Correlograma."),
     #       dropdownButton(inputId = "correlogramaOpsBtn",
     #          tags$h4("Opciones de Presentaci\u00F3n:"),
     #          selectInput(inputId = 'correlogramaMethod', label = 'Estilo de Representaci\u00F3n',
     #             choices = c("C\u00EDrculo"="circle","Cuadrado"="square",
     #                "Elipse"="ellipse","Num\u00E9rico"="number","Torta"="pie"),
     #             selected = "circle"),
     #          selectInput(inputId = 'correlogramaSection', label = 'Ver Secci\u00F3n',
     #             choices = c("Completo"="full","Inferior"="lower","Superior"="upper"), selected = "upper"),
     #          awesomeCheckbox(inputId = "correlogramaCoefCheck",
     #                      label = "Ver Coeficientes", value = FALSE, status = "success"),
     #          tags$i("Actualizaci\u00F3n autom\u00E1tica..."),
     #          circle = TRUE, status = "danger", icon = icon("gear"), width = "250px",
     #          size = "xs", tooltip = tooltipOptions(title = "Cambiar opciones...")
     #       ),
     #       # IMPORTANTE: corrplot genera un grafico estandar para el cual plotly no tiene WRAPPER...
     #       plotOutput("correlogramaPlotOut", width = "100%", height = "500") %>% withSpinner(type=5, color="cadetblue")
     #    )
     #)
  ) # FIN navbarPage
)
#
