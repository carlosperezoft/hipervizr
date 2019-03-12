# autor -------------------------------------------------------------------
# carlos.perez7@udea.edu.co
# 11/03/2019 21:16:08 p. m.
#
# COORDENADAS PARALELAS ---------------------------------------------------
output$iris_pairs <- renderPlot({
 rows <- rownames(iris)

 # example from ?pairs
 pairs(
   iris[rows,-5]
   , main = "Anderson's Iris Data -- 3 species"
   , pch = 21
   , bg = RColorBrewer::brewer.pal(3,'Set1')[unclass(iris[rows,]$Species)]
 )
})

output$paralCoordsPlot <- renderParcoords({
 tryCatch({
   pc <- parcoords(reorderable = TRUE,
     iris[,c(5,1:4)]  # order columns so species first
     , rownames=F
     , brushMode="1d"
     , color = list(
       colorScale = htmlwidgets::JS(sprintf(
         'd3.scale.ordinal().range(%s).domain(%s)'
         ,jsonlite::toJSON(RColorBrewer::brewer.pal(3,'Set1'))
         ,jsonlite::toJSON(as.character(unique(iris$Species)))
       ))
       ,colorBy = "Species"
     )
   )
 },
 error = function(e) {
   print(sprintf("Inner error: %s", e))
 },
 warning = function(e) {
   print(sprintf("Inner warning: %s", e))
 },
 finally = {
   print(sprintf("Inner tryCatch all done, result is %s", "EJECUCION EXITOSA!"))
 })
})
