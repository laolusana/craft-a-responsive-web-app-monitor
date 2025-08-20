# ade0_craft_a_respons.R

# Load necessary libraries
library(shiny)
library(ggplot2)
library(DT)

# Define UI
ui <- fluidPage(
  # Title
  titlePanel("Responsive Web App Monitor"),
  
  # Sidebar with inputs
  sidebarLayout(
    sidebarPanel(
      selectInput("app", "Select App:", c("App1", "App2", "App3")),
      dateInput("start", "Start Date:", value = Sys.Date() - 7),
      dateInput("end", "End Date:", value = Sys.Date())
    ),
    
    # Output
    mainPanel(
      tabsetPanel(
        tabPanel("Dashboard", 
                 fluidRow(
                   column(width = 6, 
                          boxplotOutput("response_time")),
                   column(width = 6, 
                          tableOutput("errors"))
                 )
        ),
        tabPanel("Data", 
                 dataTableOutput("data"))
      )
    )
  )
)

# Define server
server <- function(input, output) {
  # Load data
  data <- reactive({
    # Load data based on input$app and input$start-input$end
    # Replace with your data loading logic
    data.frame(response_time = runif(100), errors = sample(1:10, 100, replace = TRUE))
  })
  
  # Create response time plot
  output$response_time <- renderBoxplot({
    boxplot(data()$response_time ~ 1, main = "Response Time (ms)")
  })
  
  # Create errors table
  output$errors <- renderTable({
    head(data()[order(data()$errors, decreasing = TRUE), ], 10)
  })
  
  # Create data table
  output$data <- renderDataTable({
    data()
  })
}

# Run the application
shinyApp(ui = ui, server = server)