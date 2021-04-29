# Invoking required libraries
library(shiny)
library(shinydashboard, warn.conflicts = FALSE)
library(shinythemes)
library(shinyWidgets)

# Setting working directory
setwd("C:\\Users\\rejid4996\\Desktop\\My Projects\\Project Theia\\Theia Images")  

# Define UI for data upload app ----
ui <- navbarPage(
  position = "fixed-top", # To keep navigation bar static
  theme = shinytheme("slate"), # Applying slate theme
  
  fluid = TRUE,
  responsive = NULL,
  
  # Dashboard Title
  "Image Search Dashboard",
  
  # Default Selected Tab ----
  tabPanel("THEIA", icon = icon("fire",  lib = "glyphicon"),
           
           # Page Break
           br(),br(),br(),br(),
           
           # Sidebar layout with input and output definitions ----
           sidebarLayout(
             
             # Sidebar panel for inputs 
             sidebarPanel(
               
               # Search input for searching image
               searchInput(
                 inputId = "search",
                 label = "Enter your text",
                 value = "",
                 placeholder = "Theia Search",
                 btnSearch = icon("search"),
                 btnReset = icon("remove"),
                 width = "450px"
               ),
               
               # Radio buttons to classify the type of image
               radioButtons(
                 "radio",
                 label = "Type",
                 choices = list("Certificates" = 1, "Bills" = 2, "Visiting Cards" = 3,
                                "Address Proofs" = 4, "Others" = 5
                 ),
                 selected = 5
                 
               ),
               
               # Invoking an action button for search option
               actionButton("action", label = "Search", class = "btn-secondary")
               
             ),
             
             # Main panel for displaying outputs ----
             mainPanel(
               
               # Output: Data file ----
              #imageOutput("myImage")
           # for(i in range(1,length(list_of_paths))){
              # imageOutput(paste('myImage', 1, sep = ''))
           # }
              uiOutput("myImage1") 
             )
        )
  ),
           
  # Navigation menu tab
  tabPanel("Help",icon = icon("question-circle")),
  
  # Navigation menu tab
  navbarMenu("Users", icon = icon("users"), tabPanel("Profile", icon = icon("user")),
             tabPanel("Privacy", icon = icon("shield")), tabPanel("About", icon = icon("cogs"))),
  
  # Navigation menu tab
  tabPanel("Repository", icon = icon("database"), 
           
           # Page Break
           br(), br(), br(), br(),

           fluidRow(
             # List to collect all images from a directory
             b64 <- list(),
             for (i in list.files()) {
               name <- paste('image:', i, sep = '')
               tmp <- base64enc::dataURI(file = i, mime = "image/png")
               b64[[name]] <- tmp
             },
             
             # List to display all images in the UI
             a64 <- list(),
             for (j in (1:length(b64))) {
               name_1 <- paste('img:', j, sep = '')
               tmp_1 <- img(src = b64[j],
                            width = 250,
                            height = 250)
               a64[[name_1]] <- tmp_1
             },
             
             # Output list of images
             a64
             
           )
         )
       )


# Define server logic to read selected file ----
server <- function(input, output) {
 
  
  output$contents <- renderPlot({
    

  })
    
  output$myImage1 <- renderUI({
    if(input$search==''){
    
       img(src = b64[1],
           width = 600,
           height = 400)
      
      
    }
    
    else{
    c <- input$search
    id <- grep(toString(c), list_data,ignore.case = TRUE)
    list_of_paths<-list()
    for(i in 1:length(id)){
      list_of_paths[i]<-c(img_train[id[i]])
    }
    k <- list()
    for(j in list_of_paths){
      k[[j]] <- img(src = j,width = 250,
                      height = 250)
    }
    b64 <- list()
    for (i in list_of_paths) {
      name <- paste('image:', i, sep = '')
      tmp <- base64enc::dataURI(file = i, mime = "image/png")
      b64[[name]] <- tmp
    }
    
    # List to display all images in the UI
    a64 <- list()
    for (j in (1:length(b64))) {
      name_1 <- paste('img:', j, sep = '')
      tmp_1 <- img(src = b64[j],
                   width = 250,
                   height = 250)
      a64[[name_1]] <- tmp_1
    }
    
    # Output list of images
    a64
    }
            
         })

 
  

}







# Run the app ----
shinyApp(ui, server)

