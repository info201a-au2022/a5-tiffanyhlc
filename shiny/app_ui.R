#app_ui

#libraries
library(shiny)
library(dplyr)

introduction_page <- tabPanel(
  "Introduction",
  titlePanel("Introduction"),
  h3("*Analyzed Variables*"),
  h4("*my analysis*"),
  h3("*Values*"),
  h4("*This table displays the average of co2, co2 per capital, and 
     co2 growth.*"),
  #display the summary table (averages)
  mainPanel(
  verbatimTextOutput("summary")
  )
)

interactive_viz <- tabPanel(
  "CO2 Chart",
  titlePanel("CO2 Chart"),
  h5("*caption*"),
  sidebarLayout(
    sidebarPanel(
      selectInput("x",
                  "Variable on the X axis",
                  choices = c("co2","gdp")),
      selectInput("y",
                  "Variable on the Y axis",
                  choices = c("co2","gdp"))
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("scatter")
    )
  )
)
  
  ui <- navbarPage(
    "C02 Emissions",
    introduction_page,
    interactive_viz
  )
