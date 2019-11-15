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
  if(!is.null(input$hcEstacionesMes)) {
     dsMesEstacion <- dsMesEstacion %>% filter(MES %in% input$hcEstacionesMes)
  }
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
  # Se procede a realizar la creacion de un data.frame que contenga las 144
  # filas de la hipercarta base, pero en las filas donde no hayan datos
  # en la bitacora del mes, se deja el valor NA. Lo cual permite
  # que la serie en dyGraphs se presente por segmentos.
  dataParamSerie <- dsMesEstacion[c("id_t", input$hipercartaEstacionesSel)]
  names(dataParamSerie) <- c("id_t", "parametro_estacion")
  # data.frame a ser usado como anexo al dataSerie para la hipercarta completa:
  dataSerieToBind <- data.frame("parametro_estacion"=1:nrow(dsBase))
  dataSerieToBind$parametro_estacion <- NA # por defecto sin valor
  #
  for(k in 1:nrow(dataParamSerie)) {
     # En el DF dataSerieToBind se asigna el valor del dataParamSerie("parametro_estacion"->k,2, fila k, columna 2)
     # usando como indice el dataParamSerie("id_t"->k,1, fila k, columna 1)). Aqui en particular se lee el valor
     # puntual usando el operador [[n]], pues sin ello R retorna un elemento tipo list.
     dataSerieToBind$parametro_estacion[dataParamSerie[[k,1]]] <- dataParamSerie[[k,2]]
  }
  # Obtencion del Data Frame de la serie usando manejo de columnas, funciona OK:
  # UTIL! cbind: combiana dos data.frame con el mismo numero de filas.
  dataSerie <- cbind(dsBase[hiperParams], dataSerieToBind)
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
     # UTIL! la funcion sub(..) reemplaza por vacio ("") el resto del string luego del primer espacio de izq. a der.
     # --> Asi se obtiene la primera palabra del string.
     param_name_label <- sub( "\\s.*", "", selected_label)
     #
     gSerie <- gSerie %>% dySeries("parametro_estacion", label=paste("Par\u00E1metro", param_name_label)) %>%
                          dySeries(c("lwr", "fit", "upr"), label=paste("Hipercarta", param_name_label))
  }
  if(!input$hcEstacionesShowgridCheck) {
     gSerie <- gSerie %>% dyCrosshair()
  }
  #
  return(gSerie)
})
#
