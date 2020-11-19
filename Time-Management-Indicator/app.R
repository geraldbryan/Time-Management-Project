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


# Define UI for application that draws a histogram
ui <-  dashboardPage(
    dashboardHeader(title = "Time Management Indicator",
                    dropdownMenu(type = "messages",
                                 messageItem(
                                     from = "Dashboard Creator",
                                     message = "Welcome to Time Management Indicator", icon("glass-cheers")
                                 ))
        ),
    dashboardSidebar(
        sidebarMenu( id = "mytabs",
            menuItem("Home", tabName="home", icon = icon("home")),
            menuItem("Test", tabName="test", icon = icon("file-alt")),
            menuItem("Statistics", tabName="statistic", icon = icon("bar-chart-o")),
            menuItem("Code Source", tabName="code", icon = icon("code"), 
                     menuSubItem("Clustering", tabName = "cluster"),
                     menuSubItem("Association Rules", tabName = "arules"))
            )
    ),
        
    dashboardBody(tabItems(
        tabItem(tabName = "home", h2("Dashboard tab content")
                ),
        tabItem(tabName = "test", sidebarLayout(
                                            sidebarPanel(textInput("name","Enter Your Name:"),
                                                         radioButtons("gender", "Select Your Gender", choices = c("F","M"), inline = TRUE),
                                                         selectInput("age","Select Your Age:",choices = c("18-20","21-25",">25")),
                                                         radioButtons("X6", "Question X6",choices = c("Strong Disagree","Disagree","Neither","Agree","Strong Agree")),
                                                         radioButtons("X6", "Question X6",choices = c("Strong Disagree","Disagree","Neither","Agree","Strong Agree")),
                                                         radioButtons("X6", "Question X6",choices = c("Strong Disagree","Disagree","Neither","Agree","Strong Agree"))
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
)

# Define server logic required to draw a histogram
server <- function(input, output) {

}
# Run the application 
shinyApp(ui = ui, server = server)
