# autor -------------------------------------------------------------------
# carlos.perez7@udea.edu.co
# 01/02/2019 9:26:08 a. m.
#
dataSeries <- reactive({
   ds <- NULL
   if(input$showgrid) {
      ds <- NULL
   }
   ds <- read_excel("C:\\Temp\\Cartas_Variab_Total_Variable.xlsx")
   return(ds)
})
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
  dsBase <- dataSeries()
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
     gSerie <- gSerie %>% dySeries(c("lwr", "fit", "upr"), label = "Solidos Sat. Tr")
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
  dsBase <- dataSeries()
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
     gSerie <- gSerie %>% dySeries(c("lwr", "fit", "upr"), label = "Solidos Saturados")
  }
  if(!input$showgrid) {
     gSerie <- gSerie %>% dyCrosshair()
  }
  #
  return(gSerie)
})
#
output$serieConductHiperPlot <- renderDygraph({
  dsBase <- dataSeries()
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
  dsBase <- dataSeries()
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
