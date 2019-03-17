# autor -------------------------------------------------------------------
# carlos.perez7@udea.edu.co
# 01/02/2019 9:26:08 a. m.
#
# cartaControlData <- eventReactive(input$loadDatosCartaButton, {
#    ccData <- read_excel("C:\\Temp\\Datos_Carta_Control_Detalle.xlsx")
#    return(ccData)
# })
#
output$dySerieFrom <- renderText({
  req(input$serieConductPlot_date_window[[1]])
})
#
output$dySerieTo <- renderText({
  req(input$serieConductPlot_date_window[[2]])
})
#
output$dySerieClicked <- renderText({
  req(input$serieConductPlot_click$x)
})
#
output$dySeriePoint <- renderText({
  paste0('X = ', req(input$serieConductPlot_click$x_closest_point),
         '; Y = ', req(input$serieConductPlot_click$y_closest_point))
})
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
  if(input$tipoSerie == "Intervalo de Confianza") {
     colnames(dataSerie) <- c("id_t", "lwr", "fit", "upr")
  }
  #
  gSerie <- dygraph(dataSerie, main = "Serie Hipercarta: Conductividad",
                    xlab="id_t", ylab="Conductividad", group="ghiper_sincro") %>%
               dyRangeSelector() %>%  dyHighlight(highlightSeriesOpts = list(strokeWidth = 2)) %>%
               dyOptions(drawGrid=input$showgrid, drawPoints=TRUE, pointSize=2, pointShape="dot", fillGraph = TRUE) %>%
               dyLegend(width = 500)
  #
  if(input$tipoSerie == "Intervalo de Confianza") {
     gSerie <- gSerie %>% dySeries(c("lwr", "fit", "upr"), label = "Conductividad")
  }
  if(!input$showgrid) {
     gSerie <- gSerie %>% dyCrosshair() # %>%  dyOptions(fillGraph = TRUE)
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
  if(input$tipoSerie == "Intervalo de Confianza") {
     colnames(dataSerie) <- c("id_t", "lwr", "fit", "upr")
  }
  #
  gSerie <- dygraph(dataSerie, main = "Serie Hipercarta: PH",
                    xlab="id_t", ylab="PH", group="ghiper_sincro") %>%
               dyRangeSelector() %>%  dyHighlight(highlightSeriesOpts = list(strokeWidth = 2)) %>%
               dyOptions(drawGrid=input$showgrid, drawPoints=TRUE, pointSize=2, pointShape="dot") %>%
               dyLegend(width = 500)
  #
  if(input$tipoSerie == "Intervalo de Confianza") {
     gSerie <- gSerie %>% dySeries(c("lwr", "fit", "upr"), label = "PH")
  }
  if(!input$showgrid) {
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
  if(input$tipoSerie == "Intervalo de Confianza") {
     colnames(dataSerie) <- c("id_t", "lwr", "fit", "upr")
  }
  #
  gSerie <- dygraph(dataSerie, main = "Serie Hipercarta: OD",
                    xlab="id_t", ylab="OD", group="ghiper_sincro") %>%
               dyRangeSelector() %>%  dyHighlight(highlightSeriesOpts = list(strokeWidth = 2)) %>%
               dyOptions(drawGrid=input$showgrid, drawPoints=TRUE, pointSize=2,
                         colors = RColorBrewer::brewer.pal(3, "Set1"), pointShape="dot") %>%
               dyLegend(width = 500)
  #
  if(input$tipoSerie == "Intervalo de Confianza") {
     gSerie <- gSerie %>% dySeries(c("lwr", "fit", "upr"), label = "OD")
  }
  if(!input$showgrid) {
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
  if(input$tipoSerie == "Intervalo de Confianza") {
     colnames(dataSerie) <- c("id_t", "lwr", "fit", "upr")
  }
  #
  gSerie <- dygraph(dataSerie, main = "Serie Hipercarta: Turbiedad",
                    xlab="id_t", ylab="Turbiedad", group="ghiper_sincro") %>%
               dyRangeSelector() %>%  dyHighlight(highlightSeriesOpts = list(strokeWidth = 2)) %>%
               dyOptions(drawGrid=input$showgrid, drawPoints=TRUE, pointSize=2,
                         colors = RColorBrewer::brewer.pal(3, "Dark2"), pointShape="dot") %>%
               dyLegend(width = 500)
  #
  if(input$tipoSerie == "Intervalo de Confianza") {
     gSerie <- gSerie %>% dySeries(c("lwr", "fit", "upr"), label = "Turbiedad")
  }
  if(!input$showgrid) {
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
  if(input$tipoSerie == "Intervalo de Confianza") {
     colnames(dataSerie) <- c("id_t", "lwr", "fit", "upr")
  }
  #
  gSerie <- dygraph(dataSerie, main = "Serie Hipercarta: POT REDOX",
                    xlab="id_t", ylab="POT REDOX", group="ghiper_sincro") %>%
               dyRangeSelector() %>%  dyHighlight(highlightSeriesOpts = list(strokeWidth = 2)) %>%
               dyOptions(drawGrid=input$showgrid, drawPoints=TRUE, pointSize=2,
                         colors = RColorBrewer::brewer.pal(3, "Dark2"), pointShape="dot") %>%
               dyLegend(width = 500)
  #
  if(input$tipoSerie == "Intervalo de Confianza") {
     gSerie <- gSerie %>% dySeries(c("lwr", "fit", "upr"), label = "POT REDOX")
  }
  if(!input$showgrid) {
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
  if(input$tipoSerie == "Intervalo de Confianza") {
     colnames(dataSerie) <- c("id_t", "lwr", "fit", "upr")
  }
  #
  gSerie <- dygraph(dataSerie, main = "Serie Hipercarta: Temperatura",
                    xlab="id_t", ylab="Temperatura", group="ghiper_sincro") %>%
               dyRangeSelector() %>%  dyHighlight(highlightSeriesOpts = list(strokeWidth = 2)) %>%
               dyOptions(drawGrid=input$showgrid, drawPoints=TRUE, pointSize=2,
                         colors = RColorBrewer::brewer.pal(3, "Dark2"), pointShape="dot") %>%
               dyLegend(width = 500)
  #
  if(input$tipoSerie == "Intervalo de Confianza") {
     gSerie <- gSerie %>% dySeries(c("lwr", "fit", "upr"), label = "Temperatura")
  }
  if(!input$showgrid) {
     gSerie <- gSerie %>% dyCrosshair()
  }
  #
  return(gSerie)
})
#
# INICIO SERIES DE HIPERCARTA --< DETALLE CARTA DE CONTROL:
#
output$hipercartaBasePlot <- renderDygraph({
  dsBase <- hiperCartaData
  req(dsBase)
  # Obtencion del Data Frame de la serie usando manejo de columnas, funciona OK:
  dataSerie <- dsBase[c("id_t", "LI_Condu", "MEDIA_Condu", "LS_Condu")]
  #
  if(input$ccTipoCarta == "Intervalo de Confianza") {
     colnames(dataSerie) <- c("id_t", "lwr", "fit", "upr")
  }
  #
  gSerie <- dygraph(dataSerie, main = "Conductividad",
                    xlab="id_t hipercarta", ylab="Conductividad") %>%
               dyRangeSelector() %>% dyHighlight(highlightSeriesOpts = list(strokeWidth = 2)) %>%
               dyOptions(drawGrid=input$ccShowgridCheck, drawPoints=TRUE, pointSize=2, pointShape="dot") %>%
               dyLegend(width = 500)
  #
  if(input$ccTipoCarta == "Intervalo de Confianza") {
     gSerie <- gSerie %>% dySeries(c("lwr", "fit", "upr"), label = "Media Conductividad")
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
  # Obtencion del Data Frame de la serie usando manejo de columnas, funciona OK:
  dataSerie <- cartaControlData %>%
               filter(id_t == input$hipercartaBasePlot_click$x) %>%
               select("CONDUCTIVIDAD", "TIPO_DIA", "MES", "DIA_SEMANA")
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
                 select("LI_Condu", "MEDIA_Condu", "LS_Condu")
  #
  # Finalmente se deja la columna efectiva para la serie:
  dataSerie <- dataSerie %>% select("CONDUCTIVIDAD")
  # Se adiciona explicitamente la columna el numero de fila como "row_id":
  dataSerie$row_id <- seq(1:(nrow(dataSerie)))
  # Reordenamiento de las columnas del data_frame para que el row_id sea la primera
  # que el "dygraph" lo usa para el eje X:
  dataSerie <- dataSerie[c("row_id", "CONDUCTIVIDAD")]
  #
  gSerie <- dygraph(dataSerie, main = "Conductividad",
                    xlab=paste("Observaciones id_t =", input$hipercartaBasePlot_click$x),
                    ylab="Conductividad Medido") %>%
               dyRangeSelector() %>%  dyHighlight(highlightSeriesOpts = list(strokeWidth = 2)) %>%
               dyOptions(drawGrid=input$ccShowgridCheck, drawPoints=TRUE, pointSize=2, fillGraph = TRUE,
                         axisLineColor = "navy", gridLineColor = "lightblue", pointShape="ex") %>%
               dySeries("CONDUCTIVIDAD", label = "Valor Puntual CONDUCTIVIDAD", color = "blue") %>% # Usar un label especifico
               dyLimit(as.numeric(hcIntervalo["LI_Condu"]), color = "red",
                       label = as.character(hcIntervalo["LI_Condu"])) %>%
               dyLimit(as.numeric(hcIntervalo["MEDIA_Condu"]), color = "red",
                       label = as.character(hcIntervalo["MEDIA_Condu"]), labelLoc = "right") %>% # left
               dyLimit(as.numeric(hcIntervalo["LS_Condu"]), color = "red",
                       label = as.character(hcIntervalo["LS_Condu"])) %>%
               dyShading(from = as.numeric(hcIntervalo["LI_Condu"]),
                         to = as.numeric(hcIntervalo["LS_Condu"]), axis = "y") %>%
               dyLegend(width = 500)
  #
  if(!input$ccShowgridCheck) {
     gSerie <- gSerie %>% dyCrosshair()
  }
  #
  return(gSerie)
})
#
