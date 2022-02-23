library(shiny)
library(shinydashboard)
library(ggplot2)
library(forcats)
library(tidyverse)
library(hrbrthemes)
library(viridis)

server <- function(input, output) {
  
  output$new_sal_box <- renderInfoBox({
    infoBox(
      paste(input$years,"년", "신입사원 연봉 1위"),
      as.character(subset(data, (year==input$years)&new_sal==max(subset(data, year==input$years)['new_sal'], na.rm=TRUE))[1, 'institution']),
      color = "blue", icon = icon("dollar"), fill = TRUE
      
    )
  })
  
  output$avg_sal_box <- renderInfoBox({
    infoBox(
      paste(input$years,"년", "평균직원 연봉 1위"),
      as.character(subset(data, (year==input$years)&avg_sal==max(subset(data, year==input$years)['avg_sal'], na.rm=TRUE))[1, 'institution']),
       color = "navy", icon = icon("money"), fill = TRUE
    )
  })
  
  output$ser_year_box <- renderInfoBox({
    infoBox(
      paste(input$years,"년", "평균근속 연수 1위"),
      as.character(subset(data, (year==input$years)&ser_year==max(subset(data, year==input$years)['ser_year'], na.rm=TRUE))[1, 'institution']),
       color = "purple", icon = icon("heart"), fill = TRUE
    )
  })
  
  output$rate_box <- renderInfoBox({
    infoBox(
      paste(input$years,"년", "잡플래닛 평점 1위"),
      as.character(subset(data, (year==input$years)&rate==max(subset(data, year==input$years)['rate'], na.rm=TRUE))[1, 'institution']),
       color = "orange", icon = icon("star"), fill = TRUE
    )
  })

    
  output$plot1 <- renderPlot({
    
    input_year <- input$years
    data <- subset(data, year==input_year)
    selcon <- input$selectgongtype
    
    ggplot(data=subset(data, gongtype %in% c(selcon)), aes(x = avg_sal, y = new_sal, size = ser_year, fill=gongtype)) + 
      geom_point(mapping = aes(shape=21, color="black"), alpha=0.5, position = "jitter")+ scale_shape_identity()  +
      coord_cartesian(xlim = c(25000, 115000), ylim = c(20000, 55000)) +
      guides(color = "none", size = "none") +
      theme_minimal() + scale_size(range = c(0.001, 5), name="Population (M)")+
      scale_fill_viridis(discrete=TRUE, guide=FALSE, option="A")
  }, res = 96)
  
  output$plot2 <- renderPlot({
    
    input_year <- input$years
    data <- subset(data, year==input_year)
    selcon2 <- input$selectministry
    
    ggplot(data=subset(data, ministry %in% c(selcon2)), aes(x = avg_sal, y = new_sal, size = ser_year, fill=ministry)) + 
      geom_point(mapping = aes(shape=21, color="black"), alpha=0.5, position = "jitter")+ scale_shape_identity()  +
      coord_cartesian(xlim = c(25000, 115000), ylim = c(20000, 55000)) + 
      guides(color = "none", size = "none") + theme_minimal() + scale_size(range = c(0.001, 5), name="Population (M)")+
      scale_fill_viridis(discrete=TRUE, guide=FALSE, option="A")
  }, res = 96)
  
  output$plot3 <- renderPlot({
    input_year <- input$years
    data_new <- subset(data, year==input_year)
    data_new <- arrange(data_new, desc(new_sal))
    
    ggplot(data = head(data_new), 
           mapping = aes(x = reorder(institution, -new_sal), y = new_sal)) + 
      geom_bar(stat = "identity")
  }, res = 96)
  
  output$plot4 <- renderPlot({
    input_year <- input$years
    data_new <- subset(data, year==input_year)
    data_new <- arrange(data_new, desc(avg_sal))
    
    ggplot(data = head(data_new), 
           mapping = aes(x = reorder(institution, -avg_sal), y = avg_sal)) + 
      geom_bar(stat = "identity")
  }, res = 96)
  
  output$plot5 <- renderPlot({
    data_search <- subset(data, institution==input$companysearch)
    ggplot(data = data_search, 
           mapping = aes(x = year, y = avg_sal)) + 
      geom_bar(stat = "identity") + geom_line() + geom_point()
  }, res = 96)
  
  output$plot_rate1 <- renderPlot({
    
    input_year <- input$years
    data <- subset(data, year==input_year)
    selcon <- input$selectgongtype
    
    ggplot(data=subset(data, gongtype %in% c(selcon)), aes(x = ser_year/12, y = avg_sal, fill=gongtype, size=rate)) + 
      geom_point(mapping = aes(shape=21, color="black"), alpha=0.4, position = "jitter") + scale_shape_identity()  +
      coord_cartesian(xlim = c(0, 25), ylim = c(20000, 115000)) +
      guides(color = "none", size = "none") + theme_minimal() + scale_size(range = c(0.001, 5), name="Population (M)")+
      scale_fill_viridis(discrete=TRUE, guide=FALSE, option="D")
  }, res = 96)
  
  output$plot_rate2 <- renderPlot({
    
    input_year <- input$years
    data <- subset(data, year==input_year)
    selcon <- input$selectgongtype
    
    ggplot(data=subset(data, gongtype %in% c(selcon)), aes(x = ser_year/12, y = new_sal, fill=gongtype, size=rate)) + 
      geom_point(mapping = aes(shape=21, color="black"), alpha=0.4, position = "jitter") + scale_shape_identity()  +
      coord_cartesian(xlim = c(0, 25), ylim = c(20000, 55000)) +
      guides(color = "none", size = "none") + theme_minimal() + scale_size(range = c(0.001, 5), name="Population (M)")+
      scale_fill_viridis(discrete=TRUE, guide=FALSE, option="D")
  }, res = 96)
}
