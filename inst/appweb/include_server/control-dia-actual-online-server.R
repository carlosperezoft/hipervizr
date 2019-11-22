# autor -------------------------------------------------------------------
# carlos.perez7@udea.edu.co
# carlos.perezoft@gmail.com
# 16/11/2019 11:32:08 a. m.
#
# Se define un timer para invalidar un contexto cada 10 minutos, lo
# cual implica que la funcion que lo contenga se re-ejecute:
autoInvalidate <- reactiveTimer(10*60000)
#
# INICIO SERIES DE HIPERCARTA --< DETALLE CARTA DE CONTROL:
#
output$hcDiaOnlinePlot <- renderDygraph({
  # Define la re-ejecucion de la funcion. Esto con le fin de presentar cada
  # 10 minutos el grafico actual.
  autoInvalidate()
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
     "MEDIA_tempera" = "Temperatura [<grados>C]"
  )
  #
  # Se procede a realizar la creacion de un data.frame que contenga las 144
  # filas de la hipercarta base, pero en las filas donde no hayan datos
  # en la bitacora del mes, se deja el valor NA. Lo cual permite
  # que la serie en dyGraphs se presente por segmentos.
  #
  # print(paste0("https://redrio.metropol.gov.co/online2/RealTime?accion=getSerie&estacion=",
  #                           codigoEstacion, "&param=", codigoParam))
  #
  # Se usar el bloque TRY-CATCH ya que en tiempo de ejecucion puede fallar el acceso al servicio:
  tryCatch({
     # IMPORTANTE: Se crea un data.frame desde el JSON, tener en cuenta que cada columna queda tipo "character"
     dataParamOnline <- jsonlite::fromJSON(
                             paste0("https://redrio.metropol.gov.co/online2/RealTime?accion=getSerie&estacion=",
                                    codigoEstacion, "&param=", codigoParam))
     },
     # UTIL-> stop: detiene la ejecucion de la funcion y presenta el mensaje de error indicado.
     error = function(e) {
        stop(sprintf("Falla al tener acceso al servicio online de RED RIO [ERROR_INFO]: %s", e))
     },
     warning = function(e) {
        stop(sprintf("Validar uso del servicio online de RED RIO [WARNING_INFO]: %s", e))
     }
  )
  #
  shiny::validate(# Este check valida la condicion de forma "afirmativa"..
     shiny::need(!is.null(dataParamOnline) && !is.null(ncol(dataParamOnline)) && (ncol(dataParamOnline) == 3),
     "No se tienen datos disponibles para la lectura ONLINE del servicio de RED RIO (para los filtros seleccionados).")
  )
  #
  dataOnlineToBind <- data.frame("param_dia_actual"=1:nrow(dsBase), stringsAsFactors = FALSE)
  dataOnlineToBind$param_dia_actual <- NA # por defecto sin valor
  # POR-HACER: La columna "colNameParam" es la del valor en la serie. Tener en cuenta que en caso de no haber
  # medicion en una hora dada, no se envia la fila respectiva. Para lo cual se debe usar el t-j como indice de fila.
  # ANTES: Se asumia que el indice k siempre iba de 1 a 144 --> dataOnlineToBind$param_dia_actual[k] <- dataParamOnline[k,colNameParam]
  # AHORA: Se tiene la col: "Tj" la cual indica el indice del dato, pues es posible que no haya continunidad de 1 a 144 en las medidas
  #        de los 10 minutos.
  for(k in 1:nrow(dataParamOnline)) {
     # IMPORTANTE: se usa as.numeric(..) en la lectura de las columnas de "dataParamOnline"
     # ya que los datos de las serie para "dyGraph" deben ser numeric para que funcione bien.
     dataOnlineToBind$param_dia_actual[as.numeric(dataParamOnline[k,"Tj"])] <- as.numeric(dataParamOnline[k,colNameParam])
  }
  #
  # Obtencion del Data Frame de la serie usando manejo de columnas, funciona OK:
  # UTIL! cbind: combina dos data.frame con el mismo numero de filas.
  # IMPORTANTE: Las columnas de los data.frame a presentar en el "dyGraph" deben ser tipo "numeric".
  dataSerie <- cbind(dsBase[hiperParams], dataOnlineToBind)
  #
  if(input$hcDiaOnlineTipoCarta == "INT_CONF") {
     # id_t: Debe usarse ya que el "dyGraph" la toma como ID de cada fila a graficar, y cada columna se toma como una serie:
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
     # IMPORTANTE: dyGraph permirte una serie de un elemento (1-col) o intervalo (3-cols).
     # Aquí se configuran dos dySeries excelentes:
     # a. La serie del param_dia_actual en interv. de conf. de la hipercarta (3-cols). Inicialmente fue solo: param_dia_actual
     # b. La serie de la hipercarta base (3-cols). Con las dos series se ve un contraste muy bueno.
     gSerie <- gSerie %>% dySeries(c("lwr","param_dia_actual", "upr"), label=paste("D\u00EDa Actual", param_name_label)) %>%
                          dySeries(c("lwr", "fit", "upr"), label=paste("Hipercarta", param_name_label))
  }
  if(!input$hcDiaOnlineShowgridCheck) {
     gSerie <- gSerie %>% dyCrosshair()
  }
  #
  return(gSerie)
})
#
