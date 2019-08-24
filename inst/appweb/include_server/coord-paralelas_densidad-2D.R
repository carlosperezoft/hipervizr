# autor -------------------------------------------------------------------
# carlos.perez7@udea.edu.co
# 11/03/2019 21:16:08 p. m.
#
# COORDENADAS PARALELAS ---------------------------------------------------
output$paralCoordsPlot <- renderParcoords({
  dsBase <- hiperCartaData
  req(dsBase)
  #
  dataSerie <- dsBase[c("id_t", "MEDIA_Condu", "MEDIA_ph", "MEDIA_od", "MEDIA_turb", "MEDIA_pot_redox", "MEDIA_tempera")]
  #
  pc <- parcoords(reorderable=TRUE,
     dataSerie,  # order columns so species first
     rownames=FALSE, width=NULL, autoresize=TRUE,
     brushMode="1d", alphaOnBrushed=0.1, alpha=1.0, # alpha-->intensidad del color de las lineas, de 0 a 1.
     color = list(
       colorScale = htmlwidgets::JS(sprintf(
         'd3.scale.ordinal().range(%s).domain(%s)'
         ,jsonlite::toJSON(RColorBrewer::brewer.pal(3,'Set1'))
         ,jsonlite::toJSON(as.character(unique(dataSerie$id_t)))
       ))
       ,colorBy = "id_t"
     )
   )
})
#
output$violinDensidadPlot <- renderPlotly({
  dsBase <- hiperCartaData
  req(dsBase)
  #
  dataSerie <- dsBase[c("id_t", input$violinMediaHiper)]
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
  #
  melt_data <- melt(dataSerie, id = "id_t", variable.name = "variable", value.name = "media")
  # alpha: 0.2 (colores claros) / 0.55 (colores intermedios),
  # es el parametro para el nivel de transparencia de las densidades presentadas:
  ggp <- ggplot(melt_data, aes(x = media, group = variable, fill = variable)) + geom_density(alpha=0.55) +
                 labs(title = input$densidadMediaHiper, x = "Valor MEDIA", y = "Densidad") +
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

  cast_data <- dsBase[c(var_ejeX, input$contornoEjeYHipercarta)]
  #
  shiny::validate(
    shiny::need(ncol(cast_data) == 2, "Este tipo de gr\u00E1fico aplica a DOS elementos solamente.")
  )
  # Schemes from ColorBrewer, distiller scales extends brewer to continuous scales by smoothly
  # Palette Sequential: Blues, GnBu, Spectral
  ggp <- ggplot(cast_data, aes_string(x=colnames(cast_data)[1], y=colnames(cast_data)[2]))
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
  #
  scatPlot <- ggplot(cast_data,
                     aes_string(x=colnames(cast_data)[1], y=colnames(cast_data)[2], color=colnames(cast_data)[2])) +
    labs(x = "Fila.id_t", y = paste("Variable:", colnames(cast_data)[2])) +
    geom_point() + geom_rug(col="steelblue", alpha=0.5, size=1.5) +
    # al usar poly(..) se tiene una curva con mejor ajuste en el smooth:
    geom_smooth(method=lm , formula = y ~ poly(x, 4), color="red", se=TRUE) +
    scale_colour_gradient(low = "blue", high = "orange")
  #
  ggplotly(scatPlot)
  #
})
#
