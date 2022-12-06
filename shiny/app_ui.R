#app_ui

#libraries
library(shiny)
library(dplyr)

introduction_page <- tabPanel(
  "Introduction",
  titlePanel("Introduction"),
  h2("*Analyzed Variables*"),
  h4("*my analysis*"),
  h2("*Values (3)*"),
  h4("*my analysis*"),
)

interactive_viz <- tabPanel(
  "CO2 Chart",
  titlePanel("CO2 Chart"),
  h5("*caption*")
)
  sidebarLayout(
    sidebarPanel(
      sliderInput("bins",
                  "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 30)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot")
    )
  )
  
  ui <- navbarPage(
    "C02 Emissions",
    introduction_page,
    interactive_viz
  )
