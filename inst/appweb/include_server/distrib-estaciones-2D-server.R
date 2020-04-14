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
  dsBase <- dsBase %>% filter(ESTACION == input$boxplotVarTempEstacion)
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
        mes == 1 ~ "2020-01-Enero",mes == 2 ~ "2020-02-Febrero",mes == 3 ~ "2020-03-Marzo",mes == 4 ~ "2020-04-Abril",
        mes == 5 ~ "2020-05-Mayo",mes == 6 ~ "2020-06-Junio",mes == 7 ~ "2019-07-Julio",mes == 8 ~ "2019-08-Agosto",
        mes == 9 ~ "2019-09-Septiembre",mes == 10 ~ "2019-10-Octubre",mes == 11 ~ "2019-11-Noviembre",mes == 12 ~ "2019-12-Diciembre"
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
  # Se usa el metodo "na.omit" para quitar las filas con valores NA en alguna celda.
  cast_data <- na.omit(dsBase[mediasColNames])
  names(cast_data) <- paramsColNames
  # El operador ternario "if_else", no maneja bien el NULL como un tipo de retorno para Strings.
  if(input$correlogramaEstacionesCoefCheck == TRUE) {
     showCoef = "black"
  } else {
     showCoef = NULL
  }
  #
  corMat <- cor(cast_data)
  corrplot(corMat, method=input$correlogramaEstacionesMethod, type=input$correlogramaEstacionesSection,
           mar=c(1, 1, 2, 1), addCoef.col = showCoef, title = "Correlograma de los Par\u00E1metros")
})
#
output$cuerdasCorrEstacionesPlotOut <- renderPlot({
  dsBase <- medicionEstacionData
  req(dsBase)
  #
  if(input$cuerdasCorrEstacionesFiltroEstacion != "T") {
     dsBase <- dsBase %>% filter(ESTACION == input$cuerdasCorrEstacionesFiltroEstacion)
  }
  #
  if(!is.null(input$cuerdasCorrEstacionesMes)) {
     dsBase <- dsBase %>% filter(MES %in% input$cuerdasCorrEstacionesMes)
  }
  #
  if(input$cuerdasCorrEstacionesDiaMes != "T") {
     dsBase <- dsBase %>% filter(DIA_MES == input$cuerdasCorrEstacionesDiaMes)
  }
  #
  if(!is.null(input$cuerdasCorrEstacionesDiaSem)) {
     dsBase <- dsBase %>% filter(DIA_SEMANA %in% input$cuerdasCorrEstacionesDiaSem)
  }
  #
  shiny::validate(
    shiny::need(nrow(dsBase) > 0, # Este check valida la condicion de forma "afirmativa"..
                "No se tienen mediciones disponibles para los filtros usados.")
  )
  # Se usa el metodo "na.omit" para quitar las filas con valores NA en alguna celda.
  cast_data <- na.omit(dsBase[mediasColNames])
  names(cast_data) <- paramsColNames
  corMat <- cor(cast_data)
  #
  circos.clear()
  col_fun = colorRamp2(c(-1, 0, 1), c("red", "white", "green"))
  circlize::chordDiagram(corMat, symmetric = TRUE, col = col_fun,
                         directional = -1, direction.type = "arrows", link.arr.type = "big.arrow")
  #
})
#
output$splomCorrEstacionesPlotOut <- renderPlotly({
  dsBase <- medicionEstacionData
  req(dsBase)
  #
  if(input$splomCorrEstacionesFiltroEstacion != "T") {
     dsBase <- dsBase %>% filter(ESTACION == input$splomCorrEstacionesFiltroEstacion)
  }
  #
  if(!is.null(input$splomCorrEstacionesMes)) {
     dsBase <- dsBase %>% filter(MES %in% input$splomCorrEstacionesMes)
  }
  #
  if(input$splomCorrEstacionesDiaMes != "T") {
     dsBase <- dsBase %>% filter(DIA_MES == input$splomCorrEstacionesDiaMes)
  }
  #
  if(!is.null(input$splomCorrEstacionesDiaSem)) {
     dsBase <- dsBase %>% filter(DIA_SEMANA %in% input$splomCorrEstacionesDiaSem)
  }
  #
  shiny::validate(
    shiny::need((nrow(dsBase) > 0) && (nrow(dsBase) < 5000), # Este check valida la condicion de forma "afirmativa"..
                "No se tienen mediciones disponibles para los filtros usados.")
  )
  # Se usa el metodo "na.omit" para quitar las filas con valores NA en alguna celda.
  cast_data <- na.omit(dsBase[mediasColNames])
  names(cast_data) <- paramsColNames
  #
  pm <- GGally::ggpairs(cast_data, lower = list(continuous = "smooth"), mapping = ggplot2::aes(colour=I("cadetblue")))
  ggplotly(pm)
})
#
output$heatmapEstacionesPlotOut <- renderPlotly({
  dsBase <- medicionEstacionData
  req(dsBase)
  #
  if(input$heatmapEstacionesFiltroEstacion != "T") {
     dsBase <- dsBase %>% filter(ESTACION == input$heatmapEstacionesFiltroEstacion)
  }
  #
  if(!is.null(input$heatmapEstacionesMes)) {
     dsBase <- dsBase %>% filter(MES %in% input$heatmapEstacionesMes)
  }
  #
  if(input$heatmapEstacionesDiaMes != "T") {
     dsBase <- dsBase %>% filter(DIA_MES == input$heatmapEstacionesDiaMes)
  }
  #
  if(!is.null(input$heatmapEstacionesDiaSem)) {
     dsBase <- dsBase %>% filter(DIA_SEMANA %in% input$heatmapEstacionesDiaSem)
  }
  #
  shiny::validate(
    shiny::need((nrow(dsBase) > 0) && (nrow(dsBase) < 5000), # Este check valida la condicion de forma "afirmativa"..
                "No se tienen mediciones disponibles para los filtros usados.")
  )
  # Se usa el metodo "na.omit" para quitar las filas con valores NA en alguna celda.
  cast_data <- na.omit(dsBase[mediasColNames])
  names(cast_data) <- paramsColNames
  #
  if(input$heatmapEstacionesTransType == "Normalizar") {
    cast_data <- heatmaply::normalize(cast_data)
  }
  #
  if(input$heatmapEstacionesTransType == "Escalar") {
    hpy <- heatmaply(cast_data, scale = "column", margins = c(60,100,40,20), colors = RdYlBu,
              main = paste("Transformaci\u00F3n aplicada:", input$heatmapEstacionesTransType),
              xlab = "par\u00E1metro", ylab = "Fila:valor", k_col = 2, k_row = 3, dendrogram = input$heatmapEstacionesDendroType)
  } else {
    hpy <- heatmaply(cast_data, margins = c(60,100,40,20), k_col = 2, k_row = 3, colors = Oranges,
              main = paste("Transformaci\u00F3n aplicada:", input$heatmapEstacionesTransType),
              xlab = "par\u00E1metro", ylab = "Fila:valor", dendrogram = input$heatmapEstacionesDendroType)
  }
  return(hpy)
})
#
