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
  req(input$serieBaseHiperPlot_date_window[[1]])
})
#
output$dySerieTo <- renderText({
  req(input$serieBaseHiperPlot_date_window[[2]])
})
#
output$dySerieClicked <- renderText({
  req(input$serieBaseHiperPlot_click$x)
})
#
output$dySeriePoint <- renderText({
  paste0('X = ', req(input$serieBaseHiperPlot_click$x_closest_point),
         '; Y = ', req(input$serieBaseHiperPlot_click$y_closest_point))
})
#
output$serieBaseHiperPlot <- renderDygraph({
  dsBase <- hiperCartaData
  req(dsBase)
  # Obtencion del Data Frame de la serie usando manejo de columnas, funciona OK:
  dataSerie <- dsBase[c("id_t", "Lim_Inf_SST_tr", "Media_SST_tr", "Lim_Sup_SST_tr")]
  #colnames(dataSerie) <- c("id_t", "lwr", "fit", "upr")
  # Obtencion del Data Frame de la serie usando manejo DATA FRAMES de forma mas directa, funciona OK:
  # NOTA: La primera columna de la serie debe ser siempre el ID o FECHA:
  # dataSerie <- data.frame(dsBase$id_t, lwr=dsBase$Lim_Inf_SST_tr, fit=dsBase$Media_SST_tr, upr=dsBase$Lim_Sup_SST_tr)
  if(input$tipoSerie == "Intervalo de Confianza") {
     colnames(dataSerie) <- c("id_t", "lwr", "fit", "upr")
  }
  #
  gSerie <- dygraph(dataSerie, main = "Serie Hipercarta: SST_tr",
                    xlab="id_t", ylab="SST_tr", group="ghiper_sincro") %>%
               dyRangeSelector() %>%  dyHighlight(highlightSeriesOpts = list(strokeWidth = 2)) %>%
               dyOptions(drawGrid=input$showgrid, drawPoints=TRUE, pointSize=2, pointShape="dot") %>%
               dyLegend(width = 500)
  #
  if(input$tipoSerie == "Intervalo de Confianza") {
     gSerie <- gSerie %>% dySeries(c("lwr", "fit", "upr"), label = "S\u00F3lidos Sat. Tr")
  }
  if(!input$showgrid) {
     gSerie <- gSerie %>% dyCrosshair() %>%
                  dyOptions(drawGrid=input$showgrid, stemPlot=TRUE) # Para probar variaciones...
  }
  #
  return(gSerie)
})
#
output$serieSSTHiperPlot <- renderDygraph({
  dsBase <- hiperCartaData
  req(dsBase)
  # Obtencion del Data Frame de la serie usando manejo de columnas, funciona OK:
  dataSerie <- dsBase[c("id_t", "Lim_Inf_SST", "Media_SST", "Lim_Sup_SST")]
  #
  if(input$tipoSerie == "Intervalo de Confianza") {
     colnames(dataSerie) <- c("id_t", "lwr", "fit", "upr")
  }
  #
  gSerie <- dygraph(dataSerie, main = "Serie Hipercarta: SST",
                    xlab="id_t", ylab="SST", group="ghiper_sincro") %>%
               dyRangeSelector() %>%  dyHighlight(highlightSeriesOpts = list(strokeWidth = 2)) %>%
               dyOptions(drawGrid=input$showgrid, drawPoints=TRUE, pointSize=2, pointShape="dot") %>%
               dyLegend(width = 500)
  #
  if(input$tipoSerie == "Intervalo de Confianza") {
     gSerie <- gSerie %>% dySeries(c("lwr", "fit", "upr"), label = "S\u00F3lidos Suspendidos Totales")
  }
  if(!input$showgrid) {
     gSerie <- gSerie %>% dyCrosshair()
  }
  #
  return(gSerie)
})
#
output$serieConductHiperPlot <- renderDygraph({
  dsBase <- hiperCartaData
  req(dsBase)
  # Obtencion del Data Frame de la serie usando manejo de columnas, funciona OK:
  dataSerie <- dsBase[c("id_t", "Lim_Inf_Conduct", "Media_Conduct", "Lim_Sup_Conduct")]
  #
  if(input$tipoSerie == "Intervalo de Confianza") {
     colnames(dataSerie) <- c("id_t", "lwr", "fit", "upr")
  }
  #
  gSerie <- dygraph(dataSerie, main = "Serie Hipercarta: Conductividad",
                    xlab="id_t", ylab="Conductividad", group="ghiper_sincro") %>%
               dyRangeSelector() %>%  dyHighlight(highlightSeriesOpts = list(strokeWidth = 2)) %>%
               dyOptions(drawGrid=input$showgrid, drawPoints=TRUE, pointSize=2,
                         colors = RColorBrewer::brewer.pal(3, "Set1"), pointShape="dot") %>%
               dyLegend(width = 500)
  #
  if(input$tipoSerie == "Intervalo de Confianza") {
     gSerie <- gSerie %>% dySeries(c("lwr", "fit", "upr"), label = "Conductividad")
  }
  if(!input$showgrid) {
     gSerie <- gSerie %>% dyCrosshair()
  }
  #
  return(gSerie)
})
#
output$serieTemperaHiperPlot <- renderDygraph({
  dsBase <- hiperCartaData
  req(dsBase)
  # Obtencion del Data Frame de la serie usando manejo de columnas, funciona OK:
  dataSerie <- dsBase[c("id_t", "Lim_Inf_Tempera", "Media_Tempera", "Lim_Sup_Tempera")]
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
output$hipercartaBasePlot <- renderDygraph({
  dsBase <- hiperCartaData
  req(dsBase)
  # Obtencion del Data Frame de la serie usando manejo de columnas, funciona OK:
  dataSerie <- dsBase[c("id_t", "Lim_Inf_SST", "Media_SST", "Lim_Sup_SST")]
  #
  if(input$ccTipoCarta == "Intervalo de Confianza") {
     colnames(dataSerie) <- c("id_t", "lwr", "fit", "upr")
  }
  #
  gSerie <- dygraph(dataSerie, main = "S\u00F3lidos Suspendidos Totales (SST)",
                    xlab="id_t hipercarta", ylab="SST Agrupado") %>%
               dyRangeSelector() %>% dyHighlight(highlightSeriesOpts = list(strokeWidth = 2)) %>%
               dyOptions(drawGrid=input$ccShowgridCheck, drawPoints=TRUE, pointSize=2, pointShape="dot") %>%
               dyLegend(width = 500)
  #
  if(input$ccTipoCarta == "Intervalo de Confianza") {
     gSerie <- gSerie %>% dySeries(c("lwr", "fit", "upr"), label = "Media SST")
  }
  if(!input$ccShowgridCheck) {
     gSerie <- gSerie %>% dyCrosshair()
  }
  #
  return(gSerie)
})
#
output$cartaControlSSTPlot <- renderDygraph({
  req(cartaControlData)
  req(input$hipercartaBasePlot_click$x)
  #
  # Obtencion del Data Frame de la serie usando manejo de columnas, funciona OK:
  dataSerie <- cartaControlData %>%
               filter(id_t == input$hipercartaBasePlot_click$x) %>%
               select("VAR_SST", "TIPO_DIA", "MES", "DIA_SEMANA")
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
                 select("Lim_Inf_SST", "Media_SST", "Lim_Sup_SST")
  #
  # Finalmente se deja la columna efectiva para la serie:
  dataSerie <- dataSerie %>% select("VAR_SST")
  # Se adiciona explicitamente la columna el numero de fila como "row_id":
  dataSerie$row_id <- seq(1:(nrow(dataSerie)))
  # Reordenamiento de las columnas del data_frame para que el row_id sea la primera
  # que el "dygraph" lo usa para el eje X:
  dataSerie <- dataSerie[c("row_id", "VAR_SST")]
  #
  gSerie <- dygraph(dataSerie, main = "S\u00F3lidos Suspendidos Totales (SST)",
                    xlab=paste("Observaciones id_t =", input$hipercartaBasePlot_click$x),
                    ylab="SST Medido") %>%
               dyRangeSelector() %>%  dyHighlight(highlightSeriesOpts = list(strokeWidth = 2)) %>%
               dyOptions(drawGrid=input$ccShowgridCheck, drawPoints=TRUE, pointSize=2,
                         axisLineColor = "navy", gridLineColor = "lightblue", pointShape="ex") %>%
               dySeries("VAR_SST", label = "Valor Puntual SST", color = "blue") %>% # Usar un label especifico
               dyLimit(as.numeric(hcIntervalo["Lim_Inf_SST"]), color = "red",
                       label = as.character(hcIntervalo["Lim_Inf_SST"])) %>%
               dyLimit(as.numeric(hcIntervalo["Media_SST"]), color = "red",
                       label = as.character(hcIntervalo["Media_SST"]), labelLoc = "right") %>% # left
               dyLimit(as.numeric(hcIntervalo["Lim_Sup_SST"]), color = "red",
                       label = as.character(hcIntervalo["Lim_Sup_SST"])) %>%
               dyShading(from = as.numeric(hcIntervalo["Lim_Inf_SST"]),
                         to = as.numeric(hcIntervalo["Lim_Sup_SST"]), axis = "y") %>%
               dyLegend(width = 500)
  #
  if(!input$ccShowgridCheck) {
     gSerie <- gSerie %>% dyCrosshair()
  }
  #
  return(gSerie)
})
#
