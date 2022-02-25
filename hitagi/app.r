library(shiny)
library(rsconnect)

shinyApp(ui = ui, server = server)

rsconnect::deployApp('./app.r')


