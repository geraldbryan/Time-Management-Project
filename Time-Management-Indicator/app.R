library(shiny)
library(dplyr)
library(rcompanion)
library(tidyverse)
library(GGally)
library(clustMixType)
library(arules)
library(arulesViz)
library(plotly)
library(abind)
library(timeDate)
library(rvest)
library(shinydashboard)
library(shinyjs)
library(shinydashboardPlus)
library(shinyWidgets)

# Define UI for application that draws a histogram
ui <- tagList(dashboardPage(
    dashboardHeader(title = "Time Management Indicator",
                    dropdownMenu(type = "messages",
                                 messageItem(
                                     from = "Dashboard Creator",
                                     message = "Welcome to Time Management Indicator", icon("glass-cheers")
                                 ))
        ),
    dashboardSidebar( collapsed = TRUE,
        sidebarMenu( id = "mytabs",
            menuItem("Home", tabName="home", icon = icon("home")),
            menuItem("Test", tabName="test", icon = icon("file-alt")),
            menuItem("Statistics", tabName="statistic", icon = icon("bar-chart-o")),
            menuItem("Code Source", tabName="code", icon = icon("code"), 
                     menuSubItem("Clustering", tabName = "cluster"),
                     menuSubItem("Association Rules", tabName = "arules"))
            )
    ),
        
    dashboardBody(useShinyjs(),tabItems(
        tabItem(tabName = "home", 
                div(style="text-align: center;",h1("WELCOME")),
                br(),
                br(),
                br(),
                br(),
                br(),
                tags$head(
                    tags$style(".selectize-input { font-size: 32px}",HTML("
                  .btn {
                    display:block;
                    border-radius: 50%;
                    height: 125px;
                    width: 125px;
                    border: 1px solid red;}
                    "))
                ),div(style="text-align: center;",useShinyalert(),
                div(style="display:inline-block;width:27%;text-align: center;",actionButton("tes","Test",icon = icon("file-alt"))),
                div(style="display:inline-block;width:27%;text-align: center;",actionButton("stat","Statistics",icon = icon("bar-chart-o"))),
                div(style="display:inline-block;width:27%;text-align: center;",actionButton("kode","Code Source",icon = icon("code"))))
                ),
        tabItem(tabName = "test", sidebarLayout(
                                            sidebarPanel(textInput("name","Enter Your Name:"),
                                                         radioButtons("gender", "Select Your Gender", choices = c("F","M"), inline = TRUE),
                                                         sliderTextInput("age","Select Your Age:",choices = c("18-20","21-25",">25"),grid = TRUE),
                                                         sliderTextInput("X6", "1. You often feel that your life is aimless, with no definite purpose",choices = c("Strong Disagree","Disagree","Neither","Agree","Strong Agree"),selected = "Neither"), 
                                                         sliderTextInput("X7", "2. You never have trouble organizing the things you have to do",choices = c("Strong Disagree","Disagree","Neither","Agree","Strong Agree"),selected = "Neither"),
                                                         sliderTextInput("X8", "3. Once you've started an activity, you persist at it until you've completed it",choices = c("Strong Disagree","Disagree","Neither","Agree","Strong Agree"),selected = "Neither"),
                                                         sliderTextInput("X9", "4. Sometimes you feel that the things you have to do during the day just don't seem to matter",choices = c("Strong Disagree","Disagree","Neither","Agree","Strong Agree"),selected = "Neither"),
                                                         sliderTextInput("X10", "5. You will plan your activities from day to day",choices = c("Strong Disagree","Disagree","Neither","Agree","Strong Agree"),selected = "Neither"),
                                                         sliderTextInput("X11", "6. You tend to leave things to the last minute",choices = c("Strong Disagree","Disagree","Neither","Agree","Strong Agree"),selected = "Neither"),
                                                         sliderTextInput("X12", "7. You tend to change rather aimlessly from one activity to another during the day",choices = c("Strong Disagree","Disagree","Neither","Agree","Strong Agree"),selected = "Neither"),
                                                         sliderTextInput("X13", "8. You give up the things that you planning to do just because your friend says no",choices = c("Strong Disagree","Disagree","Neither","Agree","Strong Agree"),selected = "Neither"),
                                                         sliderTextInput("X14", "9. You think you do enough with your time",choices = c("Strong Disagree","Disagree","Neither","Agree","Strong Agree"),selected = "Neither"),
                                                         sliderTextInput("X15", "10. You are easy to get bored with your day-today activities",choices = c("Strong Disagree","Disagree","Neither","Agree","Strong Agree"),selected = "Neither"),
                                                         sliderTextInput("X16", "11. The important interests/activities in your life tend to change frequently",choices = c("Strong Disagree","Disagree","Neither","Agree","Strong Agree"),selected = "Neither"),
                                                         sliderTextInput("X17", "12. You know how much time you spend on each of the homework I do",choices = c("Strong Disagree","Disagree","Neither","Agree","Strong Agree"),selected = "Neither")
                                                         
                                            ),
                                            mainPanel(tabsetPanel( 
                                                    tabPanel("Result"),
                                                    tabPanel("Recommendation")
                                                )))),
        
        tabItem(tabName = "statistic",tabsetPanel(
                                            tabPanel("Data"),
                                            tabPanel("Association Rules"))),
        
        tabItem(tabName = "cluster", h2("Dashboard")
                ),
        
        tabItem(tabName = "arules", h2("Dashboard tab")
                )
        )
    )
),
tags$footer("My footer", align = "center", style = "
              bottom:0;
              width:100%;
              height:50px;   /* Height of the footer */
              color: white;
              padding: 10px;
              background-color: black;
              z-index: 1000;")

)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
    #Collapsed sidebar but icon shown
    runjs({'
        var el2 = document.querySelector(".skin-blue");
        el2.className = "skin-blue sidebar-mini";
        var clicker = document.querySelector(".sidebar-toggle");
        clicker.id = "switchState";
    '})
    
    onclick('switchState', runjs({'
        var title = document.querySelector(".logo")
        if (title.style.visibility == "hidden") {
          title.style.visibility = "visible";
        } else {
          title.style.visibility = "hidden";
        }
  '}))

    observeEvent(input$tes, {shinyalert("menu 1 blablablablabla")})
    
    observeEvent(input$stat, {shinyalert("menu 2 blablablablablabla")})
    
    observeEvent(input$kode, {shinyalert("menu 3 blablablabla")})
}

# Run the application 
shinyApp(ui = ui, server = server)
