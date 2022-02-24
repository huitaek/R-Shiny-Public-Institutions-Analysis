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
    
    ggplot(data= data<- subset(data, gongtype %in% c(selcon)), aes(x = avg_sal, y = new_sal, size = ser_year, fill=gongtype)) + 
      geom_point(mapping = aes(shape=21, color="black"), alpha=0.5, position = "jitter")+ scale_shape_identity()  +
      coord_cartesian(xlim = c(25000, 115000), ylim = c(20000, 55000)) +
      guides(color = "none", size = "none") +
      theme_minimal() + scale_size(range = c(0.001, 5))+
      scale_fill_viridis(discrete=TRUE, guide=FALSE, option="A")+
      labs(x = NULL, y = NULL) 
  }, res = 96)
  
  output$plot2 <- renderPlot({
    
    input_year <- input$years
    data <- subset(data, year==input_year)
    selcon2 <- input$selectministry
    
    ggplot(data=subset(data, ministry %in% c(selcon2)), aes(x = avg_sal, y = new_sal, size = ser_year, fill=ministry)) + 
      geom_point(mapping = aes(shape=21, color="black"), alpha=0.5, position = "jitter")+ scale_shape_identity()  +
      coord_cartesian(xlim = c(25000, 115000), ylim = c(20000, 55000)) + 
      guides(color = "none", size = "none") + theme_minimal() + scale_size(range = c(0.001, 5), name="Population (M)")+
      scale_fill_viridis(discrete=TRUE, guide=FALSE, option="A") +
      labs(x = NULL, y = NULL) 
  }, res = 96)
  
  output$plot3 <- renderPlot({
    input_year <- input$years
    data_new <- subset(data, year==input_year)
    data_new <- arrange(data_new, desc(new_sal))
    
    ggplot(data = head(data_new), 
           mapping = aes(x = reorder(institution, -new_sal), y = new_sal)) + 
      geom_bar(stat = "identity")+
      labs(x = NULL, y = NULL) 
  }, res = 96)
  
  output$plot4 <- renderPlot({
    input_year <- input$years
    data_new <- subset(data, year==input_year)
    data_new <- arrange(data_new, desc(avg_sal))
    
    ggplot(data = head(data_new), 
           mapping = aes(x = reorder(institution, -avg_sal), y = avg_sal)) + 
      geom_bar(stat = "identity")+
      labs(x = NULL, y = NULL) 
  }, res = 96)
  
  output$plot6 <- renderPlot({
    input_year <- input$years
    data_search <- subset(data,(year<=input_year)&(institution==input$companysearch))
    ggplot(data = data_search, 
           mapping = aes(x = year, y = new_sal)) + theme_void() +
      geom_bar(stat = "identity", aes(color=new_sal, fill=new_sal)) + geom_line() + geom_point()+
      guides(color = "none", size = "none") + theme(legend.position = "none")+
      labs(x = NULL, y = NULL) 
  }, res = 96) 
  
  output$plot5 <- renderPlot({
    input_year <- input$years
    data_search <- subset(data, (year<=input_year)&(institution==input$companysearch))
    ggplot(data = data_search, 
           mapping = aes(x = year, y = avg_sal)) + theme_void() +
      geom_bar(stat = "identity", aes(color=avg_sal, fill=avg_sal)) + geom_line() + geom_point()+
      guides(color = "none", size = "none") + theme(legend.position = "none")+
      labs(x = NULL, y = NULL) 
  }, res = 96)
  
  output$plot_rate1 <- renderPlot({
    
    input_year <- input$years
    data <- subset(data, year==input_year)
    selcon <- input$selectgongtype2
    
    ggplot(data=subset(data, gongtype %in% c(selcon)), aes(x = ser_year/12, y = avg_sal, fill=gongtype, size=rate)) + 
      geom_point(mapping = aes(shape=21, color="black"), alpha=0.4, position = "jitter") + scale_shape_identity()  +
      coord_cartesian(xlim = c(0, 25), ylim = c(20000, 115000)) +
      guides(color = "none", size = "none") + theme_minimal() + scale_size(range = c(0.001, 5), name="Population (M)")+
      scale_fill_viridis(discrete=TRUE, guide=FALSE, option="D")+
      labs(x = NULL, y = NULL) 
  }, res = 96)
  
  output$plot_rate2 <- renderPlot({
    
    input_year <- input$years
    data <- subset(data, year==input_year)
    selcon <- input$selectgongtype3
    
    ggplot(data=subset(data, gongtype %in% c(selcon)), aes(x = ser_year/12, y = new_sal, fill=gongtype, size=rate)) + 
      geom_point(mapping = aes(shape=21, color="black"), alpha=0.4, position = "jitter") + scale_shape_identity()  +
      coord_cartesian(xlim = c(0, 25), ylim = c(20000, 55000)) +
      guides(color = "none", size = "none") + theme_minimal() + scale_size(range = c(0.001, 5), name="Population (M)")+
      scale_fill_viridis(discrete=TRUE, guide=FALSE, option="D")+
      labs(x = NULL, y = NULL) 
  }, res = 96)
  
  
  output$rateplot1 <- renderPlot({
    
    input_year <- 2021
    data <- subset(data, year==input_year)
    
    ggplot(data=data, aes(x = rate, y = new_sal, fill=gongtype)) + 
      geom_point(mapping = aes(shape=21, color="black"), alpha=0.4, position = "jitter") + scale_shape_identity()  +
      coord_cartesian(xlim = c(1.5, 4.5), ylim = c(20000, 55000)) +
      guides(color = "none", size = "none") + theme_minimal() + scale_size(range = c(0.001, 5), name="Population (M)")+
      scale_fill_viridis(discrete=TRUE, guide=FALSE, option="D")+
      labs(x = NULL, y = NULL)
  }, res = 96)
  
  output$rateplot2 <- renderPlot({
    
    input_year <- 2021
    data <- subset(data, year==input_year)
    
    ggplot(data=data, aes(x = rate, y = avg_sal, fill=gongtype)) + 
      geom_point(mapping = aes(shape=21, color="black"), alpha=0.4, position = "jitter") + scale_shape_identity()  +
      coord_cartesian(xlim = c(1.5, 4.5), ylim = c(20000, 115000)) +
      guides(color = "none", size = "none") + theme_minimal() + scale_size(range = c(0.001, 5), name="Population (M)")+
      scale_fill_viridis(discrete=TRUE, guide=FALSE, option="D")+
      labs(x = NULL, y = NULL)
  }, res = 96)
  
  output$rateplot3 <- renderPlot({
    
    input_year <- 2021
    data <- subset(data, year==input_year)
    
    ggplot(data, aes(x=rate, y=avg_sal)) + 
      geom_point()+
      stat_smooth(method = 'lm', col='red')+
      geom_text(y=105000, x=1.5, label="R=0.6502526 ")+
      geom_text(y=90000, x=1.5, label="p-value < 2.2e-16") + theme_minimal() +
      coord_cartesian(xlim = c(1.5, 4.5), ylim = c(20000, 115000))+
      labs(x = NULL, y = NULL)
  }, res = 96)
  
  output$rateplot4 <- renderPlot({
    
    input_year <- 2021
    data <- subset(data, year==input_year)
    
    ggplot(data, aes(x=rate, y=new_sal)) + 
      geom_point()+
      stat_smooth(method = 'lm', col='red')+
      geom_text(y=55000, x=1.5, label="R=0.4855826")+
      geom_text(y=50000, x=1.5, label="p-value < 2.2e-16") + theme_minimal()+
      coord_cartesian(xlim = c(1.5, 4.5), ylim = c(20000, 55000))+
      labs(x = NULL, y = NULL)
  }, res = 96)
  
  output$rateplot5 <- renderPlot({
    
    input_year <- 2021
    dataplot5 <- subset(data, year==input_year)
    
    ggplot(dataplot5, aes(x=reorder(gongtype, -rate), y=rate)) + 
      geom_jitter(aes(color=ministry, size=ser_year/12), alpha=0.6) + 
      scale_size(range = c(0.00001, 5))+
      guides(color = "none", size = "none") +
      labs(x = NULL, y = NULL) +
      scale_fill_viridis(discrete=TRUE, guide=FALSE, option="D")+ scale_shape_identity()
  }, res = 96)
  
  
  output$rateplot6 <- renderPlot({
    
    input_year <- 2021
    selcon4 <- input$selectministry2
    dataplottemp <- subset(data, year==input_year)
    dataplot6 <- subset(dataplottemp, ministry %in% c(selcon4))
    
    ggplot(dataplot6, aes(x=reorder(ministry, -rate), y=rate)) + 
      geom_jitter(aes(color=ministry)) +
      coord_cartesian(xlim = c(1.5, 4.5)) +
      coord_flip() +
      guides(color = "none", size = "none") +
      labs(x = NULL, y = NULL) 
  }, res = 96)
  
  output$histo1 <- renderPlot({
    input_year <- input$years
    data <- subset(data, year==input_year)
  ggplot(data) + 
    geom_histogram(aes(x=new_sal), col='white',fill='red3', alpha=0.3, bin = 70)+
    geom_histogram(aes(x=avg_sal), col='white',fill='blue3', alpha=0.3, bin= 70)+
    geom_histogram(aes(x=ser_year*100), col='white',fill='forestgreen', alpha=0.3, bin= 70)+
    coord_cartesian(xlim = c(0, 115000), ylim = c(0, 90))+ theme_minimal()+
    labs(x = NULL, y = NULL) 
  })
  
  output$radar1 <- renderPlot({
    input_year <- input$years
    data1 <- subset(data, (year==input_year)&(institution==input$companysearch))
    radardata <- data1[c("new_sal", "avg_sal", "ser_year", "rate")]
    colnames(radardata) <- c("신입연봉", "평균연봉", "평균근속", "평균별점")
    
    radardata$신입연봉 <- radardata$신입연봉/5000
    radardata$평균연봉 <- radardata$평균연봉/10000
    radardata$평균근속 <- radardata$평균근속/12
    radardata$평균별점 <- radardata$평균별점*2
    radardata <- rbind(rep(20,10) , rep(0,10) , radardata)
    radarchart(radardata,
               pcol=rgb(0.2,0.5,0.5,0.9) , pfcol=rgb(0.2,0.5,0.5,0.5) , plwd=4)
  })

  output$table1 <- renderDataTable({
  datanew <- subset(data, year==input$years)
  datanew
  }, options = list(aLengthMenu = c(5),
                    iDisplayLength = 5))
}

