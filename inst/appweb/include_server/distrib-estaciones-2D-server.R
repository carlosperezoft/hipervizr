# autor -------------------------------------------------------------------
# carlos.perezoft@gmail.com
# 23/10/2019 21:16:08 p. m.
#
#
output$boxplotEstacionesPlot <- renderPlotly({
  dsBase <- medicionEstacionData
  req(dsBase)
  #
  if(!is.null(input$boxplotEstacionMes)) {
     dsBase <- dsBase %>% filter(MES %in% input$boxplotEstacionMes)
  }
  #
  if(input$boxplotEstacDiaMes != "T") {
     dsBase <- dsBase %>% filter(DIA_MES == input$boxplotEstacDiaMes)
  }
  #
  if(!is.null(input$boxplotEstacDiaSem)) {
     dsBase <- dsBase %>% filter(DIA_SEMANA %in% input$boxplotEstacDiaSem)
  }
  #
  shiny::validate(
    shiny::need(nrow(dsBase) > 0, # Este check valida la condicion de forma "afirmativa"..
                "No se tienen mediciones disponibles para los filtros usados.")
  )
  #
  dataSerie <- dsBase[c("id_fila", "ESTACION", input$boxplotEstacionesParam)]
  selected_label <- media_labels %>% filter(variable == input$boxplotEstacionesParam) %>% select("desc")
  names(dataSerie) <- c("id_fila", "estacion", "parametro")
  #
  gpy <- dataSerie %>% # pointpos: Posicion donde salen los puntos, aqui el centro (0).
    plot_ly(x=~estacion, y=~parametro, color=~estacion, type = "box", jitter=0.3, pointpos=0,
            boxpoints = if_else(input$boxplotEstacionPtosCheck, "all", "none"), # <- Los valores deben ser del mismo tipo: String.
            boxmean = "sd" # Atributo que activa la presentación de la media y la desviacion estandar en el box-plot.
    ) %>% layout(xaxis=list(title="Estaci\u00F3n"),
                 yaxis=list(title = sprintf("%s %s","Valor ", selected_label), zeroline = T))
   #
   return(gpy)
})
#
output$boxplotVarTempPlot <- renderPlotly({
  dsBase <- medicionEstacionData
  req(dsBase)
  #
  if(!is.null(input$boxplotVarTempMes)) {
     dsBase <- dsBase %>% filter(MES %in% input$boxplotVarTempMes)
  }
  #
  if(input$boxplotVarTempDiaMes != "T") {
     dsBase <- dsBase %>% filter(DIA_MES == input$boxplotVarTempDiaMes)
  }
  #
  if(!is.null(input$boxplotVarTempDiaSem)) {
     dsBase <- dsBase %>% filter(DIA_SEMANA %in% input$boxplotVarTempDiaSem)
  }
  #
  shiny::validate(
    shiny::need(nrow(dsBase) > 0, # Este check valida la condicion de forma "afirmativa"..
                "No se tienen mediciones disponibles para los filtros usados.")
  )
  #
  dataSerie <- dsBase[c("id_fila", "MES", input$boxplotVarTempParam)]
  names(dataSerie) <- c("id_fila", "mes", "parametro")
  dataSerie <- dataSerie %>% transmute(id_fila = id_fila, mes = dplyr::case_when(
                       mes == 8 ~ "Agosto",
                       mes == 9 ~ "Septiembre"
                   ), parametro = parametro)
  selected_label <- media_labels %>% filter(variable == input$boxplotVarTempParam) %>% select("desc")
  #
  gpy <- dataSerie %>% # pointpos: Posicion donde salen los puntos, aqui el centro (0).
    plot_ly(x=~mes, y=~parametro, color=~mes, type = "box", jitter=0.3, pointpos=0,
            boxpoints = if_else(input$boxplotVarTempPtosCheck, "all", "none"), # <- Los valores deben ser del mismo tipo: String.
            boxmean = "sd" # Atributo que activa la presentación de la media y la desviacion estandar en el box-plot.
    ) %>% layout(xaxis=list(title="Mes"),
                 yaxis=list(title = sprintf("%s %s","Valor ", selected_label), zeroline = T))
   #
   return(gpy)
})
#
output$violinEstacionesPlot <- renderPlotly({
  dsBase <- medicionEstacionData
  req(dsBase)
  #
  if(!is.null(input$violinEstacionMes)) {
     dsBase <- dsBase %>% filter(MES %in% input$violinEstacionMes)
  }
  #
  if(input$violinEstacDiaMes != "T") {
     dsBase <- dsBase %>% filter(DIA_MES == input$violinEstacDiaMes)
  }
  #
  if(!is.null(input$violinEstacDiaSem)) {
     dsBase <- dsBase %>% filter(DIA_SEMANA %in% input$violinEstacDiaSem)
  }
  #
  shiny::validate(
    shiny::need(nrow(dsBase) > 0, # Este check valida la condicion de forma "afirmativa"..
                "No se tienen mediciones disponibles para los filtros usados.")
  )
  #
  dataSerie <- dsBase[c("id_fila", "ESTACION", input$violinEstacionesParam)]
  selected_label <- media_labels %>% filter(variable == input$violinEstacionesParam) %>% select("desc")
  names(dataSerie) <- c("id_fila", "estacion", "parametro")
  #
  gpy <- dataSerie %>%
    plot_ly(x = ~estacion, y = ~parametro, split = ~estacion, type = "violin",
            box = list(visible = T), meanline = list(visible = T)
    ) %>% layout(xaxis=list(title="Estaci\u00F3n"),
                 yaxis=list(title = sprintf("%s %s","Valor ", selected_label), zeroline = T))
   #
   return(gpy)
})
#
output$distriDensiEstacionesPlot <- renderPlotly({
  dsBase <- medicionEstacionData
  req(dsBase)
  #
  if(!is.null(input$densidadEstacionMes)) {
     dsBase <- dsBase %>% filter(MES %in% input$densidadEstacionMes)
  }
  #
  if(input$densidadEstacDiaMes != "T") {
     dsBase <- dsBase %>% filter(DIA_MES == input$densidadEstacDiaMes)
  }
  #
  if(!is.null(input$densidadEstacDiaSem)) {
     dsBase <- dsBase %>% filter(DIA_SEMANA %in% input$densidadEstacDiaSem)
  }
  #
  shiny::validate(
    shiny::need(nrow(dsBase) > 0, # Este check valida la condicion de forma "afirmativa"..
                "No se tienen mediciones disponibles para los filtros usados.")
  )
  #
  dataSerie <- dsBase[c("id_fila", "ESTACION", input$densidadEstacionesParam)]
  selected_label <- media_labels %>% filter(variable == input$densidadEstacionesParam) %>% select("desc")
  names(dataSerie) <- c("id_fila", "estacion", "parametro")
  #
  melt_data <- melt(dataSerie, id = "id_fila", variable.name = "variable", value.name = "media")
  # alpha: 0.2 (colores claros) / 0.55 (colores intermedios),
  # es el parametro para el nivel de transparencia de las densidades presentadas:
  ggp <- ggplot(dataSerie, aes(x = parametro, group = estacion, fill = estacion)) + geom_density(alpha=0.55) +
                 labs(title = sprintf("%s",selected_label), x = sprintf("%s %s","Valores: ",selected_label), y = "Densidad") +
                 theme(
                   legend.position="right"
                 )
  # Se usa el objeto "ggp" para una invocacion mas limpia...
  ggplotly(ggp)
})
#
output$contornosEstacionesPlot <- renderPlotly({
  dsBase <- medicionEstacionData
  req(dsBase)
  #
  if(input$contornoFiltroEstacion != "T") {
     dsBase <- dsBase %>% filter(ESTACION == input$contornoFiltroEstacion)
  }
  #
  if(!is.null(input$contornoEstacionMes)) {
     dsBase <- dsBase %>% filter(MES %in% input$contornoEstacionMes)
  }
  #
  if(input$contornoEstacDiaMes != "T") {
     dsBase <- dsBase %>% filter(DIA_MES == input$contornoEstacDiaMes)
  }
  #
  if(!is.null(input$contornoEstacDiaSem)) {
     dsBase <- dsBase %>% filter(DIA_SEMANA %in% input$contornoEstacDiaSem)
  }
  #
  shiny::validate(
    shiny::need(nrow(dsBase) > 0, # Este check valida la condicion de forma "afirmativa"..
                "No se tienen mediciones disponibles para los filtros usados.")
  )
  #
  var_ejeX <- input$contornoEjeXEstaciones
  if(input$contornoEjeXEstaciones == input$contornoEjeYEstaciones) {
      var_ejeX <- "id_t"
  }
  #
  cast_data <- dsBase[c(var_ejeX, input$contornoEjeYEstaciones)]
  ejeX_label <- media_labels %>% filter(variable == var_ejeX) %>% select("desc")
  ejeY_label <- media_labels %>% filter(variable == input$contornoEjeYEstaciones) %>% select("desc")
  #
  shiny::validate(
    shiny::need(ncol(cast_data) == 2, "Este tipo de gr\u00E1fico aplica a DOS elementos solamente.")
  )
  # Schemes from ColorBrewer, distiller scales extends brewer to continuous scales by smoothly
  # Palette Sequential: Blues, GnBu, Spectral
  ggp <- ggplot(cast_data, aes_string(x=colnames(cast_data)[1], y=colnames(cast_data)[2])) +
                labs(x = sprintf("%s",ejeX_label), y = sprintf("%s",ejeY_label))
  if(input$contornoEstacionMethod == "Poligono") {
    # geom_bin2d(bins = round(nrow(cast_data) / 5)) + # bins: define el numero de celdas por eje, con lo cual agrupa puntos!
    ggp <- ggp + geom_hex() + # binwidth: tamaño visual del "bin"
                 scale_fill_distiller(palette="Blues", direction=1) +  # direction=1: colores en orden normal
                 theme_bw()
  } else if(input$contornoEstacionMethod == "Contorno") {
    ggp <- ggp + stat_density_2d(aes(fill = ..level..), geom = "polygon" ) + # , colour="gray": ver lineas del poligono
                 scale_fill_distiller(palette="GnBu", direction=1) +
                 theme_gray()
  } else if(input$contornoEstacionMethod == "Espectral") {
    ggp <- ggp + stat_density_2d(aes(fill = ..density..), geom = "raster", contour = FALSE) +
                 scale_fill_distiller(palette="Spectral", direction=-1) # direction=-1: colores en orden invertido
  }
  # Presentar punto de Score en el grafico:
  if(input$contornoEstacionPuntosCheck == TRUE) {
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
output$correlogramaEstacionesPlot <- renderPlot({
  dsBase <- medicionEstacionData
  req(dsBase)
  #
  if(input$correlogramaFiltroEstacion != "T") {
     dsBase <- dsBase %>% filter(ESTACION == input$correlogramaFiltroEstacion)
  }
  #
  if(!is.null(input$correlogramaEstacionMes)) {
     dsBase <- dsBase %>% filter(MES %in% input$correlogramaEstacionMes)
  }
  #
  if(input$correlogramaEstacDiaMes != "T") {
     dsBase <- dsBase %>% filter(DIA_MES == input$correlogramaEstacDiaMes)
  }
  #
  if(!is.null(input$correlogramaEstacDiaSem)) {
     dsBase <- dsBase %>% filter(DIA_SEMANA %in% input$correlogramaEstacDiaSem)
  }
  #
  shiny::validate(
    shiny::need(nrow(dsBase) > 0, # Este check valida la condicion de forma "afirmativa"..
                "No se tienen mediciones disponibles para los filtros usados.")
  )
  #
  cast_data <- dsBase[mediasColNames]
  # El operador ternario "if_else", no maneja bien el NULL como un tipo de retorno para Strings.
  if(input$correlogramaEstacionesCoefCheck == TRUE) {
     showCoef = "black"
  } else {
     showCoef = NULL
  }
  #
  corrplot(cor(cast_data), method=input$correlogramaEstacionesMethod, type=input$correlogramaEstacionesSection,
           mar=c(1, 1, 2, 1), addCoef.col = showCoef, title = "Correlograma de los Par\u00E1metros")
})

#
