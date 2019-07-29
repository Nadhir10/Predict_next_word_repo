
library(shiny)


# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Predict Next Word app"),
  
  # Sidebar with a slider input for number of bins 
  verticalLayout(
      textInput("txt",
                "Put you phrase here:",
                value = ""),
      actionButton(inputId="go",label = "predict nex word", icon = NULL, width = NULL),
      verbatimTextOutput("txt1")
    )
    
  )
)
