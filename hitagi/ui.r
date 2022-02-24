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
      menuItem("기관별 데이터", icon = icon("cat"), tabName = "page2"),
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
                box(width=12,
                infoBoxOutput("new_sal_box", 2 * 1.5),
                infoBoxOutput("avg_sal_box", 2 * 1.5),
                infoBoxOutput("ser_year_box", 2 * 1.5),
                infoBoxOutput("rate_box", 2 * 1.5)
                )
              ),
              fluidRow(
                box(width=12,
                tabBox(width=6,
                  title = tags$b("평균연봉 & 신입초임"),
                  tabPanel("기관유형별",
                  plotOutput("plot1", height = 300,
                             hover = "plot_hover1"
                             ),
                  textOutput("data1"),
                  checkboxGroupInput(inputId="selectgongtype",
                                     "Select",
                                     choices = levels(data$gongtype),
                                     selected = levels(data$gongtype),
                                     inline = TRUE)),
                  tabPanel("주무부처별",
                           plotOutput("plot2", height = 300,
                              hover = "plot_hover2"),
                           checkboxGroupInput(inputId="selectministry",
                                              "Select",
                                              choices = levels(data$ministry),
                                              selected = levels(data$ministry),
                                              inline = TRUE))
                ),
                tabBox(width=6,
                  title = tags$b("근속연수"),
                  tabPanel("평균연봉 ",
                  plotOutput("plot_rate1", height = 300),
                  checkboxGroupInput(inputId="selectgongtype2",
                                     "Select",
                                     choices = levels(data$gongtype),
                                     selected = levels(data$gongtype),
                                     inline = TRUE)
                ),
                  tabPanel("신입초봉 ",
                           plotOutput("plot_rate2", height = 300),
                           checkboxGroupInput(inputId="selectgongtype3",
                                              "Select",
                                              choices = levels(data$gongtype),
                                              selected = levels(data$gongtype),
                                              inline = TRUE)
                  )
              ))),
              fluidRow(
                box(width=12,
                tabBox(
                  title = tags$b("평균연봉, 신입초봉, 평균근속 분포"), 
                  tabPanel("분포",
                           plotOutput("histo1", height = 300)
                  ),
                  tabPanel("연봉 순",
                  plotOutput("plot3", height = 500)
                  )
                  ),
                box(width=6,
                    title = tags$b("년 평균"), height = 500,
                    dataTableOutput("table1")
                ))
              ),
              
            
      ),
      
      # Second tab content
      tabItem(tabName = "page1",
              h1(tags$b("잡플래닛 별점")),
              box(width=12,title = tags$b("연봉별 평점"), solidHeader = TRUE, status = "primary",
              tabBox(
                title = tags$b("잡플래닛 평점 : 신입사원 초봉"), 
                tabPanel("scatterplot",
                         plotOutput("rateplot1", height = 300)),
                tabPanel("correlation",
                         plotOutput("rateplot4", height = 300)
                )),
              tabBox(
                title = tags$b("잡플래닛 평점 : 평균직원 연봉"),
                tabPanel("scatterplot",
                         plotOutput("rateplot2", height = 300)),
                tabPanel("correlation",
                         plotOutput("rateplot3", height = 300)
                ))),
              box(width=6,
                  title = tags$b("잡플래닛 평점 : 주무부처"), solidHeader = TRUE, status = "primary",
                        plotOutput("rateplot5", height = 500)),
              box(width=6,
                  title = tags$b("잡플래닛 평점 : 기관유형"), solidHeader = TRUE, status = "primary",
                        plotOutput("rateplot6", height = 500),
                  checkboxGroupInput(inputId="selectministry2",
                                     "Select",
                                     choices = levels(data$ministry),
                                     selected = levels(data$ministry),
                                     inline = TRUE))
                  
      ),
      tabItem(tabName = "page2",
              h1(tags$b("기관별 데이터")),
              selectInput(inputId = "companysearch","기관명을 선택해주세요.", 
                          choices = distinct(data, institution)),
              
              box(width = 4,
                  title = "레이더", solidHeader = TRUE, status = "primary",
                  plotOutput("radar1", height = 300)),
              box(width = 4,
                title = "연도별 직원 평균 연봉", solidHeader = TRUE, status = "primary",
                plotOutput("plot5", height = 300)),
              box(width = 4,
                  title = "연도별 신입 사원 연봉", solidHeader = TRUE, status = "primary",
                  plotOutput("plot6", height = 300))
        
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
