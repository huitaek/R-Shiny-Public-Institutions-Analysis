library(shiny)
library(shinydashboard)
library(tidyverse)

ui <- dashboardPage(skin = "purple",
                    
  dashboardHeader(
    title=tags$b("공공기관 데이터 분석")
    ),
  
  dashboardSidebar(
    sidebarMenu(
      menuItem("대시보드", tabName = "dashboard", icon = icon("dashboard")),
      menuItem("잡플래닛 별점", icon = icon("cat"), tabName = "page1"),
      menuItem("페이지2", icon = icon("cat"), tabName = "page2"),
      menuItem("페이지3", icon = icon("cat"), tabName = "page3"),
      menuItem("페이지4", icon = icon("cat"), tabName = "page4"),
      menuItem(                  
        sliderInput("years",              
                    "Years:",             
                    min = 2016,           
                    max = 2021,            
                    value= 2016))
    )
  ),
  
  dashboardBody(
    tabItems(
      tabItem(tabName = "dashboard",
              fluidRow(
                infoBoxOutput("new_sal_box", 2 * 1.5),
                infoBoxOutput("avg_sal_box", 2 * 1.5),
                infoBoxOutput("ser_year_box", 2 * 1.5),
                infoBoxOutput("rate_box", 2 * 1.5)
              ),
              fluidRow(
                tabBox(
                  title = tags$b("평균연봉 & 신입초임"),
                  tabPanel("기관유형별",
                  plotOutput("plot1", height = 200,
                             hover = "plot_hover1"
                             ),
                  textOutput("data1"),
                  checkboxGroupInput(inputId="selectgongtype",
                                     "Select",
                                     choices = levels(data$gongtype),
                                     selected = levels(data$gongtype),
                                     inline = TRUE)),
                  tabPanel("주무부처별",
                           plotOutput("plot2", height = 200,
                              hover = "plot_hover2"),
                           checkboxGroupInput(inputId="selectministry",
                                              "Select",
                                              choices = levels(data$ministry),
                                              selected = levels(data$ministry),
                                              inline = TRUE))
                ),
                tabBox(
                  title = "근속연수",
                  tabPanel("평균연봉 ",
                  plotOutput("plot_rate1", height = 200),
                  checkboxGroupInput(inputId="selectgongtype2",
                                     "Select",
                                     choices = levels(data$gongtype),
                                     selected = levels(data$gongtype),
                                     inline = TRUE)
                ),
                tabPanel("신입초봉 ",
                         plotOutput("plot_rate2", height = 200),
                         checkboxGroupInput(inputId="selectgongtype3",
                                            "Select",
                                            choices = levels(data$gongtype),
                                            selected = levels(data$gongtype),
                                            inline = TRUE)
                )
              )),
              fluidRow(
                tabBox(
                  title = "Title 1", 
                  tabPanel("별점별",
                  plotOutput("plot3", height = 200)
                  ),
                  tabPanel("뉴뉴",
                  plotOutput("histo1", height = 200)
                )),
                box(
                  title = "Title 1", solidHeader = TRUE, status = "warning",
                  selectInput(inputId = "companysearch","Label123123", 
                              choices = distinct(data, institution)), 
                  plotOutput("plot5", height = 300)
                )
              )
            
      ),
      
      # Second tab content
      tabItem(tabName = "page1",
              h1(tags$b("잡플래닛 별점")),
              tabBox(
                title = "Title 1", 
                tabPanel("Plot1",
                         plotOutput("rateplot1", height = 300)
                ),
                tabPanel("Plot2",
                         plotOutput("rateplot2", height = 300)
                )),
              tabBox(
                title = "Title 2",
                tabPanel("Plot1",
                         plotOutput("rateplot3", height = 300)
                ),
                tabPanel("Plot2",
                         plotOutput("rateplot4", height = 300)
                ))
      ),
      tabItem(tabName = "page2",
              h2("page2")
      ),
      tabItem(tabName = "page3",
              h2("page3")
      ),
      tabItem(tabName = "page4",
              h2("page4")
      
      )
    )
  )
)
