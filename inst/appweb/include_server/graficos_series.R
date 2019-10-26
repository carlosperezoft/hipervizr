# autor -------------------------------------------------------------------
# carlos.perez7@udea.edu.co
# 01/02/2019 9:26:08 a. m.
#
#
output$serieConductPlot <- renderDygraph({
  dsBase <- hiperCartaData
  req(dsBase)
  # Obtencion del Data Frame de la serie usando manejo de columnas, funciona OK:
  dataSerie <- dsBase[c("id_t", "LI_Condu", "MEDIA_Condu", "LS_Condu")]
  #colnames(dataSerie) <- c("id_t", "lwr", "fit", "upr")
  # Obtencion del Data Frame de la serie usando manejo DATA FRAMES de forma mas directa, funciona OK:
  # NOTA: La primera columna de la serie debe ser siempre el ID o FECHA:
  # dataSerie <- data.frame(dsBase$id_t, lwr=dsBase$Lim_Inf_SST_tr, fit=dsBase$Media_SST_tr, upr=dsBase$Lim_Sup_SST_tr)
  if(input$tipoSerie == "INT_CONF") {
     colnames(dataSerie) <- c("id_t", "lwr", "fit", "upr")
  }
  #
  gSerie <- dygraph(dataSerie, main = paste("Serie Hipercarta:", media_labels[2,2]),
                    xlab="id_t", ylab=media_labels[2,2], group="ghiper_sincro") %>%
               dyRangeSelector() %>%  dyHighlight(highlightSeriesOpts = list(strokeWidth = 2)) %>%
               dyOptions(drawGrid=input$mosaicoShowGrid, fillGraph=input$mosaicoShowArea,
                         drawPoints=TRUE, pointSize=2, pointShape="dot") %>%
               dyLegend(width = 500)
  #
  if(input$tipoSerie == "INT_CONF") {
     gSerie <- gSerie %>% dySeries(c("lwr", "fit", "upr"), label = "Conductividad")
  }
  if(!input$mosaicoShowGrid) {
     gSerie <- gSerie %>% dyCrosshair()
  }
  #
  return(gSerie)
})
#
output$seriePHPlot <- renderDygraph({
  dsBase <- hiperCartaData
  req(dsBase)
  # Obtencion del Data Frame de la serie usando manejo de columnas, funciona OK:
  dataSerie <- dsBase[c("id_t", "LI_ph", "MEDIA_ph", "LS_ph")]
  #
  if(input$tipoSerie == "INT_CONF") {
     colnames(dataSerie) <- c("id_t", "lwr", "fit", "upr")
  }
  #
  gSerie <- dygraph(dataSerie, main = paste("Serie Hipercarta:", media_labels[3,2]),
                    xlab="id_t", ylab=media_labels[3,2], group="ghiper_sincro") %>%
               dyRangeSelector() %>%  dyHighlight(highlightSeriesOpts = list(strokeWidth = 2)) %>%
               dyOptions(drawGrid=input$mosaicoShowGrid, fillGraph=input$mosaicoShowArea,
                         drawPoints=TRUE, pointSize=2, pointShape="dot") %>%
               dyLegend(width = 500)
  #
  if(input$tipoSerie == "INT_CONF") {
     gSerie <- gSerie %>% dySeries(c("lwr", "fit", "upr"), label = "pH")
  }
  if(!input$mosaicoShowGrid) {
     gSerie <- gSerie %>% dyCrosshair()
  }
  #
  return(gSerie)
})
#
output$serieODPlot <- renderDygraph({
  dsBase <- hiperCartaData
  req(dsBase)
  # Obtencion del Data Frame de la serie usando manejo de columnas, funciona OK:
  dataSerie <- dsBase[c("id_t", "LI_od", "MEDIA_od", "LS_od")]
  #
  if(input$tipoSerie == "INT_CONF") {
     colnames(dataSerie) <- c("id_t", "lwr", "fit", "upr")
  }
  #
  gSerie <- dygraph(dataSerie, main = paste("Serie Hipercarta:", media_labels[4,2]),
                    xlab="id_t", ylab=media_labels[4,2], group="ghiper_sincro") %>%
               dyRangeSelector() %>%  dyHighlight(highlightSeriesOpts = list(strokeWidth = 2)) %>%
               dyOptions(drawGrid=input$mosaicoShowGrid, fillGraph=input$mosaicoShowArea, drawPoints=TRUE, pointSize=2,
                         colors = RColorBrewer::brewer.pal(3, "Set1"), pointShape="dot") %>%
               dyLegend(width = 500)
  #
  if(input$tipoSerie == "INT_CONF") {
     gSerie <- gSerie %>% dySeries(c("lwr", "fit", "upr"), label = "Oxig. Disuelto")
  }
  if(!input$mosaicoShowGrid) {
     gSerie <- gSerie %>% dyCrosshair()
  }
  #
  return(gSerie)
})
#
output$serieTurbPlot <- renderDygraph({
  dsBase <- hiperCartaData
  req(dsBase)
  # Obtencion del Data Frame de la serie usando manejo de columnas, funciona OK:
  dataSerie <- dsBase[c("id_t", "LI_turb", "MEDIA_turb", "LS_turb")]
  #
  if(input$tipoSerie == "INT_CONF") {
     colnames(dataSerie) <- c("id_t", "lwr", "fit", "upr")
  }
  #
  gSerie <- dygraph(dataSerie, main = paste("Serie Hipercarta:", media_labels[5,2]),
                    xlab="id_t", ylab=media_labels[5,2], group="ghiper_sincro") %>%
               dyRangeSelector() %>%  dyHighlight(highlightSeriesOpts = list(strokeWidth = 2)) %>%
               dyOptions(drawGrid=input$mosaicoShowGrid, fillGraph=input$mosaicoShowArea, drawPoints=TRUE, pointSize=2,
                         colors = RColorBrewer::brewer.pal(3, "Dark2"), pointShape="dot") %>%
               dyLegend(width = 500)
  #
  if(input$tipoSerie == "INT_CONF") {
     gSerie <- gSerie %>% dySeries(c("lwr", "fit", "upr"), label = "Turbiedad")
  }
  if(!input$mosaicoShowGrid) {
     gSerie <- gSerie %>% dyCrosshair()
  }
  #
  return(gSerie)
})
#
output$seriePotRedoxPlot <- renderDygraph({
  dsBase <- hiperCartaData
  req(dsBase)
  # Obtencion del Data Frame de la serie usando manejo de columnas, funciona OK:
  dataSerie <- dsBase[c("id_t", "LI_pot_redox", "MEDIA_pot_redox", "LS_pot_redox")]
  #
  if(input$tipoSerie == "INT_CONF") {
     colnames(dataSerie) <- c("id_t", "lwr", "fit", "upr")
  }
  #
  gSerie <- dygraph(dataSerie, main = paste("Serie Hipercarta:",media_labels[6,2]),
                    xlab="id_t", ylab=media_labels[6,2], group="ghiper_sincro") %>%
               dyRangeSelector() %>%  dyHighlight(highlightSeriesOpts = list(strokeWidth = 2)) %>%
               dyOptions(drawGrid=input$mosaicoShowGrid, fillGraph=input$mosaicoShowArea, drawPoints=TRUE, pointSize=2,
                         colors = RColorBrewer::brewer.pal(3, "Dark2"), pointShape="dot") %>%
               dyLegend(width = 500)
  #
  if(input$tipoSerie == "INT_CONF") {
     gSerie <- gSerie %>% dySeries(c("lwr", "fit", "upr"), label = "POT REDOX")
  }
  if(!input$mosaicoShowGrid) {
     gSerie <- gSerie %>% dyCrosshair()
  }
  #
  return(gSerie)
})
#
output$serieTemperaPlot <- renderDygraph({
  dsBase <- hiperCartaData
  req(dsBase)
  # Obtencion del Data Frame de la serie usando manejo de columnas, funciona OK:
  dataSerie <- dsBase[c("id_t", "LI_tempera", "MEDIA_tempera", "LS_tempera")]
  #
  if(input$tipoSerie == "INT_CONF") {
     colnames(dataSerie) <- c("id_t", "lwr", "fit", "upr")
  }
  #
  gSerie <- dygraph(dataSerie, main = paste("Serie Hipercarta:",media_labels[7,2]),
                    xlab="id_t", ylab=media_labels[7,2], group="ghiper_sincro") %>%
               dyRangeSelector() %>%  dyHighlight(highlightSeriesOpts = list(strokeWidth = 2)) %>%
               dyOptions(drawGrid=input$mosaicoShowGrid, fillGraph=input$mosaicoShowArea, drawPoints=TRUE, pointSize=2,
                         colors = RColorBrewer::brewer.pal(3, "Dark2"), pointShape="dot") %>%
               dyLegend(width = 500)
  #
  if(input$tipoSerie == "INT_CONF") {
     gSerie <- gSerie %>% dySeries(c("lwr", "fit", "upr"), label = "Temperatura")
  }
  if(!input$mosaicoShowGrid) {
     gSerie <- gSerie %>% dyCrosshair()
  }
  #
  return(gSerie)
})
#
# INICIO SERIES DE HIPERCARTA --> DETALLE CARTA DE CONTROL:
#
output$hipercartaBasePlot <- renderDygraph({
  dsBase <- hiperCartaData
  req(dsBase)
  #
  hiperSel <- input$hipercartaBaseSel
  hiperParams <- switch(hiperSel,
     "MEDIA_Condu" = c("id_t", "LI_Condu", "MEDIA_Condu", "LS_Condu"),
     "MEDIA_ph" = c("id_t", "LI_ph", "MEDIA_ph", "LS_ph"),
     "MEDIA_od" = c("id_t", "LI_od", "MEDIA_od", "LS_od"),
     "MEDIA_turb" = c("id_t", "LI_turb", "MEDIA_turb", "LS_turb"),
     "MEDIA_tempera" = c("id_t", "LI_tempera", "MEDIA_tempera", "LS_tempera")
  )
  #
  # Obtencion del Data Frame de la serie usando manejo de columnas, funciona OK:
  dataSerie <- dsBase[hiperParams]
  #
  if(input$ccTipoCarta == "INT_CONF") {
     colnames(dataSerie) <- c("id_t", "lwr", "fit", "upr")
  }
  #
  selected_label <- media_labels %>% filter(variable == hiperSel) %>% select("desc")
  #
  gSerie <- dygraph(dataSerie, main=sprintf("%s",selected_label),
                    xlab=paste("t por Hipercarta"), ylab=paste("Intervalo para:", selected_label)) %>%
               dyRangeSelector() %>% dyHighlight(highlightSeriesOpts = list(strokeWidth = 2)) %>%
               dyOptions(drawGrid=input$ccShowgridCheck, drawPoints=TRUE, pointSize=2, pointShape="dot") %>%
               dyLegend(width=500)
  #
  if(input$ccTipoCarta == "INT_CONF") {
     # UTIL! la funcion sub(..) reemplaza por vacio ("") el resto del string luego del primer espacio de izq. a der.
     # --> Asi se obtiene la primera palabra del string.
     param_name_label <- sub( "\\s.*", "", selected_label)
     #
     gSerie <- gSerie %>% dySeries(c("lwr", "fit", "upr"), label=paste("Media", param_name_label))
  }
  if(!input$ccShowgridCheck) {
     gSerie <- gSerie %>% dyCrosshair()
  }
  #
  return(gSerie)
})
#
output$cartaControlDetallePlot <- renderDygraph({
  req(cartaControlData)
  req(input$hipercartaBasePlot_click$x)
  #
  hiperSel <- input$hipercartaBaseSel
  # Inicialmente se seleccionan las columnas segun el parametro:
  hiperParams <- switch(hiperSel,
     "MEDIA_Condu" = c("LI_Condu", "MEDIA_Condu", "LS_Condu"),
     "MEDIA_ph" = c("LI_ph", "MEDIA_ph", "LS_ph"),
     "MEDIA_od" = c("LI_od", "MEDIA_od", "LS_od"),
     "MEDIA_turb" = c("LI_turb", "MEDIA_turb", "LS_turb"),
     "MEDIA_tempera" = c("LI_tempera", "MEDIA_tempera", "LS_tempera")
  )
  # Luego se restaura el valor a las columnas que tiene la carta de control:
  hiperSel <- switch(hiperSel,
     "MEDIA_Condu" = "CONDUCTIVIDAD",
     "MEDIA_ph" = "PH",
     "MEDIA_od" = "OD",
     "MEDIA_turb" = "TURBIEDAD",
     "MEDIA_tempera" = "TEMPERATURA"
  )
  # Obtencion del Data Frame de la serie usando manejo de columnas, funciona OK:
  dataSerie <- cartaControlData %>%
               filter(id_t == input$hipercartaBasePlot_click$x) %>%
               select(hiperSel, "TIPO_DIA", "MES", "DIA_SEMANA")
  #
  # Se procede a calcular la hora del T-subj seleccionado:
  dataHipercartaTime <- cartaControlData %>%
               filter(id_t == input$hipercartaBasePlot_click$x) %>%
               select("id_t", "HORA_PARCIAL", "SEXTO")
  #
  # La primera es util, pues todas tienen el mismo valor para las cols seleccionadas:
  dataHipercartaTime <- dataHipercartaTime[1,]
  horaT <- paste0(dataHipercartaTime[1, "HORA_PARCIAL"], ":", 10*(as.numeric(dataHipercartaTime[1, "SEXTO"])-1))
  #
  if(input$ccTipoDia != 0) {
     dataSerie <- dataSerie %>% filter(TIPO_DIA == input$ccTipoDia)
  }
  #
  if(input$ccMes != 0) {
     dataSerie <- dataSerie %>% filter(MES == input$ccMes)
  }
  #
  if(input$ccDiaSemana != 0) {
     dataSerie <- dataSerie %>% filter(DIA_SEMANA == input$ccDiaSemana)
  }
  #
  shiny::validate(
    shiny::need(nrow(dataSerie) > 0, # Este check valida la condicion de forma "afirmativa"..
                "No se tienen observaciones en la Carta de Control para los filtros usados.")
  )
  #
  hcIntervalo <- hiperCartaData %>%
                 filter(id_t == input$hipercartaBasePlot_click$x) %>%
                 select(hiperParams)
  #
  # Finalmente se deja la columna efectiva para la serie:
  dataSerie <- dataSerie %>% select(hiperSel)
  # Se adiciona explicitamente la columna el numero de fila como "row_id":
  dataSerie$row_id <- seq(1:(nrow(dataSerie)))
  # Reordenamiento de las columnas del data_frame para que el row_id sea la primera
  # que el "dygraph" lo usa para el eje X:
  dataSerie <- dataSerie[c("row_id", hiperSel)]
  #
  gSerie <- dygraph(dataSerie, main = paste(hiperSel, "t =", horaT),
                    xlab=paste("Observaciones t =", input$hipercartaBasePlot_click$x, "[", horaT, "]"),
                    ylab=paste("Monitoreo de:", hiperSel)) %>%
               dyRangeSelector() %>%  dyHighlight(highlightSeriesOpts = list(strokeWidth = 2)) %>%
               dyOptions(drawGrid=input$ccShowgridCheck, drawPoints=TRUE, pointSize=2, fillGraph = TRUE,
                         includeZero = input$cartaCShowCero, axisLineColor = "navy", gridLineColor = "lightblue", pointShape="ex") %>%
               dySeries(hiperSel, label=paste("Valor Puntual", hiperSel), color = "blue") %>% # Usar un label especifico
               dyLimit(as.numeric(hcIntervalo[hiperParams[1]]), color = "red",
                       label = as.character(hcIntervalo[hiperParams[1]])) %>%  # hiperParams se usa un indice por ser (c)Vector
               dyLimit(as.numeric(hcIntervalo[hiperParams[2]]), color = "red",
                       label = as.character(hcIntervalo[hiperParams[2]]), labelLoc = "right") %>% # left
               dyLimit(as.numeric(hcIntervalo[hiperParams[3]]), color = "red",
                       label = as.character(hcIntervalo[hiperParams[3]])) %>%
               dyShading(from = as.numeric(hcIntervalo[hiperParams[1]]),
                         to = as.numeric(hcIntervalo[hiperParams[3]]), axis = "y") %>%
               dyLegend(width = 500)
  #
  if(!input$ccShowgridCheck) {
     gSerie <- gSerie %>% dyCrosshair()
  }
  #
  return(gSerie)
})
#
