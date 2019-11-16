# autor -------------------------------------------------------------------
# carlos.perez7@udea.edu.co
# 15/02/2019 17:35:51 p. m.
#
## Cargar las funciones del paquete hipervizr a ser usadas en el BACKEND de la app Shiny-WEB:
#
# Carga de datos base para la hipercarta y el detalle de cada id_t en la respectiva carta de control.
# IMPORTANTE: Cada columna del archivo de excel debe tener un formato de celda tipo "general".
#
# Ruta base para los archivos de datos de la app HIPERVIZ:
hiperviz_data_path <- "C:\\Temp\\"
#
hiperCartaData <- read_excel(paste0(hiperviz_data_path,"HIPERCARTAS_JUL-DIC-2018_144.xlsx"))
#
mediasColNames <- c("MEDIA_Condu", "MEDIA_ph", "MEDIA_od", "MEDIA_turb", "MEDIA_pot_redox", "MEDIA_tempera")
#
cartaControlData <- read_excel(paste0(hiperviz_data_path,"CARTAS_CONTROL_JUL-DIC-2018_144.xlsx"))
#
media_labels <- data.frame(
  variable = c("id_t", "MEDIA_Condu", "MEDIA_ph", "MEDIA_od", "MEDIA_turb", "MEDIA_pot_redox", "MEDIA_tempera"),
  desc = c(
      "t-sub-j",
      "Conductividad el\u00E9ctrica (\u03BCS/cm)",
      "pH (U de pH)",
      "Ox\u00EDgeno disuelto (mg/l)",
      "Turbiedad (NTU)",
      "Redox (mV)",
      "Temperatura (\u00BAC)"
  ),
  stringsAsFactors=FALSE
)
#
medicionEstacionData <- read_excel(paste0(hiperviz_data_path,"MEDICIONES_ESTACIONES-Mensual-144.xlsx"))
hcAnconSurEstacionData <- read_excel(paste0(hiperviz_data_path,"HIPERCARTA-ANCON-SUR-27022019.xlsx"))
hcSanMiguelEstacionData <- read_excel(paste0(hiperviz_data_path,"HIPERCARTA-SAN-MIGUEL-27022019.xlsx"))
#
