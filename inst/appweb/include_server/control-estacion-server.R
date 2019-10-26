# autor -------------------------------------------------------------------
# carlos.perez7@udea.edu.co
# carlos.perezoft@gmail.com
# 25/10/2019 2:42:08 p. m.
#
#
# INICIO SERIES DE HIPERCARTA --< DETALLE CARTA DE CONTROL:
#
output$hipercartaEstacionesPlot <- renderDygraph({
  dsBase <- hiperCartaData
  req(dsBase)
  #
  dsMesEstacion <- medicionEstacionData
  req(dsMesEstacion)
  #
  dsMesEstacion <- dsMesEstacion %>% filter(ESTACION == input$hiperEstacionFiltroEstacion)
  #
  dsMesEstacion <- dsMesEstacion %>% filter(DIA_MES == input$hiperEstacionDiaMes)
  #
  shiny::validate(
    shiny::need(nrow(dsMesEstacion) > 0, # Este check valida la condicion de forma "afirmativa"..
                "No se tienen mediciones disponibles para los filtros usados.")
  )
  #
  hiperSel <- input$hipercartaEstacionesSel
  hiperParams <- switch(hiperSel,
     "MEDIA_Condu" = c("id_t", "LI_Condu", "MEDIA_Condu", "LS_Condu"),
     "MEDIA_ph" = c("id_t", "LI_ph", "MEDIA_ph", "LS_ph"),
     "MEDIA_od" = c("id_t", "LI_od", "MEDIA_od", "LS_od"),
     "MEDIA_turb" = c("id_t", "LI_turb", "MEDIA_turb", "LS_turb"),
     "MEDIA_pot_redox" = c("id_t", "LI_pot_redox", "MEDIA_pot_redox", "LS_pot_redox"),
     "MEDIA_tempera" = c("id_t", "LI_tempera", "MEDIA_tempera", "LS_tempera")
  )
  #
  dataParamSerie <- dsMesEstacion[c(input$hipercartaEstacionesSel)]
  names(dataParamSerie) <- c("parametro_estacion")
  # Obtencion del Data Frame de la serie usando manejo de columnas, funciona OK:
  dataSerie <- cbind(dsBase[hiperParams], dataParamSerie)
  #
  if(input$hcEstacionesTipoCarta == "INT_CONF") {
     colnames(dataSerie) <- c("id_t", "lwr", "fit", "upr", "parametro_estacion")
  }
  #
  selected_label <- media_labels %>% filter(variable == hiperSel) %>% select("desc")
  #
  gSerie <- dygraph(dataSerie, main=sprintf("%s",selected_label),
                    xlab=paste("t por Hipercarta"), ylab=paste("Intervalo para:", selected_label)) %>%
               dyRangeSelector() %>% dyHighlight(highlightSeriesOpts = list(strokeWidth = 2)) %>%
               dyOptions(drawGrid=input$hcEstacionesShowgridCheck, drawPoints=TRUE, pointSize=2, pointShape="dot") %>%
               dyLegend(width=700)
  #
  if(input$hcEstacionesTipoCarta == "INT_CONF") {
     gSerie <- gSerie %>% dySeries("parametro_estacion", label=paste("Par\u00E1metro", hiperSel)) %>%
                          dySeries(c("lwr", "fit", "upr"), label=paste("Hipercarta", hiperSel))
  }
  if(!input$hcEstacionesShowgridCheck) {
     gSerie <- gSerie %>% dyCrosshair()
  }
  #
  return(gSerie)
})
#
