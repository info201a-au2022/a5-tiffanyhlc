#app_server

#libraries
library(dplyr)
library(ggplot2)

## read data
emissions_df <- read.csv("/Users/tiffanychung/Documents/info201/Assignments/a5-tiffanyhlc/data/owid-co2-data.csv")
View(emissions_df)

raw_codebook <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-codebook.csv")
View(raw_codebook)

## trim datasets

## server
server <- function(input, output) {
#summary values (3)
  output$summary <-renderPrint({
    emissions_df %>%
    summarize(
    mean_co2 = mean(co2, na.rm = TRUE),
    mean_co2_percapita = mean(co2_per_capita, na.rm = TRUE),
    mean_co2_growth = mean(co2_growth_prct, na.rm = TRUE)
      )
  })
  
  regFormula <- reactive({
    as.formula(paste(input$y ,'~', input$x))
  })
  
  output$scatter <- renderPlot({
    plot(regFormula(), emissions_df , pch=19)
  }
      )
  }
