#app_server

#libraries
library(dplyr)
library(ggplot2)

## read data
emissions_df <- read.csv("/Users/tiffanychung/Documents/info201/Assignments/a5-tiffanyhlc/data/owid-co2-data.csv")
#View(emissions_df)

emissions_df <- emissions_df %>% select( c("country", "year" , "co2" , "co2_per_capita" , "co2_growth_prct" ,"gdp", "population" )) %>%

mutate("CO2 Emissions" = co2, "CO2 Emissions per Capita" = co2_per_capita, "CO2 Growth Percentage" = co2_growth_prct, "GDP" = gdp, "Population" = population)
       
#filter( ! (country %in% c("World", "Europe" ,"Europe (GCP)", "Europe (excl. EU-27)"), "High-income countries",
#       "Europe (excl. EU-28)" ,"European Union (27)", "European Union (27) (GCP)" , "European Union (28)") )

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
output$summary <-renderPrint({
emissions_df_summary %>%
summarize(
min_co2 = min(co2, na.rm = TRUE),
mean_co2 = mean(co2, na.rm = TRUE),
max_co2 = mean(co2, na.rm = TRUE),
min_co2_percapita = min(co2_per_capita, na.rm = TRUE),
mean_co2_percapita = mean(co2_per_capita, na.rm = TRUE),
max_co2_percapita = max(co2_per_capita, na.rm = TRUE),
min_co2_growth = min(co2_growth_prct, na.rm = TRUE),
mean_co2_growth = mean(co2_growth_prct, na.rm = TRUE),
max_co2_growth = max(co2_growth_prct, na.rm = TRUE)
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
                                     "based on their", input$x, "by year", input$year, "."))
output$scatter_caption2 <- renderText(paste("Observe each scatterplot individually to determine 
                                            the correlation between two variables in a given year."))
}

