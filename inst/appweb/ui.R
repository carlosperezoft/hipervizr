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
      menuItem("Inicio", tabName = "homeTab", icon = icon("home"),
               badgeLabel = "HOME", badgeColor = "green", selected = TRUE ),
      menuItem("An\u00E1lisis Descriptivo", tabName = "coordPar_densidad-2DTab",
               icon = shiny::icon("edit"), badgeLabel = "2D", badgeColor = "orange"),
      menuItem("An\u00E1lisis Estaciones", tabName = "distrib-estaciones-2DTab",
               icon = shiny::icon("industry"), badgeLabel = "2D", badgeColor = "blue"),
      # NOTA: el uso de los atributos "BADGE" no aplican en un "menuItem" con submenus
      menuItem(text = "An\u00E1lisis Hipercartas", icon = shiny::icon("stats", lib = "glyphicon"),
         # NOTA: Los atributos "badgeLabel" y "badgeColor" NO aplican en un menuSubItem !
         menuSubItem(text = "Mosaico Principal", tabName = "hipercartaMaestroTab", icon = icon("cube")),
         menuSubItem(text = "Cartas de Control", tabName = "cartaControlDetalleTab", icon = icon("gear"))
      ),
      # NOTA: El uso de "href", es excluyente con el uso de "tabName" y de "subitems". Se debe usar uno de ellos.
      # El atributo "newtab" se utiliza para activar una nueva pestaña o popup al cargar el "href"
      menuItem("Ayuda localhost", icon = icon("question-circle"), badgeLabel = "HELP",
               badgeColor = "purple", href = "/ayuda/hipervizr-intro.html", newtab = TRUE)

    ), # /FIN sidebarMenu
    br(),
    tags$footer(tags$div(tags$b("* Proyecto: Red R\u00EDo *"),
        br(), "- GPLv3 Licence.", br(), "* Copyright \u00A9 2019 U. de A. *", br(),
        "- Medell\u00EDn - Colombia.", br(),
        tags$button(id = 'closeApp', type = "button", class = "btn action-button",
          onclick = "setTimeout(function(){window.close();},500);",
          # close browser
          tags$b("..SALIR..")
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
    source("include_ui/coordPar_densidad-2D_tab.R", local = TRUE)$value,
    source("include_ui/distrib-estaciones-2D-tab.R", local = TRUE)$value,
    # SE USA LA FUNCION source(..) con el acceso especifico al $value; para evitar que se
    # procese el contenido, pues causa que se genere el codigo HTML respectivo...
    # Se debe incluir el tabItem completo, sino el include .R genera errores de validacion.
    # ***
    # NUEVO: Tener en cuenta que el "x_tab" tiene un SOLO tabItem, esto debido a que la forma
    # de procesamiento de R-Studio y Shiny generan error de ejecucion y/o compilacion
    # ***
    source("include_ui/hipercartaMaestro_tab.R", local = TRUE)$value,
    source("include_ui/cartaControlDetalle_tab.R", local = TRUE)$value,
    tabItem(tabName = "ayudaTab", href = "/ayuda/rmarkdown_test.html", newtab = TRUE)
  ) # /tabItems
) # /dashboardBody

# INIT_DASHBOARD ----------------------------------------------------------
# El titulo usado aqui es el presentado en la pagina de Navegador WEB:
dashboardPage(title = "HIPERVIZ-R", header, sidebar, body, skin = "blue")
