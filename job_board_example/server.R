#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(readr)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    parse_inputs <- function(job_title, job_location, job_description){
        # test <- c(job_title, job_location, job_description)
        # print(test)
        
        
        output_df <- data.frame("title" = job_title,
                                "loc" = job_location,
                                "descr" = job_description)
        return(output_df)
        
    }
    
    save_data_to_file <- function(job_title, job_location, job_description){
        data <- parse_inputs(job_title = job_title,
                             job_location = job_location,
                             job_description = job_description)
        write.csv(data,
                  "job_data.csv",
                  append = TRUE,
                  row.names = FALSE
                  )
        
    }
    
    blank_input <- function(){
        output$input_form <<- renderUI({ list(
            textInput(inputId = "postition_title",
                      label = "Job Title"),
            textInput(inputId = "position_location",
                      label = "Job Location"),
            textAreaInput(inputId = "position_description",
                          label = "Job Description"),
            ## You can keep copying the above textInput pieces to add more fileds.
            ## The textAreaInput field is the same thing, just with more "room" to see block/paragraph type text
            actionButton(inputId = "submit_button",
                         label = "Submit"
                         ),
            
            ##################
            verbatimTextOutput(outputId = "testing_output")
            ##################
        )
        })
    }
    
    fill_table <- function(){
        dat <- read_csv("job_data.csv")
        output$board_view <<- renderDataTable(dat)
    }
    

    ## Establish the blank form
    blank_input()
    
    ## Establish the board view from what exists in your job_data.csv file
    fill_table()
    
    ## Grab all the inputs (as is) from the form and put them in the csv
    observeEvent(input$submit_button, {
        input_job_title <- isolate(input$postition_title)
        input_job_location <- isolate(input$position_location)
        input_job_description <- isolate(input$position_description)
        
        #output$testing_output <- renderText({input_job_title})
        save_data_to_file(input_job_title, input_job_location, input_job_description)
        
        ## Reset form 
        blank_input()
        
        
        
    })
    
    observeEvent(input$refresh_button,{
        fill_table()
    })
    
    
})
