library(shiny)
library(rsconnect)
library(readxl)

data <- read.csv("./data/gonggiup.csv", na.strings = c("", 0, " ", NA))
data[data == 0] <- NA
data$ministry = as.factor(data$ministry)
data$gongtype = as.factor(data$gongtype)


shinyApp(ui = ui, server = server)

rsconnect::deployApp('./hitagi/')


