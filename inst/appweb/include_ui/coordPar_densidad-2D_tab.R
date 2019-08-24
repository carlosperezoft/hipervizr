# autor -------------------------------------------------------------------
# carlos.perez7@udea.edu.co
# 11/03/2019 22:37:08 p. m.
#
tabItem(tabName="coordPar_densidad-2DTab",
   h3("An\u00E1lisis Descriptivo usando las medias de las Hipercartas"),
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
        tabPanel("Viol\u00EDn", icon = icon("music", lib = "glyphicon"),
           helpText("An\u00E1lisis por medio del esquema Viol\u00EDn. Se usa una media a la vez debido a la diferencia entre escalas."),
           dropdownButton(inputId = "violinMedidaOpsBtn",
              tags$h4("Opciones de Presentaci\u00F3n:"),
              selectInput("violinMediaHiper", label = "Hipercarta", width="220px", # Para ajutar el ancho del Select!
                     choices=c("Conductividad"="MEDIA_Condu", "PH"="MEDIA_ph",
                               "OD"="MEDIA_od", "Turbiedad"="MEDIA_turb",
                               "POT_REDOX"="MEDIA_pot_redox", "Temperatura"="MEDIA_tempera"),
                     selected="MEDIA_Condu"),
              tags$i("Actualizaci\u00F3n autom\u00E1tica..."),
              circle = TRUE, status = "danger", icon = icon("gear"), width = "250px",
              size = "xs", tooltip = tooltipOptions(title = "Cambiar opciones...")
           ),
           plotlyOutput("violinDensidadPlot", width = "100%", height = "500px") %>% withSpinner(type=5, color="cadetblue")
        ),
        tabPanel("Distribuci\u00F3n de Densidad", icon = shiny::icon("stats", lib = "glyphicon"),
           helpText("Distribuci\u00F3n de Densidad para las medias (suavizado).Se usa una media a la vez debido a la diferencia entre escalas."),
           dropdownButton(inputId = "densidadMedidaOpsBtn",
              tags$h4("Opciones de Presentaci\u00F3n:"),
              selectInput("densidadMediaHiper", label = "Hipercarta", width="220px", # Para ajutar el ancho del Select!
                     choices=c("Conductividad"="MEDIA_Condu", "PH"="MEDIA_ph",
                               "OD"="MEDIA_od", "Turbiedad"="MEDIA_turb",
                               "POT_REDOX"="MEDIA_pot_redox", "Temperatura"="MEDIA_tempera"),
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
                     choices=c("Conductividad"="MEDIA_Condu", "PH"="MEDIA_ph",
                               "OD"="MEDIA_od", "Turbiedad"="MEDIA_turb",
                               "POT_REDOX"="MEDIA_pot_redox", "Temperatura"="MEDIA_tempera"),
                     selected="MEDIA_Condu"),
              tags$i("Actualizaci\u00F3n autom\u00E1tica..."),
              circle = TRUE, status = "danger", icon = icon("gear"), width = "250px",
              size = "xs", tooltip = tooltipOptions(title = "Cambiar opciones...")
           ),
           plotlyOutput("disperRegrePlot", width = "100%", height = "500px") %>% withSpinner(type=5, color="cadetblue")
        )
     ),
     tabPanel("Contornos", icon = icon("paperclip"),
        helpText("An\u00E1lisis por medio de contornos (Densidad 2D)."),
        dropdownButton(inputId = "contornoMedidaOpsBtn",
          tags$h4("Opciones de Presentaci\u00F3n:"),
          # Nota: En el listado de choices se usa una lista c("label"="id_txt"). En el server el input entrega el "id_txt".
          selectInput("contornoEjeXHipercarta", label = "Hipercarta eje X", width="220px", # Para ajutar el ancho del Select!
                  choices=c("t sub-j"="id_t", "Conductividad"="MEDIA_Condu", "PH"="MEDIA_ph",
                            "OD"="MEDIA_od", "Turbiedad"="MEDIA_turb",
                            "POT_REDOX"="MEDIA_pot_redox", "Temperatura"="MEDIA_tempera"),
                  selected="id_t"),
          selectInput("contornoEjeYHipercarta", label = "Hipercarta eje Y", width="220px", # Para ajutar el ancho del Select!
                  choices=c("Conductividad"="MEDIA_Condu", "PH"="MEDIA_ph",
                            "OD"="MEDIA_od", "Turbiedad"="MEDIA_turb",
                            "POT_REDOX"="MEDIA_pot_redox", "Temperatura"="MEDIA_tempera"),
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
     )
  ) # FIN navbarPage
)
#
