#app_server

#libraries
library(dplyr)
library(ggplot2)

## read data
emissions_df <- read.csv("../data/owid-co2-data.csv")
#View(emissions_df)

emissions_df <- emissions_df %>% select( c("country", "year" , "co2" , "co2_per_capita" , "co2_growth_prct" ,"gdp", "population" )) %>%

mutate("CO2 Emissions" = co2, "CO2 per Capita" = co2_per_capita, "CO2 Growth Percentage" = co2_growth_prct, "GDP" = gdp, "Population" = population) %>%
       
filter( ! (country %in% c("Africa","Africa (GCP)" ,"Asia","Asia (GCP)", "Asia (excl. China and India)",
                          "World", "Europe" ,"Europe (GCP)", "Europe (excl. EU-27)","High-income countries",
                          "Europe (excl. EU-28)","European Union (27)","European Union (27) (GCP)","European Union (28)",
                          "Non-OECD (GCP)","North America","North America (GCP)","North America (excl. USA)",
                          "OECD (GCP)","Oceania", "Oceania (GCP)", "Panama Canal Zone (GCP)" , "Middle East (GCP)", 
                          "South America","South America (GCP)" , "Upper-middle-income countries","Low-income countries", "Lower-middle-income countries" ) ))
###look at the country's name
#emissions_df %>% pull("country") %>% unique()


#raw_codebook <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-codebook.csv")
#View(raw_codebook)


emissions_df %>% filter(year==2018) %>% filter(co2==max(co2, na.rm=TRUE) ) %>% pull("country")


## server
options(scipen=20)
server <- function(input, output) {
  
emissions_df_summary <- emissions_df %>%
group_by(country) %>%
filter( year==max(year)) %>%
ungroup()

#summary values (3)
output$summary1 <-renderPrint({
  emissions_df_summary %>%
    summarize(
      Variable = "CO2 Emissions",
      Min = min(co2, na.rm = TRUE),
      Mean = mean(co2, na.rm = TRUE),
      Max = mean(co2, na.rm = TRUE)
      
    )
})
output$summary2 <-renderPrint({
  emissions_df_summary %>%
    summarize(
      Variable="CO2 per capita",
      Min = min(co2_per_capita, na.rm = TRUE),
      Mean = mean(co2_per_capita, na.rm = TRUE),
      Max = max(co2_per_capita, na.rm = TRUE)
    )
})

output$summary3 <-renderPrint({
  emissions_df_summary %>%
    summarize(
      Variable="CO2 growth",
    Min = min(co2_growth_prct, na.rm = TRUE),
    Mean = mean(co2_growth_prct, na.rm = TRUE),
    Max = max(co2_growth_prct, na.rm = TRUE)
      
      
    )
})
  
regFormula <- reactive({
as.formula(paste0("`",input$y, "`" ,'~', "`" , input$x, "`" ))
  })
  
emissions_df_scatter <-reactive({ emissions_df[emissions_df$year==as.numeric(input$year),] })

title_scatter <- reactive(paste(input$x, "vs", input$y, "in" , input$year))
output$scatter <- renderPlot({
  plot(regFormula(), emissions_df_scatter() , main=title_scatter(), pch=19)
  })
output$scatter_caption <- renderText(paste("This visualization is a scatterplot that
                                     displays the trends of countries'", input$y, 
                                     "based on their", input$x, "by year", input$year, ".
                                     The trends are then observed by selecting a variety of different
                                     variables including CO2 Emissions, GDP, CO2 Growth Percentage, or Population."))
output$scatter_caption2 <- renderText(paste("Observe each scatterplot individually to determine 
                                            the correlation between two variables in a given year."))
}

