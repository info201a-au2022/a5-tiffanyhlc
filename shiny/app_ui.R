#app_ui

#libraries
library(shiny)
library(dplyr)
library(shinythemes)

introduction_page <- tabPanel(
  "Introduction",
  shinythemes::themeSelector(),
  fluidPage(theme=shinytheme("flatly")),
  titlePanel("Introduction"),
  h3("About the Variables"),
  h4("CO2 allows us to know how many tons of CO2 are emitteed per country, the
     co2 growth lets us know if the co2 emissions are increasing or decreasing.
     The co2 per capital is to get the average emission per person."),
  h4("*my analysis*"),
  h4("*This table displays the minimum, average, and maximum values in co2,
  co2 per capital, and co2 growth.*"),
  #display the summary table (averages)
  mainPanel(
  verbatimTextOutput("summary"),
  h4("On average, a country emits 4.7 tons of co2 a year per person. 
The country with lowest emissions per capita is ___ with 0.027 tons per person ; 
and the country with the highest emissions per capita was ___ with 35.6 tons per person.
")
  )
)



interactive_viz <- tabPanel(
  "CO2 Chart",
  titlePanel("Trends in CO2 Emissions"),
  sidebarLayout(
    sidebarPanel(
      selectInput("year","Select year:",
                   choices = c("1990","2000", "2005", "2015", "2018"),
                   selected= "2018"),
      selectInput("x",
                  "X axis variable:",
                  choices = c("CO2 Emissions","GDP", "CO2 Growth Percentage", "Population")),
      selectInput("y",
                  "Y axis variable:",
                  choices = c("CO2 Emissions","GDP","CO2 Growth Percentage", "Population"))
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("scatter"),
      textOutput("scatter_caption")
    ),
  )
)
  
  ui <- navbarPage(
    "C02 Emissions",
    introduction_page,
    interactive_viz
  )
