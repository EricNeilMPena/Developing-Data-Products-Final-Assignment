library(shiny)
shinyUI(fluidPage(
  titlePanel("Predict Temperature from Ozone level"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("sliderOzone", "What is the level of Ozone in Metro Manila?", 1, 170, value = 94),
      checkboxInput("showModel1", "Show/Hide Model 1", value = TRUE),
      checkboxInput("showModel2", "Show/Hide Model 2", value = TRUE),
      submitButton("Submit")
    ),
    # ...
    mainPanel(
      plotOutput("plot1"),
      h1("Predicted Result (Fahrenheit)"),
      h3("Predicted temperature - Model 1:"),
      textOutput("predOne"),
      h3("Predicted temperature - Model 2:"),
      textOutput("predTwo")
      
    )
  )
))