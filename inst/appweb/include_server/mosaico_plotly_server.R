# autor -------------------------------------------------------------------
# carlos.perez7@udea.edu.co
# 01/02/2019 9:26:08 a. m.
#
output$corParSTATPlot <- renderPlotly({
  iris$obs <- seq_len(nrow(iris))
  iris_pcp <- function(transform = identity) {
    iris[] <- purrr::map_if(iris, is.numeric, transform)
    tidyr::gather(iris, variable, value, -Species, -obs) %>%
      group_by(obs) %>%
      plot_ly(x = ~variable, y = ~value, color = ~Species) %>%
      add_lines(alpha = 0.3)
  }
  subplot(
    iris_pcp(),
    iris_pcp(scale),
    iris_pcp(scales::rescale)
  ) %>% highlight("plotly_selected") # %>% hide_legend()
})
#
output$corParINTERPlot <- renderPlotly({
  # POR DEFECTO PERMITE INTERCAMBIO DE EJES Y SELECCION DE FILTRO MULTIPLE EN LOS EJES:
  # IMPORTANTE: VER EL GRAFICO TIPO: https://plot.ly/r/reference/#sankey
  # https://plot.ly/r/reference/#heatmap -- https://plot.ly/r/reference/#parcoords
  #
  plot_ly(type = 'parcoords',
          line = list(color = 'blue', colorscale = 'Jet', showscale = TRUE, reversescale = TRUE),
     dimensions = list(
       list(multiselect = TRUE, range = c(1,5),
            constraintrange = c(1,2),
            label = 'A', values = c(1,4)),
       list(multiselect = TRUE, range = c(1,5),
            tickvals = c(1.5,3,4.5),
            label = 'B', values = c(3,1.5)),
       list(multiselect = TRUE, range = c(1,5),
            tickvals = c(1,2,4,5),
            label = 'C', values = c(2,4),
            ticktext = c('text 1', 'text 2', 'text 3', 'text 4')),
       list(multiselect = TRUE, range = c(1,5),
            label = 'D', values = c(4,2))
     )
  )
})
##
# reusable function for highlighting a particular city
layer_city <- function(plot, name) {
  plot %>% filter(city == name) %>% add_lines(name = name)
}
# reusable function for plotting overall median & IQR
layer_iqr <- function(plot) {
  plot %>%
    group_by(date) %>%
    summarise(
      q1 = quantile(median, 0.25, na.rm = TRUE),
      m = median(median, na.rm = TRUE),
      q3 = quantile(median, 0.75, na.rm = TRUE)
    ) %>%
    add_lines(y = ~m, name = "median", color = I("black")) %>%
    add_ribbons(ymin = ~q1, ymax = ~q3, name = "IQR", color = I("black"))
}
#
output$capasSTATPlot <- renderPlotly({
  allCities <- txhousing %>%
    group_by(city) %>%
    plot_ly(x = ~date, y = ~median) %>%
    add_lines(alpha = 0.2, name = "Texan Cities", hoverinfo = "none")

  allCities %>%
    add_fun(layer_iqr) %>%
    add_fun(layer_city, "Houston") %>%
    add_fun(layer_city, "San Antonio") %>% rangeslider()
})
#
output$cuadranteSTATPlot <- renderPlotly({
  # ACTUALIZACION DE LA INDFORMACION CON LOS ATRIBUTOS DINAMICOS QUE PROPORCIONA EL "DT"
  rowIdx = input$subplotArrayDT_rows_selected
  if(length(rowIdx) > 0) {
    dataSEL = txhousing[rowIdx, ,drop = FALSE]
  } else {
    dataSEL = txhousing
  }
  #
  p <- ggplot(dataSEL, aes(date, median)) + geom_line(aes(group = city), alpha = 0.2)
  subplot(
    p, ggplotly(p, tooltip = "city"),
    ggplot(txhousing, aes(date, median)) + geom_bin2d(),
    ggplot(txhousing, aes(date, median)) + geom_hex(),
    nrows = 2, shareX = TRUE, shareY = TRUE, titleY = FALSE, titleX = FALSE
  )
})
#
output$subplotArrayDT <- renderDT({
  # customize the length drop-down menu; display 5 rows per page by default
  DT::datatable(txhousing,
      options = list(orderClasses = TRUE, lengthMenu = c(5, 10, 50), pageLength = 5))
})
#
output$predictSTATPlot  <- renderPlotly({
  txhousing %>%
    group_by(city) %>%
    plot_ly(x = ~date, y = ~median) %>%
    add_lines(alpha = 0.2, name = "Texan Cities", hoverinfo = "none") %>%
    add_fun(layer_iqr) %>%
    add_fun(layer_forecast) %>% rangeslider()
})
#
layer_forecast <- function(plot) {
  d <- plotly_data(plot)
  series <- with(d,
                 ts(median, frequency = 12, start = c(2000, 1), end = c(2015, 7))
  )
  fore <- forecast(ets(series), h = 48, level = c(80, 95))
  plot %>%
    add_ribbons(x = time(fore$mean), ymin = fore$lower[, 2],
                ymax = fore$upper[, 2], color = I("gray95"),
                name = "95% confidence", inherit = FALSE) %>%
    add_ribbons(x = time(fore$mean), ymin = fore$lower[, 1],
                ymax = fore$upper[, 1], color = I("gray80"),
                name = "80% confidence", inherit = FALSE) %>%
    add_lines(x = time(fore$mean), y = fore$mean, color = I("blue"),
              name = "prediction")
}
#
