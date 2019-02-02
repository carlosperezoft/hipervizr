# autor -------------------------------------------------------------------
# carlos.perez7@udea.edu.co
# 01/02/2019 9:26:08 a. m.
#
tabItem(tabName = "mosaicoPlotSubMTab",
  h2("SUBMENU: MOSAICO DE GRAFICOS EN D3.JS, paquete R: plotly.js (ggplot2)"), br(),
  # NOTA: el uso de navbarPage NO permite el uso interno de "tabsetPanel"
  # dentro un "tabPanel" que forme parte de dicha barra de navegacion.
  navbarPage("MOSAICO PLOTLY",
    tabPanel("CAPAS EN GRAFICAS", icon = icon("desktop"),
       h3("CAPAS EN GRAFICAS PREDEFINIDAS"),
       plotlyOutput("capasSTATPlot", width = "100%", height = "500px") %>% withSpinner()
    ),
    tabPanel("GRAFICO PREDICCION", icon = icon("stats"),
       h3("PREDICCION CON FORECAST VISUAL"),
       plotlyOutput("predictSTATPlot", width = "100%", height = "500px") %>% withSpinner()
    ),
    tabPanel("MOSAICO DE VARIAS GRAFICAS", icon = icon("desktop"),
        h3("PANEL DE GRAFICOS CON SUBPLOT ARRAY"),
        sidebarLayout(
          sidebarPanel(width = 500,
             h3("CUADRANTE DE GRAFICOS:"),
             plotlyOutput("cuadranteSTATPlot", width = "100%", height = "500px") %>% withSpinner()
          ),
          mainPanel(
             h3("DATOS PRESENTADOS"),
             DTOutput("subplotArrayDT", width = "500px", height = "500px") %>% withSpinner()
          )
        )
     ),
     navbarMenu("EXTRA WIDGESTS PLOTLY",
        tabPanel("PAR COORD INTERACTIVAS", icon = icon("tasks"),
           h3("COORDENADAS PARALELAS INTERACTIVAS"),
           plotlyOutput("corParINTERPlot", width = "100%", height = "500px") %>% withSpinner()
        ),
        tabPanel("COORDENADAS PARALELAS ESTATICAS", icon = icon("desktop"),
           h3("Cordenadas PREDEFINIDAS"),
           plotlyOutput("corParSTATPlot", width = "100%", height = "500px") %>% withSpinner()
        )
     )
  )
)
#
