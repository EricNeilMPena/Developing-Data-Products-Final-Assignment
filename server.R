library(shiny)
shinyServer(function(input, output) {
  airquality$Ozonesp <- ifelse(airquality$Ozone - 94 > 0, airquality$Ozone - 94, 0)
  model1 <- lm(Temp ~ Ozone, data = airquality)
  model2 <- lm(Temp ~ Ozonesp + Ozone, data = airquality)
  
  model1pred <- reactive({
    OzoneInput <- input$sliderOzone
    predict(model1, newdata = data.frame(Ozone = OzoneInput))
  })
  
  model2pred <- reactive({
    OzoneInput <- input$sliderOzone
    predict(model2, newdata = 
              data.frame(Ozone = OzoneInput,
                         Ozonesp = ifelse(OzoneInput - 94 > 0,
                                          OzoneInput - 94, 0)))
  })
  output$plot1 <- renderPlot({
    OzoneInput <- input$sliderOzone
    
    plot(airquality$Ozone, airquality$Temp, xlab = "Ozone level in the air", 
         ylab = "Temperature (Fahrenheit)", bty = "n", pch = 16,
         xlim = c(1, 170), ylim = c(56, 97))
    if(input$showModel1){
      abline(model1, col = "firebrick4", lwd = 2)
    }
    if(input$showModel2){
      model2lines <- predict(model2, newdata = data.frame(
        Ozone = 1:170, Ozonesp = ifelse(1:170 - 94 > 0, 1:170 - 94, 0)
      ))
      lines(1:170, model2lines, col = "deepskyblue4", lwd = 2)
    }
    legend(25, 250, c("Model 1 Prediction", "Model 2 Prediction"), pch = 16, 
           col = c("red", "blue"), bty = "n", cex = 1.2)
    points(OzoneInput, model1pred(), col = "firebrick4", pch = 20, cex = 3)
    points(OzoneInput, model2pred(), col = "deepskyblue4", pch = 20, cex = 3)
  })
  
  output$predOne <- renderText({
    model1pred()
  })
  
  output$predTwo <- renderText({
    model2pred()
  })
  
})