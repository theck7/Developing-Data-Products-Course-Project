library(shiny)
shinyUI(fluidPage(
  titlePanel("Predict Child's Height"),
  sidebarLayout(
    sidebarPanel(
      helpText("Predict a child's height using the parent's height and child's gender"),
      helpText("Inputs:"),
      sliderInput("sliderFather", "Father's Height (in inches)", min = 64, max = 78.5, value = 62, step = .5),
      sliderInput("sliderMother", "Mother's Height (in inches)", min = 64, max = 70.5, value = 58, step = .5),
      radioButtons("Gender", "Child's Gender", choices = c("Female"="female", "Male"="male"), inline = TRUE)
    ),
    mainPanel(
      plotOutput("plot1"),
      h3("Predicted Child's Height:"),
      textOutput("pred1")
    )
  )
))