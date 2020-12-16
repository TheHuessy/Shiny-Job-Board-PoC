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

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Old Faithful Geyser Data"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            htmltools::h3("Sidebar Placeholder!")
            
        ),

        # Show a plot of the generated distribution
        mainPanel(
            tabsetPanel(
                tabPanel("DATA INPUT",
                         uiOutput(outputId = "input_form")
                         # textInput(inputId = "postition_title",
                         #              label = "Job Title"),
                         # textInput(inputId = "position_location",
                         #           label = "Job Location"),
                         # textAreaInput(inputId = "position_description",
                         #           label = "Job Description"),
                         # ## You can keep copying the above textInput pieces to add more fileds.
                         # ## The textAreaInput field is the same thing, just with more "room" to see block/paragraph type text
                         # 
                         # actionButton(inputId = "submit_button",
                         #              label = "Submit"
                         #              )
                         
                         ),
                tabPanel("DATA VIEW",
                         actionButton(inputId = "refresh_button",
                                      label = "Refresh List"),
                         DT::dataTableOutput(outputId = "board_view")
                         
                )
            )
        )
    )
))
