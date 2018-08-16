library(shiny)
library(HistData)
data(GaltonFamilies)

shinyServer(function(input, output) {
  model1 <- lm(childHeight ~ father + mother + gender, data=GaltonFamilies)

  model1pred <- reactive({
    FatherHeight <- input$sliderFather
    MotherHeight <- input$sliderMother
    Gender <- factor(input$Gender, levels=levels(GaltonFamilies$gender))
    predict(model1, newdata = data.frame(father = FatherHeight, mother = MotherHeight, gender = Gender))
  })
  
  output$plot1 <- renderPlot({
    plot(GaltonFamilies$childHeight ~ GaltonFamilies$midparentHeight, 
         xlab = "Average Parent's Height (in inches)",
         ylab = "Child's Height (in inches)", 
         bty = "n", 
         pch = 16, 
         col=ifelse(GaltonFamilies$gender=="female", "pink", "light blue"))
    legend(73, 60, pch = 19, col =c("pink","light blue"), c("Female", "Male"), bty = "n", cex=.8)
    points(mean(c(input$sliderFather,input$sliderMother)), model1pred(), col = "black", bg = "grey", pch = 23, cex = 2)
  })
  
  output$pred1 <- renderText({
    paste0(round(model1pred(), digits = 2)," inches")
  })
})