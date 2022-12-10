#app_ui

#libraries
library(shiny)
library(dplyr)
library(shinythemes)

introduction_page <- tabPanel(
  "Introduction",
  shinythemes::themeSelector(),
  fluidPage(theme=shinytheme("united")),
  titlePanel(h2("Introduction")),
  h5("CO2 is a greenhouse gas that is exhaled by animals including humans and is
     absorbed by plants as a key nutrient for them. Animals produce some CO2, but
     engineers and other machinery can produce CO2, which is called CO2
     emissions. Light and heat from the sun are constantly entering the 
     atmosphere. The buildup of CO2 traps the heat, which contributes significantly 
     to global climate change. Levels in the air contribute to extreme weather 
     events like hurricanes tornadoes, floods, droughts, cold spells, and hot 
     spells. Some claim that CO2 causes the temperature to rise through the 
     greenhouse effect, and others believe that CO2 emissions from things like 
     fossil fuels are what causes a rise in temperature. The greenhouse effect 
     and CO2 are important to prevent the earth from freezing. However, too much
     CO2 can cause a dangerous rise in temperature"),
  h3("The Growth of CO2 and its Capita"),
  h5("Monitoring how many tons of CO2 that are emitted per country is extremely 
    important. The CO2 growth percentages are the rate at which CO2 emissions 
     have increased or decreased. These results exclude any emissions from traded 
     goods or terriorital emissions. The CO2 per capita is to get the average
     emission per person so it can be considered how to reduce the CO2 for each
     individual. Populations do not always remain the same size and can change
     over the course of a year, which will affect the percentage rates of CO2. 
     The GDP also changes as well as the CO2 emissions depending on the year."),
  #display the summary table (averages)
  h3("Summary"),
  h5("These summary tables display the minimum, average, and maximum values for co2,
  co2 per capital, and co2 growth."),
  mainPanel(
  verbatimTextOutput("summary1"),
  verbatimTextOutput("summary2"),
  verbatimTextOutput("summary3"),
  h3("Scatterplot Visualization"),
  h5("This interactive CO2 scatterplot will enable us to analyze and consider how much 
     CO2 we are putting in the atmosphere. By looking at the trends, we can also
     find potential solutions to reduce the amount of CO2 emissions. 
     In addition to this, we are able to determine the CO2 that is emitted 
     into the atmosphere."),
  h5("The CO2 chart displays trends in CO2 emissions in one of the years 
     selected: 1990, 2000, 2005, 2015, and 2018."),
  h5("The trends can be selected to compare an x and y variable of CO2 emissions, CO2 per capita, GDP,
  CO2 growth percentage, or population."),
  h3("Analyzing the Plot"),
  h5("To see if countries with higher GDP emit more CO2: X = GDP and Y = CO2 Emissions"),
  h5("To see if countries with higher GDP emit more CO2 per person: X = GDP and Y = CO2 Per Capita"),
  h5("To see if countries with more CO2 emissions are decreasing their CO2: X = CO2 Emissions and Y = CO2 Growth"),
  h5("For example, when the year 2018 is selected with the variables CO2 emissions and 
     GDP, the scatterplot will show the GDP based on the amount of CO2 emission of
     that country in 2018. We can see that there is a positive linear relationship 
     between the variables with higher income countries having more emissions 
     than low and middle income countries.")
  
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
                  choices = c("CO2 Emissions", "CO2 per Capita", "GDP", "CO2 Growth Percentage", "Population")),
      selectInput("y",
                  "Y axis variable:",
                  choices = c("CO2 Emissions","CO2 per Capita", "GDP","CO2 Growth Percentage", "Population")),
      textOutput("scatter_caption2")
      
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
