# autor -------------------------------------------------------------------
# carlos.perez7@udea.edu.co
# 11/03/2019 22:37:08 p. m.
#
tabItem(tabName="coordPar_densidad-2D",
   h3("An\u00E1lisis de Densidad usando las medias de las Hipercartas"),
   navbarPage("Densidad-2D",
      tabPanel("Patrones", icon = icon("desktop"),
         helpText(paste("Brushing: clic y arrastar sobre un eje (un clic para restaurar). Ordenar: doble clic sobre una variable.",
                  "Intercambiar: clic sobre una variable y arrastrar hacia los lados.")),
          # El atributo "with" del box(..) usa el valro entero 1->12 columnas (12->100%).
          box(title="Coordenadas Paralelas - Hipercartas", status="success", solidHeader=TRUE, collapsible=TRUE, width=12,
             parcoordsOutput("paralCoordsPlot", height="500px" ) %>% withSpinner(type=5, color="cadetblue")
          )
      ),
     navbarMenu("Distribuci\u00F3n",
        tabPanel("Viol\u00EDn", icon = icon("thumbs-up", lib = "glyphicon"),
           helpText("An\u00E1lisis por medio del esquema Viol\u00EDn"),
           plotlyOutput("violinDensidadPlot", width = "100%", height = "500px") %>% withSpinner(type=5, color="cadetblue")
        ),
        tabPanel("Distribuci\u00F3n de Densidad", icon = shiny::icon("stats", lib = "glyphicon"),
           helpText("Formas de distribución para las medias (suavizado)"),
           plotlyOutput("distribucionDensidadPlot", width = "100%", height = "500px") %>% withSpinner(type=4, color="cadetblue")
        )
     ),
     tabPanel("Contornos", icon = icon("paint-brush"),
        helpText("An\u00E1lisis por medio de contornos (Densidad 2D)."),
        dropdownButton(inputId = "contornoMedidaOpsBtn",
          tags$h4("Opciones de Presentaci\u00F3n:"),
          # Nota: En el listado de choices se usa una lista c("label"="id_txt"). En el server el input entrega el "id_txt".
          selectInput("contornoEjeXHipercarta", label = "Hipercarta eje X", width="220px", # Para ajutar el ancho del Select!
                  choices=c("t sub-j"="id_t", "SST_tr"="Media_SST_tr", "SST"="Media_SST",
                            "Conductividad"="Media_Conduct", "Temperatura"="Media_Tempera"),
                  selected="id_t"),
          selectInput("contornoEjeYHipercarta", label = "Hipercarta eje Y", width="220px", # Para ajutar el ancho del Select!
                  choices=c("SST_tr"="Media_SST_tr", "SST"="Media_SST",
                            "Conductividad"="Media_Conduct", "Temperatura"="Media_Tempera"),
                  selected="Media_SST_tr"),
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
