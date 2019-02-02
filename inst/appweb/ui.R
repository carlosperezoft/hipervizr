# autor -------------------------------------------------------------------
# carlos.perez7@udea.edu.co
# 01/02/2019 9:26:08 a. m.
#
# NOTA: las inclusiones son relativas a la ubicion del archivo. "ui.R"
source('include_ui/utils_ui.R', local=TRUE)

# Declaracion del encabezado para la aplicacion WEB:
header <- dashboardHeader(
  # El titulo usado aqui es el presentado en el menu de la app web:
  title = tagList(shiny::icon("gear"), "HIPERVIZ-\u00AE"),
  titleWidth = "250px", disable = FALSE, msgHelpMenu
)

# menu_general ------------------------------------------------------------
sidebar <- dashboardSidebar(width = "250px",
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "custom.css"),
    tags$script(src = "custom.js")
  ),
  # NOTA: Un menuItem con "subItems" NO permite invocar su propio elmento "tabName", es decir;
  #       solo los subItems activan la invocacion a un elemento "tabName".
  ##
  # NOTA: Para el decorado "badgeColor", los colores validos son: red, yellow, aqua, blue,
  #       light-blue, green, navy, teal, olive, lime, orange, fuchsia, purple, maroon, black.
  #
  sidebarMenu(id = "sidebarMenu",
      menuItem("Inicio", tabName = "homeTab", icon = icon("credit-card"),
               badgeLabel = "HOME", badgeColor = "green", selected = TRUE ),
      menuItem("Coordenadas Paralelas", tabName = "coordParall",
               icon = shiny::icon("tasks"), badgeLabel = "UTIL", badgeColor = "red"),
      menuItem("hipercarta (Series)", tabName = "hipercarta",
               icon = shiny::icon("stats", lib = "glyphicon"),
               badgeLabel = "NUEVO", badgeColor = "orange"),
      # NOTA: el uso de los atributos "BADGE" no aplican en un "menuItem" con submenus
      menuItem(text = "Secci\u00F3n EDA/EGA", icon = icon("thumbs-up", lib = "glyphicon"),
               # NOTA: Los atributos "badgeLabel" y "badgeColor" NO aplican en un menuSubItem !
               menuSubItem(text = "Mosaico-PLOTLY", tabName = "mosaicoPlotSubMTab", icon = icon("paint-brush"))
      ),
      # NOTA: El uso de "href", es excluyente con el uso de "tabName" y de "subitems". Se debe usar uno de ellos.
      # El atributo "newtab" se utiliza para activar una nueva pestaña o popup al cargar el "href"
      menuItem("Ayuda localhost", icon = icon("question-circle"), badgeLabel = "HELP",
               badgeColor = "purple", href = "/ayuda/rmarkdown_test.html", newtab = TRUE)

    ), # /FIN sidebarMenu
    br(),
    tags$footer(tags$div(tags$b("* Carlos A. P\u00E9rez Moncada."),
        a(href= "https://www.linkedin.com/in/carlos-alberto-perez-moncada-07b6b630/",
                 target="_blank",icon("linkedin-square", "fa-2x")),
        br(), "- GPLv3 Licence.", br(), "- Copyright \u00A9 2019 U. de A.", br(),
        "- Medell\u00EDn - Colombia.", br(),
        tags$button(id = 'closeApp', type = "button", class = "btn action-button",
          onclick = "setTimeout(function(){window.close();},500);",
          # close browser
          "SALIR..."
        )
    ) # FIN DIV
  ) # FIN FOOTER
) # /dashboardSidebar


# TABS_APPWEB -------------------------------------------------------------
body <- dashboardBody(
  tabItems(
    # First tab content
    # SE USA LA FUNCION source(..) con el acceso especifico al $value; para evitar que se
    # procese el contenido, pues causa que se genere el codigo HTML respectivo...
    # Se debe incluir el tabItem completo, sino el include .R genera errores de validacion:
    source("include_ui/home_tab.R", local = TRUE)$value,
    tabItem(tabName = "coordParall",
      h2("Coordenadas Paralelas [Ejemplo: Datos Vehiculos e IRIS]"),
      br(),
      helpText("Clic y arrastar sobre los ejes verticales - ordenar o filtrar - brushing (doble clic para restaurar)."),
      fluidRow(
        # NOTA: withSpinner(), presenta el icono de LOADING... mientras procesa la imagen...
        box(
          title = "Parcoords Plot Example", width = NULL, status = "primary",
          plotOutput( "iris_pairs", width = "400px" ) %>% withSpinner()
        ),
        parcoordsOutput("paralCoordsPlot", width = "100%", height = "500px" ) %>% withSpinner()
      )
    ),
    # SE USA LA FUNCION source(..) con el acceso especifico al $value; para evitar que se
    # procese el contenido, pues causa que se genere el codigo HTML respectivo...
    # Se debe incluir el tabItem completo, sino el include .R genera errores de validacion:
    source("include_ui/series_contenido_tab.R", local = TRUE)$value,
    source("include_ui/submenu_mosaico_plotly.R", local = TRUE)$value,
    tabItem(tabName = "ayudaTab", href = "/ayuda/rmarkdown_test.html", newtab = TRUE)
  ) # /tabItems
) # /dashboardBody

# INIT_DASHBOARD ----------------------------------------------------------
# El titulo usado aqui es el presentado en la pagina de Navegador WEB:
dashboardPage(title = "HIPERVIZ-R", header, sidebar, body, skin = "blue")
