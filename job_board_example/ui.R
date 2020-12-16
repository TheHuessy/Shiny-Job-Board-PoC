#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(htmltools)
library(DT)


shinyUI(fluidPage(

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            ## You could turn this into your navigation area instead of the tabs there. I was lazy
            htmltools::h3("Sidebar Placeholder!")
            
        ),

        mainPanel(
            tabsetPanel(
                tabPanel("DATA INPUT",
                         ## We're using a uiOutput instead of just putting the UI elements here so that we can reset the form after submission via a single line function
                         uiOutput(outputId = "input_form")
                         ),
                tabPanel("DATA VIEW",
                         
                         ## Button that refreshes the table and populates it from the csv file
                         actionButton(inputId = "refresh_button",
                                      label = "Refresh List"),
                         
                         ## The table output from the csv. Static until the refresh button is pushed
                         DT::dataTableOutput(outputId = "board_view")
                         
                )
            )
        )
    )
))
