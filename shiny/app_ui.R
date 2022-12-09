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
     absorbed by plants as a key nutrient for them. Animals produce some CO2 but,
     engineers and other machinery are also to produce CO2, which is called CO2
     emissions. Light and heat from the sun are constantly entering the 
     atmosphere. The buildup of CO2 traps the heat which contributes significantly 
     to global climate change. Levels in the air contribute to extreme weather 
     events like hurricanes tornadoes, floods, droughts, cold spells, and hot 
     spells. Some claim that CO2 causes the temperature to rise through the 
     greenhouse effect, and others believe that CO2 emissions from things like 
     fossil fuels is what causes a rise in temperature. The greenhouse effect 
     and CO2 is important to prevent the earth from freezing, however too much
     CO2 can cause a dangerous rise in temperature"),
  h3("The Growth of CO2 and its Capita"),
  h5("Monitoring how many tons of CO2 that are emitted per country is extremely 
    important. The CO2 growth percentages are the percent/rate at which CO2 emissions 
     have increased or decreased. These results exclude any emissions from traded 
     goods or terriorital emissions. The CO2 per capita is to get the average
     emission per person so it can be considered how to reduce the CO2 for each
     individual. Populations do not always remain the same size and can change
     over the course of a year which will affect the percentage rates of CO2. 
     The GDP also changes as well as the CO2 emissions depending on the year."),
  #display the summary table (averages)
  h3("Summary Table"),
  mainPanel(
  verbatimTextOutput("summary"),
  h6("This summary table displays the minimum, average, and maximum values for co2,
  co2 per capital, and co2 growth."),
  h3("Scatterplot Visualization"),
  h5("This interactive CO2 scatterplot will enable us to analyze and consider how much 
     CO2 we are putting in the atmosphere. By looking at the trends, we can also
     find potential solutions to either reduce the amount of CO2 emissions. 
     In addition to this, we are able to determine the CO2 that is emitted 
     into the atmosphere."),
  h5("The CO2 chart displays trends in CO2 Emissions in one of the years 
     selected: 1990, 2000, 2005, 2015, and 2018."),
  h5("Compare the trends by selecting an x and y variable of CO2 Emissions, GDP,
  CO2 Growth Percentage, or Population."),
  h3("Analyzing the Plot"),
  h5("When the year 2018 is selected with the variables GDP and Population, the scatterplot will show the size of the population of a 
  countries based on the GDP of that country in 2018. We can see that there is a 
  positive correlation between GDP and population and we can see a positive
  correlation with outliers. The higher the GDP tends to be, the larger the
  population is."),
  h5("If we select CO2 Growth Percentage as the x variable and CO2 Emissions as
     the y variable for the year of 2018, we can see that the CO2 emissions 
     when at 0, can have many different growth percentages. This is the same when the
     growth percentage is at 0, CO2 emissions are all scattered in the center 
     of the plot. We can see that the variables do not have much correlation.")
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
                  choices = c("CO2 Emissions","GDP","CO2 Growth Percentage", "Population")),
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
