
library(shiny)
library(readr)


shinyServer(function(input, output) {
    
    ##### HELPER FUNCTIONS #####
    
    ## Parse inputs into a dataframe
    parse_inputs <- function(job_title, job_location, job_description){
        
        ## Build a single row dataframe using the form inputs that we're passing into the function
        output_df <- data.frame("title" = job_title,
                                "loc" = job_location,
                                "descr" = job_description)
        
        ## Simply have the function return the dataframe object once it's built
        ## Note, this could be done in a single line, but I think it's easier to read/follow this way
        return(output_df)
        
    }
    
    ## Save the dataframe to the csv file based on user inputs
    save_data_to_file <- function(job_title, job_location, job_description){
        ## Parse the inputs
        data <- parse_inputs(job_title = job_title,
                             job_location = job_location,
                             job_description = job_description)
        
        ## Write the data out
        write.csv(data,
                  "job_data.csv",
                  append = TRUE,
                  row.names = FALSE
                  )
        
    }
    
    ## Defines/redefines the output of the renderUI object in the ui file with a single function call, the '<<-' makes it a universal variable but, more importantly, will overwrite any existing definition for that output
    blank_input <- function(){
        
        output$input_form <<- renderUI({ list(
            textInput(inputId = "postition_title",
                      label = "Job Title"),
            textInput(inputId = "position_location",
                      label = "Job Location"),
            textAreaInput(inputId = "position_description",
                          label = "Job Description"),
            ## You can keep copying the above textInput pieces to add more fileds, like 'source' or 'link'.
            ## The textAreaInput field is the same thing, just with more "room" to see block/paragraph type text
            actionButton(inputId = "submit_button",
                         label = "Submit"
                         )
            )
        })
        }
    
    ## Goes out, grabs the whole csv and throws it at the datatable object on the second tab, effectively refreshing it
    fill_table <- function(){
        dat <- read_csv("job_data.csv")
        output$board_view <<- renderDataTable(dat)
    }
    
    
    #####
    
    ##### THE ACTUAL APP SERVER CODE #####

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
    
    ## Refresh the table view when the refresh button is clicked
    observeEvent(input$refresh_button,{
        fill_table()
    })
    
    
})
