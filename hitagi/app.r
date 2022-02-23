library(shiny)
library(rsconnect)

rsconnect::deployApp('./app.R')

shinyApp(ui = ui, server = server)