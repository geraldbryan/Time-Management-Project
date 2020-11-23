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
library(shinyalert)
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
library(visNetwork)

# Define UI for application that draws a histogram
ui <- dashboardPagePlus(
  dashboardHeader(title = "Time Management Indicator",
                  dropdownMenu(type = "messages",
                               messageItem(
                                 from = "Dashboard Creator",
                                 message = "Welcome to Time Management Indicator", icon("glass-cheers")
                               )),
                  tags$li(actionLink("openModal", label = "", icon = icon("info")),
                          class = "dropdown")
                  
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
            div(style="text-align: center;font-size: 65px;","Time Management Indicator"),
            br(),
            br(),
            div(style="text-align: center;",h3("Take a look of what we have provided for you")),
            br(),
            div(tags$head(
              tags$style(".selectize-input { font-size: 32px}",HTML("
                  .btn {
                    display:block;
                    color: Green;
                    border-radius: 50%;
                    height: 125px;
                    width: 125px;
                    border: 3px solid black;}
                    "))
            ),
            useShinyalert(), style= "display: flex; justify-content: center;", column(10, align="center", offset=1,
                                                                                      div(style="display:inline-block;width:27%;text-align: center;",actionButton("tes","Test",icon = icon("file-alt"))),
                                                                                      div(style="display:inline-block;width:27%;text-align: center;",actionButton("stat","Statistics",icon = icon("bar-chart-o"))),
                                                                                      div(style="display:inline-block;width:27%;text-align: center;",actionButton("kode","Code Source",icon = icon("code")))))
    ),
    tabItem(tabName = "test", sidebarLayout(
      sidebarPanel(textInput("name","Enter Your Name:"),
                   radioButtons("gender", "Select Your Gender", choices = c("F","M"), inline = TRUE),
                   sliderTextInput("age","Select Your Age:",choices = c("18-20","21-25",">25"), grid = TRUE),
                   useShinyalert(),  # Set up shinyalert
                   actionButton("ques1", "Question 1"),
                   br(),
                   actionButton("ques2", "Question 2"),
                   br(),
                   actionButton("ques3", "Question 3"),
      ),
      mainPanel(tabsetPanel( 
        tabPanel("Result",br(),
                 tabBox( tabPanel("",plotOutput("ori_clust")),
                         title = "Original Clustering Plot",
                         height = "450px", width = 12,side = "right"),
                 #kasih text apa gitu
                 tabBox( #Input ori + new data clustering plot
                   title = "Time Management Test Result",
                   height = "300px", width = 12,side = "right")),
        tabPanel("Recommendation", br(),
                 tabBox( div(style = 'overflow-y:scroll;height:300px;width=12',
                             tableOutput('time_tips'),
                             title = "Time Management Recommendation",
                             height = "300px", width = 6,side = "right")),
                 fluidRow(tabBox(div(style = 'overflow-y:scroll;height:300px;width=12',h6("X6 =You often feel that your life is aimless, with no definite purpose", br(),br(),
                                                                                          "X7 = You never have trouble organizing the things you have to do", br(),br(),
                                                                                          "X8 = Once you've started an activity, you persist at it until you've completed it", br(),br(),
                                                                                          "X9 = Sometimes you feel that the things you have to do during the day just don't seem to matter", br(),br(),
                                                                                          "X10 = You will plan your activities from day to day", br(),br(),
                                                                                          "X11 = You tend to leave things to the last minute", br(),br(),
                                                                                          "X12 = You tend to change rather aimlessly from one activity to another during the day", br(),br(),
                                                                                          "X13 = You give up the things that you planning to do just because your friend says no", br(),br(),
                                                                                          "X14 = You think you do enough with your time", br(),br(),
                                                                                          "X15 = You are easy to get bored with your day-today activities", br(),br(),
                                                                                          "X16 = The important interests/activities in your life tend to change frequently", br(),br(),
                                                                                          "X17 = You know how much time you spend on each of the homework I do"),
                                     title = "Question List",
                                     height = "300px", width = 6,side = "right"))),
                 tabBox( div(style = 'overflow-x:scroll;',
                             tableOutput('asso_good')),
                         title = "Good Time Management Factors",
                         height = "300px", width = 6,side = "right"),
                 tabBox( div(style = 'overflow-x:scroll;',
                             tableOutput('asso_bad')),
                         title = "Bad Time Management Factors",
                         height = "300px", width = 6,side = "right"),
        )
      )))),
    
    tabItem(tabName = "statistic",tabsetPanel(
      tabPanel("Data", br(),
               div(style = 'overflow-x:scroll;height:323px;width=12',
                   tableOutput("head_data")), br(),
               splitLayout(plotOutput("gender_plot"),
                           plotOutput("score_gender")), br(),
               plotOutput("dist_plot")),
      tabPanel("Clustering", br(),
               plotOutput("elbow_plot"), br(),
               plotlyOutput("boxplot_cluster")),
      navbarMenu("Association Rules",
                 tabPanel("Good Time Management",sidebarLayout(
                   sidebarPanel(h2("penjelasan ttg support dkk")
                   ) ,
                   mainPanel(tableOutput("asso_good_vis"))),
                   plotlyOutput("good_vis_scat"), br(),
                   visNetworkOutput("good_vis_graph"), br(),
                   plotOutput("good_vis_paracord")),
                 tabPanel("Bad Time Management",sidebarLayout(
                   sidebarPanel(h2("penjelasan ttg support dkk")
                   ) ,
                   mainPanel(tableOutput("asso_bad_vis"))),
                   plotlyOutput("bad_vis_scat"), br(),
                   visNetworkOutput("bad_vis_graph"), br(),
                   plotOutput("bad_vis_paracord"))
      ))),
    
    tabItem(tabName = "cluster", h2("Dashboard")
    ),
    
    tabItem(tabName = "arules", h2("Dashboard tab")
    )
  )
  ),
  footer = dashboardFooter(
    left_text = tags$a(href="https://www.linkedin.com/in/evelinesurbakti/", "Eveline Surbakti") ,
    right_text = tags$a(href="https://www.linkedin.com/in/gerald-bryan-6500711a5/", "Gerald Bryan"))
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
  
  #Information top right
  observeEvent(input$openModal, {
    showModal(
      modalDialog(title = "About Time Management Indicator",
                  p("Some information"),easyClose = TRUE, footer = NULL)
    )
  })
  
  #Menu explaination
  observeEvent(input$tes, {shinyalert("menu 1 blablablablabla",showConfirmButton = FALSE,closeOnEsc = FALSE,
                                      closeOnClickOutside = TRUE)})
  
  observeEvent(input$stat, {shinyalert("menu 2 blablablablablabla",showConfirmButton = FALSE,closeOnEsc = FALSE,
                                       closeOnClickOutside = TRUE)})
  
  observeEvent(input$kode, {shinyalert("menu 3 blablablabla",showConfirmButton = FALSE,closeOnEsc = FALSE,
                                       closeOnClickOutside = TRUE)})
  
  #Question modals
  observeEvent(input$ques1, {
    shinyalert(html = TRUE, text = tagList(
      sliderTextInput("X6", "1. You often feel that your life is aimless, with no definite purpose",choices = c("Strong Disagree","Disagree","Neither","Agree","Strong Agree"),selected = "Neither"), 
      sliderTextInput("X7", "2. You never have trouble organizing the things you have to do",choices = c("Strong Disagree","Disagree","Neither","Agree","Strong Agree"),selected = "Neither"),
      sliderTextInput("X8", "3. Once you've started an activity, you persist at it until you've completed it",choices = c("Strong Disagree","Disagree","Neither","Agree","Strong Agree"),selected = "Neither"),
      sliderTextInput("X9", "4. Sometimes you feel that the things you have to do during the day just don't seem to matter",choices = c("Strong Disagree","Disagree","Neither","Agree","Strong Agree"),selected = "Neither"),
    )) }
  )
  
  observeEvent(input$ques2, {
    shinyalert(html = TRUE, text = tagList(
      sliderTextInput("X10", "5. You will plan your activities from day to day",choices = c("Strong Disagree","Disagree","Neither","Agree","Strong Agree"),selected = "Neither"),
      sliderTextInput("X11", "6. You tend to leave things to the last minute",choices = c("Strong Disagree","Disagree","Neither","Agree","Strong Agree"),selected = "Neither"),
      sliderTextInput("X12", "7. You tend to change rather aimlessly from one activity to another during the day",choices = c("Strong Disagree","Disagree","Neither","Agree","Strong Agree"),selected = "Neither"),
      sliderTextInput("X13", "8. You give up the things that you planning to do just because your friend says no",choices = c("Strong Disagree","Disagree","Neither","Agree","Strong Agree"),selected = "Neither"),
    )) }
  )
  
  observeEvent(input$ques3, {
    shinyalert(html = TRUE, text = tagList(
      sliderTextInput("X14", "9. You think you do enough with your time",choices = c("Strong Disagree","Disagree","Neither","Agree","Strong Agree"),selected = "Neither"),
      sliderTextInput("X15", "10. You are easy to get bored with your day-today activities",choices = c("Strong Disagree","Disagree","Neither","Agree","Strong Agree"),selected = "Neither"),
      sliderTextInput("X16", "11. The important interests/activities in your life tend to change frequently",choices = c("Strong Disagree","Disagree","Neither","Agree","Strong Agree"),selected = "Neither"),
      sliderTextInput("X17", "12. You know how much time you spend on each of the homework I do",choices = c("Strong Disagree","Disagree","Neither","Agree","Strong Agree"),selected = "Neither")
    )) }
  )
  
  #Web Scraping
  
  link <- paste0("https://quickbooks.intuit.com/r/employee-management/time-management-tips/#:~:text=If%20you%20want%20to%20improve%20your%20time%20management,compare%20actual%20time%20spent%20and%20estimated%20time%20spent.")
  pages <- read_html(link)
  
  Tips <- pages %>% 
    html_nodes(".body-article .content-article h2") %>%
    html_text()
  Tips <- Tips[3:27]
  Tips <- as.data.frame(Tips)
  output$time_tips <- renderTable({Tips})
  
  #Use theme for ggplot
  theme_set <- theme(legend.key = element_rect(fill="black"),
                     legend.background = element_rect(color="white", fill="#263238"),
                     plot.subtitle = element_text(size=6, color="white"),
                     panel.background = element_rect(fill="#dddddd"),
                     panel.border = element_rect(fill=NA),
                     panel.grid.minor.x = element_blank(),
                     panel.grid.major.x = element_blank(),
                     panel.grid.major.y = element_line(color="darkgrey", linetype=2),
                     panel.grid.minor.y = element_blank(),
                     plot.background = element_rect(fill="#263238"),
                     text = element_text(color="white"),
                     axis.text = element_text(color="white"))
  
  #Read Data
  original_data <- read.csv("D:/Documents/Supertype/Time Management unit 5 project/Time-Management-Project/International students Time management data.csv")
  
  # Subset the relevant data for the cleaning and transformation
  data <- original_data %>%
    select(-c(Number,Nationality,Program,Course,
              English,Academic,Attendance))
  
  # Construct the 'clean' function
  clean <- function(x){
    # Reduce factor levels
    x$Age <- ifelse(x$Age == "26-30" | x$Age == ">36" | x$Age == "31-35", ">25",x$Age)
    x$Age <- ifelse(x$Age == "<18", "18-20",x$Age)
    x$Age <- ordered(x$Age, levels=c("18-20","21-25",">25"))
    # Change " " into Neither
    x$X6 <- ifelse(x$X6=="","Neither",x$X6)
    x$X8 <- ifelse(x$X8=="","Neither",x$X8)
    x$X9 <- ifelse(x$X9=="","Neither",x$X9)
    x$X10 <- ifelse(x$X10=="","Neither",x$X10)
    x$X11 <- ifelse(x$X11=="","Neither",x$X11)
    x$X12 <- ifelse(x$X12=="","Neither",x$X12)
    x$X14 <- ifelse(x$X14=="","Neither",x$X14)
    x$X16 <- ifelse(x$X16=="","Neither",x$X16)
    x$X17 <- ifelse(x$X17=="","Neither",x$X17)
    
    # Transform the character into Likert Scale 
    x$X6_num <- ifelse(x$X6=="Strong Agree",1,
                       ifelse(x$X6=="Agree",2,
                              ifelse(x$X6=="Neither",3,
                                     ifelse(x$X6=="Disagree",4,5))))
    
    x$X7_num <- ifelse(x$X7=="Strong Agree",5,
                       ifelse(x$X7=="Agree",4,
                              ifelse(x$X7=="Neither",3,
                                     ifelse(x$X7=="Disagree",2,1))))
    
    x$X8_num <- ifelse(x$X8=="Strong Agree",5,
                       ifelse(x$X8=="Agree",4,
                              ifelse(x$X8=="Neither",3,
                                     ifelse(x$X8=="Disagree",2,1))))
    
    x$X9_num <- ifelse(x$X9=="Strong Agree",1,
                       ifelse(x$X9=="Agree",2,
                              ifelse(x$X9=="Neither",3,
                                     ifelse(x$X9=="Disagree",4,5))))
    
    x$X10_num <- ifelse(x$X10=="Strong Agree",5,
                        ifelse(x$X10=="Agree",4,
                               ifelse(x$X10=="Neither",3,
                                      ifelse(x$X10=="Disagree",2,1))))
    
    x$X11_num <- ifelse(x$X11=="Strong Agree",1,
                        ifelse(x$X11=="Agree",2,
                               ifelse(x$X11=="Neither",3,
                                      ifelse(x$X11=="Disagree",4,5))))
    
    x$X12_num <- ifelse(x$X12=="Strong Agree",1,
                        ifelse(x$X12=="Agree",2,
                               ifelse(x$X12=="Neither",3,
                                      ifelse(x$X12=="Disagree",4,5))))
    
    x$X13_num <- ifelse(x$X13=="Strong Agree",1,
                        ifelse(x$X13=="Agree",2,
                               ifelse(x$X13=="Neither",3,
                                      ifelse(x$X13=="Disagree",4,5))))
    
    x$X14_num <- ifelse(x$X14=="Strong Agree",5,
                        ifelse(x$X14=="Agree",4,
                               ifelse(x$X14=="Neither",3,
                                      ifelse(x$X14=="Disagree",2,1))))
    
    x$X15_num <- ifelse(x$X15=="Strong Agree",1,
                        ifelse(x$X15=="Agree",2,
                               ifelse(x$X15=="Neither",3,
                                      ifelse(x$X15=="Disagree",4,5))))
    
    x$X16_num <- ifelse(x$X16=="Strong Agree",1,
                        ifelse(x$X16=="Agree",2,
                               ifelse(x$X16=="Neither",3,
                                      ifelse(x$X16=="Disagree",4,5))))
    
    x$X17_num <- ifelse(x$X17=="Strong Agree",5,
                        ifelse(x$X17=="Agree",4,
                               ifelse(x$X17=="Neither",3,
                                      ifelse(x$X17=="Disagree",2,1))))
    
    # Sum the total score 
    x$score <- x$X6_num + x$X7_num + x$X8_num + x$X9_num + 
      x$X10_num + x$X11_num +x$X12_num + x$X13_num +
      x$X14_num +x$X15_num + x$X16_num +x$X17_num
    
    # Character into Factor
    x <- x %>%
      mutate_if(is.character,as.factor)
  }
  
  data <- clean(data)
  
  
  #Data Visualization (Original Data)
  output$head_data <- renderTable(head(data,5))
  
  dist_plot <-ggplot(data, aes(x = score))+
    geom_histogram(col = "lightblue")+
    theme_set + ggtitle("Total Score Distribution")
  output$dist_plot <- renderPlot(dist_plot)
  
  gender_plot <- ggplot(data, aes(x = Age)) +
    geom_bar(aes(x = Age, fill = Gender), position = "dodge") +
    theme_set + ggtitle("Histogram of Age based on Gender")
  output$gender_plot <- renderPlot(gender_plot)
  
  score_gender <- ggplot(data, aes(x = Age, y = score)) +
    geom_boxplot(aes(fill = Gender)) +
    theme_set + ggtitle("Score Distribution based on Gender and Age")
  output$score_gender <- renderPlot(score_gender)
  
  sum_data <- summary(data$score)
  output$sum_data <- renderText(sum_data)
  
  # Clustering
  
  data_kmean <- data %>%
    select(-c(15:26))
  
  ## Determine the number of clustering use the Elbow Plot
  set.seed(100)
  ## wss function to calculate the total distance within member
  wss <- function(k) {
    kproto(data_kmean, k)$tot.withinss
  }
  
  ## Define k = 1 to 10 
  k.values <- 1:10
  
  ## Extract the wss for 2-10 clusters
  wss_values <- map_dbl(k.values, wss)
  
  output$elbow_plot <- renderPlot(plot(k.values, wss_values,
                                       type="b", pch = 19, frame = FALSE, 
                                       ylim=c(25000,50000),
                                       xlim=c(1,10),
                                       xlab="Number of clusters K",
                                       ylab="Total within-clusters sum of squares", main="Elbow Plot for Kmeans"))
  
  ## Clustering Model
  
  set.seed(100) 
  
  ### Set the model with 3 clusters
  model_clus <- kproto(data_kmean, 3)
  
  ### For not overlaping
  set.seed(100)
  jitter <- position_jitter(width = 0.1, height = 0.1)
  
  ### plot clustering original
  ori_clust <-ggplot(NULL, aes(x = Age, y = score))+
    geom_point(data = data_kmean, aes(col = as.factor(model_clus$cluster)), 
               position = jitter) +
    theme(legend.position = "bottom") +
    guides(fill=FALSE) +
    scale_colour_manual(name = "Cluster",
                        labels = c("Bad", "Good","Normal"),
                        values = c("red","dark green", "gold")) +
    theme_set + ggtitle("Clustering Result")
  output$ori_clust <- renderPlot(ori_clust)
  
  boxplot_cluster <- ggplot(data_kmean, aes(x = as.factor(model_clus$cluster), y = score)) +
    geom_boxplot() +
    labs(title = "Score distribution based on Cluster ", x = "Cluster", y="Score")
  output$boxplot_cluster <- renderPlotly(ggplotly(boxplot_cluster))  
  
  ######################## Kurang cluster buat input data
  
  #Association Rules (MBA)
  
  ## Take only the survey results & Cluster from Original Data (Make data for Association Rules)
  data_kmean_clus <- cbind(data_kmean,model_clus$cluster)
  colnames(data_kmean_clus)[16] <- "cluster"
  
  data_arules <- data_kmean_clus %>% 
    select(c(3:14,16)) # Original survey results and 16 for the cluster identity
  
  data_arules$cluster <- ifelse(data_arules$cluster==1, "Bad",
                                ifelse(data_arules$cluster==2, "Good", "Normal"))
  
  data_arules$cluster <- as.factor(data_arules$cluster)
  
  ## Association rules for bad cluster
  
  ### Apply the association rules with Apriori Algorithm
  mba_bad <- apriori(data_arules, 
                     parameter = list(sup = 0.05, conf = 0.5,
                                      target="rules", minlen=3, maxlen=4),
                     appearance = list(rhs= "cluster=Bad", default = "lhs"))
  
  asso_bad <- inspect(head(sort(mba_bad, by="lift"),5))[,c(1:3)]
  output$asso_bad <- renderTable(asso_bad)
  
  asso_bad_vis <- inspect(head(sort(mba_bad, by="lift"),10))[,c(1:5,7)]
  output$asso_bad_vis <- renderTable(asso_bad_vis)
  
  ### plot scatter plot
  subRules<-mba_bad[quality(mba_bad)$confidence > 0.2]
  
  output$bad_vis_scat <- renderPlotly(plotly_arules(subRules))  
  
  ### Plot graph
  top10subRules <- head(subRules, n = 10, by = "confidence")
  output$bad_vis_graph <- renderVisNetwork(plot(top10subRules, method = "graph",  engine = "htmlwidget")) 
  
  ### Plot parallel coordinate
  subRules2<-head(subRules, n=10, by="lift")
  
  output$bad_vis_paracord <- renderPlot(plot(subRules2, method="paracoord"))
  
  ## Association rules for bad cluster
  
  ### Apply the association rules with Apriori Algorithm
  mba_good <- apriori(data_arules, 
                      parameter = list(sup = 0.05, conf = 0.5,
                                       target="rules",minlen=3,maxlen=4),
                      appearance = list(rhs= "cluster=Good", default = "lhs"))
  
  asso_good <- inspect(head(sort(mba_good, by="lift"),5))[,c(1:3)]
  output$asso_good <- renderTable(asso_good)
  
  asso_good_vis <- inspect(head(sort(mba_good, by="lift"),10))[,c(1:5,7)]
  output$asso_good_vis <- renderTable(asso_good_vis)
  
  ### plot scatter plot
  subRules_good<-mba_good[quality(mba_good)$confidence > 0.2]
  
  output$good_vis_scat <- renderPlotly(plotly_arules(subRules_good))  
  
  ### Plot graph
  top10subRules_good <- head(subRules_good, n = 10, by = "confidence")
  output$good_vis_graph <- renderVisNetwork(plot(top10subRules_good, method = "graph",  engine = "htmlwidget")) 
  
  ### Plot parallel coordinate
  subRules2_good<-head(subRules_good, n=10, by="lift")
  
  output$good_vis_paracord <- renderPlot(plot(subRules2_good, method="paracoord")) 
}

# Run the application 
shinyApp(ui = ui, server = server)