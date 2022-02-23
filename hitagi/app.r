library(shiny)
library(rsconnect)

rsconnect::deployApp('./hitagi/')

shinyApp(ui = ui, server = server)
