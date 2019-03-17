tabItem(tabName = "homeTab",
  h2("hiperviz Aplicaci\u00F3n Shiny Dashboard. v 1.0"), # Este titulo es para la seccion completa
  fluidRow(
    tabBox(title = tagList(shiny::icon("gear"), "HOME -- INICIO"), # Este titulo es solo para el TABSET
           width = "250px", height = "550px",
        # Lista de TABs:
        tabPanel(id="acerdaDeTab", title = "ACERCA DE", # Tutilo solo para la pestaña del TAB Panel
          h2("Visualizaci\u00F3n de Hipercartas con sus respectivas cartas de control."),
          helpText(tags$b("Proyecto:"),
             br(), "Red R\u00EDo",
             br(), tags$b("Facultad de Ingenier\u00EDa"),
             br(), "* Copyright \u00A9 2019 U. de A. *"
          ),
          # La imagen se debe ubicar en una carpeta "/www",
          # al mismo nivel del archivo "ui.R". Alli se puede crear: "www/images"
          hr(), img(src = "images/UdeA_Escudo.jpg")
       ),
       # NOTA: Se debe usar un tabPanel para elementos con contenido HTML para que sea procesado correctamente
       tabPanel(id="ayudaBasicTab", title = "AYUDA",
          h3("AYUDA BASICA"),
          wellPanel(# El wellPanel adiciona un "contorno Gris" a los elementos contenidos
            # la funcion helpText aplica estilos propios al texto HTML proporcionado
            helpText(title = "Hiperviz R acerca de...", htmlOutput("basicsHelpText"))
          )
          # Al adicionar elementos luego del wellPanel no se activaron, se envian entonces desde el "server.R"
       )
    ) # fin tabBox
  ) # fin fluidRow
)
