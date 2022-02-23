library(shiny)
library(shinydashboard)
library(ggplot2)
library(forcats)
library(tidyverse)

server <- function(input, output) {
  
  output$new_sal_box <- renderInfoBox({
    infoBox(
      paste(input$years,"년", "신입사원 연봉 1위"),
      as.character(subset(data, (year==input$years)&new_sal==max(subset(data, year==input$years)['new_sal'], na.rm=TRUE))[1, 'institution']),
      color = "blue", icon = icon("dollar")
      
    )
  })
  
  output$avg_sal_box <- renderInfoBox({
    infoBox(
      paste(input$years,"년", "평균직원 연봉 1위"),
      as.character(subset(data, (year==input$years)&avg_sal==max(subset(data, year==input$years)['avg_sal'], na.rm=TRUE))[1, 'institution']),
       color = "navy", icon = icon("money")
    )
  })
  
  output$ser_year_box <- renderInfoBox({
    infoBox(
      paste(input$years,"년", "평균근속 연수 1위"),
      as.character(subset(data, (year==input$years)&ser_year==max(subset(data, year==input$years)['ser_year'], na.rm=TRUE))[1, 'institution']),
       color = "purple", icon = icon("heart")
    )
  })
  
  output$rate_box <- renderInfoBox({
    infoBox(
      paste(input$years,"년", "잡플래닛 평점 1위"),
      as.character(subset(data, (year==input$years)&rate==max(subset(data, year==input$years)['rate'], na.rm=TRUE))[1, 'institution']),
       color = "orange", icon = icon("star")
    )
  })

  
  output$plot1 <- renderPlot({
    
    input_year <- input$years
    data <- subset(data, year==input_year)
    selcon <- input$selectgongtype
    
    ggplot(data=subset(data, gongtype %in% c(selcon)), aes(x = avg_sal, y = new_sal)) + 
      geom_point(mapping = aes(color = gongtype), alpha=0.4, position = "jitter") +
      coord_cartesian(xlim = c(25000, 115000), ylim = c(20000, 55000)) +
      guides(color = "none", size = "none") +
      geom_smooth(method=lm , color="cyan", se=FALSE) + 
      theme_minimal() + scale_x_log10()+ scale_y_log10()
  }, res = 96)
  
  output$plot2 <- renderPlot({
    
    input_year <- input$years
    data <- subset(data, year==input_year)
    selcon2 <- input$selectministry
    
    ggplot(data=subset(data, ministry %in% c(selcon2)), aes(x = avg_sal, y = new_sal)) + 
      geom_point(mapping = aes(color = ministry), alpha=0.4, position = "jitter")+
      coord_cartesian(xlim = c(25000, 115000), ylim = c(20000, 55000)) + 
      guides(color = "none") +
      geom_smooth(method=lm , color="cyan", se=FALSE) + theme_minimal()
  }, res = 96)
  
  output$plot3 <- renderPlot({
    input_year <- input$years
    data_new <- subset(data, year==input_year)
    data_new <- arrange(data_new, desc(new_sal))
    
    ggplot(data = head(data_new), 
           mapping = aes(x = institution, y = new_sal)) + 
      geom_bar(stat = "identity") +
      coord_flip()
  }, res = 96)
  
  output$plot4 <- renderPlot({
    input_year <- input$years
    data_new <- subset(data, year==input_year)
    data_new <- arrange(data_new, desc(avg_sal))
    
    ggplot(data = head(data_new), 
           mapping = aes(x = institution, y = avg_sal)) + 
      geom_bar(stat = "identity") +
      coord_flip()
  }, res = 96)
  
  output$plot5 <- renderPlot({
    data_search <- subset(data, institution==input$companysearch)
    ggplot(data = data_search, 
           mapping = aes(x = year, y = avg_sal)) + 
      geom_bar(stat = "identity") + geom_line() + geom_point()
  }, res = 96)

}
