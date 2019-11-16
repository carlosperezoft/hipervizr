# autor -------------------------------------------------------------------
# carlos.perez7@udea.edu.co
# carlos.perezoft@gmail.com
# 16/11/2019 11:32:08 a. m.
#
#
# INICIO SERIES DE HIPERCARTA --< DETALLE CARTA DE CONTROL:
#
output$hcDiaOnlinePlot <- renderDygraph({
  #
  # Seleccion de la hipercarta de referencia segun la estacion:
  dsBase <- switch(input$hcDiaOnlineFiltroEstacion,
     "1_SAN_MIGUEL" = hcSanMiguelEstacionData,
     "2_ANCON_SUR" = hcAnconSurEstacionData,
     "3_AULA_AMBIENTAL" = hcSanMiguelEstacionData
     )
  #
  req(dsBase)
  #
  # dsMesEstacion <- medicionEstacionData
  # req(dsMesEstacion)
  # #
  # if(!is.null(input$hcDiaOnlineMes)) {
  #    dsMesEstacion <- dsMesEstacion %>% filter(MES %in% input$hcDiaOnlineMes)
  # }
  # #
  # dsMesEstacion <- dsMesEstacion %>% filter(ESTACION == input$hcDiaOnlineFiltroEstacion)
  # #
  # dsMesEstacion <- dsMesEstacion %>% filter(DIA_MES == input$hcDiaOnlineDiaMes)
  #
  # shiny::validate(
  #   shiny::need(nrow(dsMesEstacion) > 0, # Este check valida la condicion de forma "afirmativa"..
  #               "No se tienen mediciones disponibles para los filtros usados.")
  # )
  #
  hiperSel <- input$hcDiaOnlineSel
  hiperParams <- switch(hiperSel,
     "MEDIA_Condu" = c("id_t", "LI_Condu", "MEDIA_Condu", "LS_Condu"),
     "MEDIA_ph" = c("id_t", "LI_ph", "MEDIA_ph", "LS_ph"),
     "MEDIA_od" = c("id_t", "LI_od", "MEDIA_od", "LS_od"),
     "MEDIA_turb" = c("id_t", "LI_turb", "MEDIA_turb", "LS_turb"),
     "MEDIA_pot_redox" = c("id_t", "LI_pot_redox", "MEDIA_pot_redox", "LS_pot_redox"),
     "MEDIA_tempera" = c("id_t", "LI_tempera", "MEDIA_tempera", "LS_tempera")
  )
  #
  # Inicializacion del codigo de la estacion:
  codigoEstacion <- switch(input$hcDiaOnlineFiltroEstacion,
     "1_SAN_MIGUEL" = "61",
     "2_ANCON_SUR" = "62",
     "3_AULA_AMBIENTAL" = "63"
     )
  # Inicializacion del codigo del parametro:
  codigoParam <- switch(hiperSel,
     "MEDIA_Condu" = "conduct",
     "MEDIA_ph" = "ph",
     "MEDIA_od" = "od",
     "MEDIA_turb" = "turbie",
     "MEDIA_pot_redox" = "redox",
     "MEDIA_tempera" = "temp"
  )
  # Inicializacion del codigo del parametro:
  colNameParam <- switch(hiperSel,
     "MEDIA_Condu" = "Conductividad [uS/cm]",
     "MEDIA_ph" = "pH [U.dpH]",
     "MEDIA_od" = "OD [mg/l]",
     "MEDIA_turb" = "Turbiedad [NTU]",
     "MEDIA_pot_redox" = "ORP [mV]",
     "MEDIA_tempera" = "Temperatura [°C]" # <-ocurre un el error al procesar el JSON por el simbolo de grados!
  )
  #
  # Se procede a realizar la creacion de un data.frame que contenga las 144
  # filas de la hipercarta base, pero en las filas donde no hayan datos
  # en la bitacora del mes, se deja el valor NA. Lo cual permite
  # que la serie en dyGraphs se presente por segmentos.
  #
  print(paste0("https://redrio.metropol.gov.co/online2/RealTime?accion=getSerie&estacion=",
                            codigoEstacion, "&param=", codigoParam))
  dataParamOnline <- jsonlite::fromJSON(
                     paste0("https://redrio.metropol.gov.co/online2/RealTime?accion=getSerie&estacion=",
                            codigoEstacion, "&param=", codigoParam))
  dataOnlineToBind <- data.frame("param_dia_actual"=1:nrow(dsBase))
  dataOnlineToBind$param_dia_actual <- NA # por defecto sin valor
  # POR-HACER: La columna 2 es la del valor en la serie el pH:
  for(k in 1:nrow(dataParamOnline)) {dataOnlineToBind$param_dia_actual[k] <- dataParamOnline[k,colNameParam]}
  #print(dataOnlineToBind)
  #
  # Obtencion del Data Frame de la serie usando manejo de columnas, funciona OK:
  # UTIL! cbind: combiana dos data.frame con el mismo numero de filas.
  dataSerie <- cbind(dsBase[hiperParams], dataOnlineToBind)
  #
  if(input$hcDiaOnlineTipoCarta == "INT_CONF") {
     colnames(dataSerie) <- c("id_t", "lwr", "fit", "upr", "param_dia_actual")
  }
  #
  selected_label <- media_labels %>% filter(variable == hiperSel) %>% select("desc")
  #
  gSerie <- dygraph(dataSerie, main=sprintf("%s (%s)",selected_label, date()),
                    xlab=paste("t por Hipercarta"), ylab=paste("Intervalo para:", selected_label)) %>%
               dyRangeSelector() %>% dyHighlight(highlightSeriesOpts = list(strokeWidth = 2)) %>%
               dyOptions(drawGrid=input$hcDiaOnlineShowgridCheck, drawPoints=TRUE, pointSize=2, pointShape="dot") %>%
               dyLegend(width=700)
  #
  if(input$hcDiaOnlineTipoCarta == "INT_CONF") {
     # UTIL! la funcion sub(..) reemplaza por vacio ("") el resto del string luego del primer espacio de izq. a der.
     # --> Asi se obtiene la primera palabra del string.
     param_name_label <- sub( "\\s.*", "", selected_label)
     #
     gSerie <- gSerie %>% dySeries("param_dia_actual", label=paste("D\u00EDa Actual", param_name_label)) %>%
                          dySeries(c("lwr", "fit", "upr"), label=paste("Hipercarta", param_name_label))
  }
  if(!input$hcDiaOnlineShowgridCheck) {
     gSerie <- gSerie %>% dyCrosshair()
  }
  #
  return(gSerie)
})
#
