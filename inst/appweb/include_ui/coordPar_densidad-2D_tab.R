# autor -------------------------------------------------------------------
# carlos.perez7@udea.edu.co
# 11/03/2019 22:37:08 p. m.
#
tabItem(tabName="coordPar_densidad-2DTab",
   h3("An\u00E1lisis Descriptivo usando las medias de las Hipercartas [De Julio a Agosto de 2018]."),
   navbarPage(tags$b("Descriptivo-2D"),
      tabPanel("Patrones", icon = icon("gg"),
         helpText(paste("Brushing: clic y arrastar sobre un eje (un clic para restaurar). Ordenar: doble clic sobre una variable.",
                  "Intercambiar: clic sobre una variable y arrastrar hacia los lados.")),
          # El atributo "with" del box(..) usa el valro entero 1->12 columnas (12->100%).
          box(title="Coordenadas Paralelas - Hipercartas", status="success", solidHeader=TRUE, collapsible=TRUE, width=12,
             parcoordsOutput("paralCoordsPlot", height="500px", width="100%" ) %>% withSpinner(type=5, color="cadetblue") %>%
             helper(type = "markdown", title = "HIPERVIZ-R: Coordenadas Paralelas", colour = "red",
                    content = "paralelasMediasPlot_help", size = "m") # size: define el ancho (s,m,l) del "popup"
          )
      ),
     navbarMenu("Distribuci\u00F3n",
        tabPanel("Box Plot", icon = icon("cube"),
           helpText("An\u00E1lisis por medio del esquema Box-Plot. Se usa una media a la vez debido a la diferencia entre escalas."),
           bsPopover(id="boxplotDensidadPlot", title="Box-Plot", placement = "top", trigger = "hover",
                     content="Se presentan: los valores, la media y la desviaci\u00F3n est\u00E1ndar punteadas."),
           dropdownButton(inputId = "boxplotMedidaOpsBtn",
              tags$h4("Opciones de Presentaci\u00F3n:"),
              selectInput("boxplotMediaHiper", label = "Hipercarta", width="220px", # Para ajutar el ancho del Select!
                     choices=c("Conductividad"="MEDIA_Condu", "pH"="MEDIA_ph",
                               "Oxig. Disuelto"="MEDIA_od", "Turbiedad"="MEDIA_turb",
                               "Pot. Redox"="MEDIA_pot_redox", "Temperatura"="MEDIA_tempera"),
                     selected="MEDIA_Condu"),
              awesomeCheckbox(inputId = "boxplotMediaPuntosCheck",
                          label = "Ver Puntos de Media", value = FALSE, status = "success"),
              tags$i("Actualizaci\u00F3n autom\u00E1tica..."),
              circle = TRUE, status = "danger", icon = icon("gear"), width = "250px",
              size = "xs", tooltip = tooltipOptions(title = "Cambiar opciones...")
           ),
           plotlyOutput("boxplotDensidadPlot", width = "100%", height = "500px") %>% withSpinner(type=5, color="cadetblue")
        ),
        tabPanel("Distribuci\u00F3n de Densidad", icon = shiny::icon("stats", lib = "glyphicon"),
           helpText("Distribuci\u00F3n de Densidad para las medias (suavizado).Se usa una media a la vez debido a la diferencia entre escalas."),
           dropdownButton(inputId = "densidadMedidaOpsBtn",
              tags$h4("Opciones de Presentaci\u00F3n:"),
              selectInput("densidadMediaHiper", label = "Hipercarta", width="220px", # Para ajutar el ancho del Select!
                     choices=c("Conductividad"="MEDIA_Condu", "pH"="MEDIA_ph",
                               "Oxig. Disuelto"="MEDIA_od", "Turbiedad"="MEDIA_turb",
                               "Pot. Redox"="MEDIA_pot_redox", "Temperatura"="MEDIA_tempera"),
                     selected="MEDIA_Condu"),
              tags$i("Actualizaci\u00F3n autom\u00E1tica..."),
              circle = TRUE, status = "danger", icon = icon("gear"), width = "250px",
              size = "xs", tooltip = tooltipOptions(title = "Cambiar opciones...")
           ),
           plotlyOutput("distribucionDensidadPlot", width = "100%", height = "500px") %>% withSpinner(type=4, color="cadetblue")
        ),
        tabPanel("Dispersi\u00F3n - Regresi\u00F3n", icon = icon("random"),
           helpText("Dispersi\u00F3n - Regresi\u00F3n para las medias (suavizado).Se usa una media a la vez debido a la diferencia entre escalas."),
           dropdownButton(inputId = "disperRegreMedidaOpsBtn",
              tags$h4("Opciones de Presentaci\u00F3n:"),
              selectInput("disperRegreMediaHiper", label = "Hipercarta", width="220px", # Para ajutar el ancho del Select!
                     choices=c("Conductividad"="MEDIA_Condu", "pH"="MEDIA_ph",
                               "Oxig. Disuelto"="MEDIA_od", "Turbiedad"="MEDIA_turb",
                               "Pot. Redox"="MEDIA_pot_redox", "Temperatura"="MEDIA_tempera"),
                     selected="MEDIA_Condu"),
              tags$i("Actualizaci\u00F3n autom\u00E1tica..."),
              circle = TRUE, status = "danger", icon = icon("gear"), width = "250px",
              size = "xs", tooltip = tooltipOptions(title = "Cambiar opciones...")
           ),
           plotlyOutput("disperRegrePlot", width = "100%", height = "500px") %>% withSpinner(type=5, color="cadetblue")
        ),
        tabPanel("Viol\u00EDn", icon = icon("music", lib = "glyphicon"),
           helpText("An\u00E1lisis por medio del esquema Viol\u00EDn. Se usa una media a la vez debido a la diferencia entre escalas."),
           bsPopover(id="violinDensidadPlot", title="Viol\u00EDn-Plot", placement = "top", trigger = "hover",
                     content="Se presenta: Un Box-Plot enmarcado con una distribuci\u00F3n de densidad suavizada (Kernel Density)."),

           dropdownButton(inputId = "violinMedidaOpsBtn",
              tags$h4("Opciones de Presentaci\u00F3n:"),
              selectInput("violinMediaHiper", label = "Hipercarta", width="220px", # Para ajutar el ancho del Select!
                     choices=c("Conductividad"="MEDIA_Condu", "pH"="MEDIA_ph",
                               "Oxig. Disuelto"="MEDIA_od", "Turbiedad"="MEDIA_turb",
                               "Pot. Redox"="MEDIA_pot_redox", "Temperatura"="MEDIA_tempera"),
                     selected="MEDIA_Condu"),
              tags$i("Actualizaci\u00F3n autom\u00E1tica..."),
              circle = TRUE, status = "danger", icon = icon("gear"), width = "250px",
              size = "xs", tooltip = tooltipOptions(title = "Cambiar opciones...")
           ),
           plotlyOutput("violinDensidadPlot", width = "100%", height = "500px") %>% withSpinner(type=5, color="cadetblue")
        )
     ),
     tabPanel("Contornos", icon = icon("paperclip"),
        helpText("An\u00E1lisis por medio de contornos (Densidad 2D)."),
        dropdownButton(inputId = "contornoMedidaOpsBtn",
          tags$h4("Opciones de Presentaci\u00F3n:"),
          # Nota: En el listado de choices se usa una lista c("label"="id_txt"). En el server el input entrega el "id_txt".
          selectInput("contornoEjeXHipercarta", label = "Hipercarta eje X", width="220px", # Para ajutar el ancho del Select!
                  choices=c("t sub-j"="id_t", "Conductividad"="MEDIA_Condu", "pH"="MEDIA_ph",
                            "Oxig. Disuelto"="MEDIA_od", "Turbiedad"="MEDIA_turb",
                            "Pot. Redox"="MEDIA_pot_redox", "Temperatura"="MEDIA_tempera"),
                  selected="id_t"),
          selectInput("contornoEjeYHipercarta", label = "Hipercarta eje Y", width="220px", # Para ajutar el ancho del Select!
                  choices=c("Conductividad"="MEDIA_Condu", "pH"="MEDIA_ph",
                            "Oxig. Disuelto"="MEDIA_od", "Turbiedad"="MEDIA_turb",
                            "Pot. Redox"="MEDIA_pot_redox", "Temperatura"="MEDIA_tempera"),
                  selected="MEDIA_Condu"),
          selectInput(inputId='contornoMedidaMethod', label='Estilo de Representaci\u00F3n',
                      choices=c("Poligono", "Contorno", "Espectral"), selected = "Espectral"),
          awesomeCheckbox(inputId = "contornoMedidaPuntosCheck",
                          label = "Ver Puntos de Media", value = FALSE, status = "success"),
          tags$i("Actualizaci\u00F3n autom\u00E1tica..."),
          circle = TRUE, status = "danger", icon = icon("gear"), width = "250px",
          size = "xs", tooltip = tooltipOptions(title = "Cambiar opciones...")
        ),
        plotlyOutput("contornosDensidadPlot", width = "100%", height = "500px") %>% withSpinner(type=4, color="cadetblue")
     ),
     navbarMenu("Correlaci\u00F3n",
        tabPanel("Correlograma", icon = icon("th-large"),
           helpText("An\u00E1lisis por medio de Correlograma."),
           dropdownButton(inputId = "correlogramaOpsBtn",
              tags$h4("Opciones de Presentaci\u00F3n:"),
              selectInput(inputId = 'correlogramaMethod', label = 'Estilo de Representaci\u00F3n',
                 choices = c("C\u00EDrculo"="circle","Cuadrado"="square",
                    "Elipse"="ellipse","Num\u00E9rico"="number","Torta"="pie"),
                 selected = "circle"),
              selectInput(inputId = 'correlogramaSection', label = 'Ver Secci\u00F3n',
                 choices = c("Completo"="full","Inferior"="lower","Superior"="upper"), selected = "upper"),
              awesomeCheckbox(inputId = "correlogramaCoefCheck",
                          label = "Ver Coeficientes", value = FALSE, status = "success"),
              tags$i("Actualizaci\u00F3n autom\u00E1tica..."),
              circle = TRUE, status = "danger", icon = icon("gear"), width = "250px",
              size = "xs", tooltip = tooltipOptions(title = "Cambiar opciones...")
           ),
           # IMPORTANTE: corrplot genera un grafico estandar para el cual plotly no tiene WRAPPER...
           plotOutput("correlogramaPlotOut", width = "100%", height = "500") %>% withSpinner(type=5, color="cadetblue")
        ),
        tabPanel("Red de Correlaci\u00F3n",icon = icon("connectdevelop"),
          helpText("Red de Correlaci\u00F3n (an\u00E1lisis exploratorio/confirmatorio para las medias)."),
          dropdownButton(inputId = "corrnetOpsBtn",
             tags$h4("Opciones de Presentaci\u00F3n:"),
             selectInput(inputId = 'corrnetLayout', label = 'Estilo de Representaci\u00F3n',
                         choices = c("C\u00EDrculo"="circle","Grupos"="groups","Tipo Spring"="spring"), selected = "spring"),
             selectInput(inputId = 'corrnetGraph', label = 'M\u00E9todo de Optimizaci\u00F3n',
                         choices = c("Ninguno"="Ninguno","Asociaci\u00F3n"="assosciation",
                                     "Concentraci\u00F3n"="concentration","Tipo Graphical LASSO"="glasso"), selected = "Ninguno"),
             tags$i("Actualizaci\u00F3n autom\u00E1tica..."),
             circle = TRUE, status = "danger", icon = icon("gear"), width = "250px",
             size = "xs", tooltip = tooltipOptions(title = "Cambiar opciones...")
          ),
          plotOutput("corrnetPlotOut", width = "600", height = "600") %>%
                      withSpinner(type=4, color="cadetblue") %>%
          helper(type = "markdown", title = "SEMVIZ: Red de Correlaci\u00F3n", colour = "red",
                 content = "redCorrelacionPlot_help", size = "m") # size: define el ancho (s,m,l) del "popup"
        ),
        tabPanel("Diagrama de Cuerdas", icon = icon("life-ring"),
          h4("Diagrama de Cuerdas (visi\u00F3n circular de la correlaciones entre los par\u00E1metros)."),
          plotOutput("cuerdasCorrPlotOut", width = "700", height = "700") %>% withSpinner(type=5, color="cadetblue"),
          helpText("[El color rojo/verde y el ancho de la cuerda indica una correlaci\u00F3n negativa/positiva y su magnitud].")
        ),
        tabPanel("Matriz de Dispersi\u00F3n (SPLOM)",icon = icon("th"), h4("Matriz de Dispersi\u00F3n (SPLOM)"),
          plotlyOutput("splomCorrPlotOut", width = "100%", height = "800") %>% withSpinner(type=4, color="cadetblue"),
          helpText("[La diagonal principal presenta la distribuci\u00F3n de desidad de cada par\u00E1metro].")
        ),
        tabPanel("Barras",icon = icon("signal"), h4("Barras"),
             dropdownButton(inputId = "barrasCorrOpsBtn",
                tags$h4("Opciones de Presentaci\u00F3n:"),
                materialSwitch(inputId = "barrasCorrSortCheck", label = "Ordenar Valores",
                               value = FALSE, status = "info", right = TRUE),
                materialSwitch(inputId = "barrasCorrHorizCheck", label = "Vista Horizontal",
                               value = FALSE, status = "success", right = TRUE),
                materialSwitch(inputId = "barrasCorrStackCheck", label = "Apilar Barras",
                               value = FALSE, status = "primary", right = TRUE),
                materialSwitch(inputId = "barrasCorrCursorCheck", label = "Usar cursor Comparativo",
                               value = FALSE, status = "danger", right = TRUE),
                materialSwitch(inputId = "barrasCorrScrollCheck", label = "Usar barra Horizontal (Zoom)",
                               value = FALSE, status = "warning", right = TRUE),
                tags$i("Actualizaci\u00F3n autom\u00E1tica..."),
                circle = TRUE, status = "danger", icon = icon("gear"), width = "250px",
                size = "xs", tooltip = tooltipOptions(title = "Cambiar opciones...")
             ),
             amChartsOutput("barrasCorrPlotOut", width = "100%", height = "700") %>% withSpinner(type=5, color="cadetblue")
          )
     )
  ) # FIN navbarPage
)
#
