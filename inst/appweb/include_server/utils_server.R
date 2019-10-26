# autor -------------------------------------------------------------------
# carlos.perez7@udea.edu.co
# 15/02/2019 17:35:51 p. m.
#
## Cargar las funciones del paquete hipervizr a ser usadas en el BACKEND de la app Shiny-WEB:
#
# Carga de datos base para la hipercarta y el detalle de cada id_t en la respectiva carta de control.
# IMPORTANTE: Cada columna del archivo de excel debe tener un formato de celda tipo "general".
#
hiperCartaData <- read_excel("C:\\Temp\\HIPERCARTAS_Base_144.xlsx")
#
mediasColNames <- c("MEDIA_Condu", "MEDIA_ph", "MEDIA_od", "MEDIA_turb", "MEDIA_pot_redox", "MEDIA_tempera")
#
cartaControlData <- read_excel("C:\\Temp\\CARTAS_CONTROL_Base_144.xlsx")
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
medicionEstacionData <- read_excel("C:\\Temp\\MEDICIONES_ESTACIONES-Mensual-144.xlsx")
#

