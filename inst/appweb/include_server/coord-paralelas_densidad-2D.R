# autor -------------------------------------------------------------------
# carlos.perez7@udea.edu.co
# 11/03/2019 21:16:08 p. m.
#
# COORDENADAS PARALELAS ---------------------------------------------------
output$paralCoordsPlot <- renderParcoords({
  dsBase <- hiperCartaData
  req(dsBase)
  #
  dataSerie <- dsBase[c("id_t", mediasColNames)] # mediasColNames: declarada en utils-server.R
  #
  pc <- parcoords(reorderable=TRUE,
     dataSerie,  # order columns so species first
     rownames=FALSE, width=NULL, autoresize=TRUE,
     brushMode="1d", alphaOnBrushed=0.1, alpha=1.0, # alpha-->intensidad del color de las lineas, de 0 a 1.
     color = list(
       colorScale = htmlwidgets::JS(sprintf(
         'd3.scale.ordinal().range(%s).domain(%s)'
         #,jsonlite::toJSON(RColorBrewer::brewer.pal(9,'Blues')) # Usar en una estacion
         ,jsonlite::toJSON(RColorBrewer::brewer.pal(12,'Set3')) # Usar en hipercarta
         ,jsonlite::toJSON(as.character(unique(dataSerie$id_t)))
       ))
       ,colorBy = "id_t"
     )
   )
})
#
output$boxplotDensidadPlot <- renderPlotly({
  dsBase <- hiperCartaData
  req(dsBase)
  #
  dataSerie <- dsBase[c("id_t", input$boxplotMediaHiper)]
  selected_label <- media_labels %>% filter(variable %in% input$boxplotMediaHiper) %>% select("desc")
  names(dataSerie) <- c("id_t", selected_label)
  #
  melt_data <- melt(dataSerie,id="id_t", variable.name="variable", value.name="media")
  #
  gpy <- melt_data %>%
    plot_ly(x = ~variable, y = ~media, type = "box", jitter=0.3, pointpos=0, # <- Posicion donde salen los puntos, aqui el centro.
            boxpoints = if_else(input$boxplotMediaPuntosCheck, "all", "none"), # <- Los valores deben ser del mismo tipo: String.
            marker = list(color = 'rgba(219, 64, 82, 0.6)'), line = list(color = 'rgb(8,81,156)'),
            boxmean = "sd" # Atributo que activa la presentación de la media y la desviacion estandar en el box-plot.
    ) %>% layout(xaxis = list(title = "variable"), yaxis = list(title = "media", zeroline = T))
   #
   return(gpy)
})
#
output$violinDensidadPlot <- renderPlotly({
  dsBase <- hiperCartaData
  req(dsBase)
  #
  dataSerie <- dsBase[c("id_t", input$violinMediaHiper)]
  selected_label <- media_labels %>% filter(variable %in% input$violinMediaHiper) %>% select("desc")
  names(dataSerie) <- c("id_t", selected_label)
  #
  melt_data <- melt(dataSerie,id="id_t", variable.name="variable", value.name="media")
  #
  gpy <- melt_data %>%
    plot_ly(x = ~variable, y = ~media, split = ~variable, type = "violin",
            box = list(visible = T), meanline = list(visible = T)
    ) %>% layout(xaxis = list(title = "variable"), yaxis = list(title = "media", zeroline = T))
   #
   return(gpy)
})
#
output$distribucionDensidadPlot <- renderPlotly({
  dsBase <- hiperCartaData
  req(dsBase)
  #
  dataSerie <- dsBase[c("id_t", input$densidadMediaHiper)]
  selected_label <- media_labels %>% filter(variable %in% input$densidadMediaHiper) %>% select("desc")
  names(dataSerie) <- c("id_t", selected_label)
  #
  melt_data <- melt(dataSerie, id = "id_t", variable.name = "variable", value.name = "media")
  # alpha: 0.2 (colores claros) / 0.55 (colores intermedios),
  # es el parametro para el nivel de transparencia de las densidades presentadas:
  ggp <- ggplot(melt_data, aes(x = media, group = variable, fill = variable)) + geom_density(alpha=0.55) +
                 labs(title = sprintf("%s",selected_label), x = sprintf("%s %s","MEDIA",selected_label), y = "Densidad") +
                 theme(
                   legend.position="none"
                 )
  # Se usa el objeto "ggp" para una invocacion mas limpia...
  ggplotly(ggp)
})
#
output$contornosDensidadPlot <- renderPlotly({
  dsBase <- hiperCartaData
  req(dsBase)
  #
  var_ejeX <- input$contornoEjeXHipercarta
  if(input$contornoEjeXHipercarta == input$contornoEjeYHipercarta) {
      var_ejeX <- "id_t"
  }
  #
  cast_data <- dsBase[c(var_ejeX, input$contornoEjeYHipercarta)]
  ejeX_label <- media_labels %>% filter(variable %in% var_ejeX) %>% select("desc")
  ejeY_label <- media_labels %>% filter(variable %in% input$contornoEjeYHipercarta) %>% select("desc")
  #
  shiny::validate(
    shiny::need(ncol(cast_data) == 2, "Este tipo de gr\u00E1fico aplica a DOS elementos solamente.")
  )
  # Schemes from ColorBrewer, distiller scales extends brewer to continuous scales by smoothly
  # Palette Sequential: Blues, GnBu, Spectral
  ggp <- ggplot(cast_data, aes_string(x=colnames(cast_data)[1], y=colnames(cast_data)[2])) +
                labs(x = sprintf("%s",ejeX_label), y = sprintf("%s",ejeY_label))
  if(input$contornoMedidaMethod == "Poligono") {
    # geom_bin2d(bins = round(nrow(cast_data) / 5)) + # bins: define el numero de celdas por eje, con lo cual agrupa puntos!
    ggp <- ggp + geom_hex() + # binwidth: tamaño visual del "bin"
                 scale_fill_distiller(palette="Blues", direction=1) +  # direction=1: colores en orden normal
                 theme_bw()
  } else if(input$contornoMedidaMethod == "Contorno") {
    ggp <- ggp + stat_density_2d(aes(fill = ..level..), geom = "polygon" ) + # , colour="gray": ver lineas del poligono
                 scale_fill_distiller(palette="GnBu", direction=1) +
                 theme_gray()
  } else if(input$contornoMedidaMethod == "Espectral") {
    ggp <- ggp + stat_density_2d(aes(fill = ..density..), geom = "raster", contour = FALSE) +
                 scale_fill_distiller(palette="Spectral", direction=-1) # direction=-1: colores en orden invertido
  }
  # Presentar punto de Score en el grafico:
  if(input$contornoMedidaPuntosCheck == TRUE) {
    ggp <- ggp + geom_point(colour = "red") +
           scale_x_continuous(expand = c(0, 0)) +
           scale_y_continuous(expand = c(0, 0)) +
           theme(
             legend.position='right'
           )
  } else {
    ggp <- ggp + scale_x_continuous(expand = c(0, 0)) +
           scale_y_continuous(expand = c(0, 0)) +
           theme(
             legend.position='right'
           )
  }
  # Grafico final:
  ggplotly(ggp)
})
#
output$disperRegrePlot <- renderPlotly({
  dsBase <- hiperCartaData
  req(dsBase)
  #
  cast_data <- dsBase[c("id_t", input$disperRegreMediaHiper)]
  selected_label <- media_labels %>% filter(variable %in% input$disperRegreMediaHiper) %>% select("desc")
  #
  scatPlot <- ggplot(cast_data,
                   aes_string(x=colnames(cast_data)[1], y=colnames(cast_data)[2], color=colnames(cast_data)[2])) +
                   labs(x = "t-sub-j", y = paste("Variable:", selected_label), title = sprintf("%s",selected_label)) +
                   geom_point() + geom_rug(col="steelblue", alpha=0.5, size=1.5) +
                   # al usar poly(..) se tiene una curva con mejor ajuste en el smooth:
                   geom_smooth(method=lm , formula = y ~ poly(x, 4), color="red", se=TRUE) +
                   scale_colour_gradient(low = "blue", high = "orange")
  #
  ggplotly(scatPlot)
  #
})
#
output$correlogramaPlotOut <- renderPlot({
  dsBase <- hiperCartaData
  req(dsBase)
  #
  cast_data <- dsBase[mediasColNames]
  # El operador ternario "if_else", no maneja bien el NULL como un tipo de retorno para Strings.
  if(input$correlogramaCoefCheck == TRUE) {
     showCoef = "black"
  } else {
     showCoef = NULL
  }
  #
  corrplot(cor(cast_data), method=input$correlogramaMethod, type=input$correlogramaSection, mar=c(1, 1, 2, 1),
           addCoef.col = showCoef, title = "Correlograma de las medias")
})

output$corrnetPlotOut <- renderPlot({
  dsBase <- hiperCartaData
  req(dsBase)
  #
  cast_data <- dsBase[mediasColNames]
  #
  names(cast_data) <- c("Condu", "PH", "OxiDis", "Turb", "Pot_Redox", "Tempera")
  #names(cast_data) <- c("PH", "OxiDis", "Turb", "Pot_Redox", "Tempera")
  # ------------------------------------------------------------------------
  # layout: circle, groups, spring
  # graph: default: no aplica coorrelacion extra,
  #        association: correlation network,
  #        concentration: partial correlation network,
  #        glasso: optimal sparse estimate of the partial correlation matrix
  #        ("graph" obliga el uso de "sampleSize")
  #
  if(input$corrnetGraph == "Ninguno") {
     qgraph(cor(cast_data), layout=input$corrnetLayout, posCol="darkgreen", negCol="darkred")
  } else {
     qgraph(cor(cast_data), layout=input$corrnetLayout, posCol="darkgreen", negCol="darkred",
            graph = input$corrnetGraph, sampleSize = nrow(cast_data))
  }
  #
  title("Enclaces -> Verde: positivo | Rojo: negativo", line = 1.5)
  #
}, width = 600, height = 600)
#
