#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)

source("/Users/tiffanychung/Documents/info201/Assignments/a5-tiffanyhlc/shiny/app_ui.R")
source("/Users/tiffanychung/Documents/info201/Assignments/a5-tiffanyhlc/shiny/app_server.R")

# Run the application 
shinyApp(ui = ui, server = server)