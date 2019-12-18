#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(DT)
library(plyr)
library(leaflet)
library (reshape2)
full_trains <- read.csv(file = "french-sncf-train-regularties/french-sncf-trains-regularities/full_trains.csv", header=TRUE, sep=",")
#mens_trains <- read.csv(file = "french-sncf-train-regularties/french-sncf-trains-regularities/regularite-mensuelle-tgv-aqst.csv", header=TRUE, sep=";",nrows=1000)
airports <- read.csv(file="usa-flight-delays/airports.csv", header=TRUE, sep=",",nrows=200)
flights <- read.csv(file="usa-flight-delays/flights.csv", header=TRUE, sep=",",nrows=200)

flights[["ELAPSED_TIME"]][is.na(flights[["ELAPSED_TIME"]])] <- 0
flights[["DEPARTURE_DELAY"]][is.na(flights[["DEPARTURE_DELAY"]])] <- 0
flights[["ARRIVAL_DELAY"]][is.na(flights[["ARRIVAL_DELAY"]])] <- 0
ap <- as.data.frame(airports)
true_trains <-as.data.frame(full_trains)

ap_coord <- ap[,6:7]

# Define UI for application that draws a histogram

ui <- navbarPage( "Navigation",

            tabPanel("Intro",
                           includeMarkdown("./md/intro.md"),
                           hr()),
    
    # Show a plot of the generated distribution
    tabPanel("US flights dashboard",
             radioButtons("radio", label = h3("Radio buttons"),
                          choices = list("Per airline" = 1, "Per departure airport" = 2)),
             conditionalPanel("input.radio == 1",
      tabsetPanel(type = "tabs",
                  tabPanel("Map", leafletOutput("mymap")),
                  tabPanel("Tot. flights per airline", 
                           tableOutput("flights_per_airline")),
                  tabPanel("Tot.Delayed flights per airline",
                           tableOutput("delayed_flights_per_airline")),
                  tabPanel("Mean Time per airlines",
                           tableOutput("mean_time_per_airline")),
                  tabPanel("Mean Dist. per airline",
                           tableOutput("mean_distance_per_airline")),
                  tabPanel("Total Dist. per airline",
                           tableOutput("total_distance_per_airline")),
                  tabPanel("Mean Dep. delay per airline",
                           tableOutput("average_depdelay_per_airline")),
                  tabPanel("Mean Arr. delay per airline",
                           tableOutput("average_arrdelay_per_airline"))
      )),
      #conditionalPanel("input.radio == 2",textInput("Oui","oui"))
    
      #if we choose per Departure airport
      conditionalPanel("input.radio == 2",
                       tabsetPanel(type = "tabs",
                                   
                                   tabPanel("Tot. flights per dep. airport",
                                            tableOutput("flights_per_dep")),
                                   tabPanel("Tot.Delayed flights per dep. airport",
                                            tableOutput("delayed_flights_per_dep")),
                                   tabPanel("Mean Time per dep. airport",
                                            tableOutput("mean_time_per_dep")),
                                   tabPanel("Mean Dist. per dep. airport",
                                            tableOutput("mean_distance_per_dep")),
                                   tabPanel("Total Dist. per dep. airport",
                                            tableOutput("total_distance_per_dep")),
                                   tabPanel("Mean Dep. delay per dep. airport",
                                            tableOutput("average_depdelay_per_dep")),
                                   tabPanel("Mean Arr. delay per dep. airport",
                                            tableOutput("average_arrdelay_per_dep"))
                       ))
      
      #plotOutput("petdriPlot",click = "plot_click")
    ),
    tabPanel("SNCF trains dashboard",
             
             radioButtons("radiosncf", label = h3("Radio buttons"),
                          choices = list("Per year" = 1, "Per departure station" = 2)),
             conditionalPanel("input.radiosncf==1",
                              selectInput("year_choice", "Year:",
                                                              c("2015" = 2015,
                                                                "2016" = 2016,
                                                                "2017" = 2017,
                                                                "2018" = 2018)),
                              textOutput("value1"),
                              textOutput("value2"),
                              textOutput("value3"),
                              textOutput("value4"),
                              textOutput("value5"),
                              textOutput("value6"),
                              textOutput("value7"),
                              textOutput("value8"),
                              textOutput("value9"),
                              textOutput("value10"),
                              
                              textOutput("value11"),
                              selectInput("cause_choice", "Cause:",
                                          c("External cause" = "delay_cause_external_cause",
                                            "Rail Infrastructure" = "delay_cause_rail_infrastructure",
                                            "Traffic management" = "delay_cause_traffic_management",
                                            "Rolling Stock" = "delay_cause_rolling_stock",
                                            "Station Management "= "delay_cause_station_management",
                                            "Travelers"="delay_cause_travelers"
                                            
                                          )),
                              textOutput("value12"),
                              ),
             conditionalPanel("input.radiosncf==2",
                              selectInput("dep_choice", "Departure Station:",
                                          unique(true_trains$departure_station)),
                              textOutput("value13"),
                              textOutput("value14"),
                              textOutput("value15"),
                              textOutput("value16"),
                              textOutput("value17"),
                              textOutput("value18"),
                              textOutput("value19"),
                              textOutput("value20"),
                              textOutput("value21"),
                              textOutput("value22"),
                              textOutput("value23"),
                              selectInput("cause_choice2", "Cause:",
                                          c("External cause" = "delay_cause_external_cause",
                                            "Rail Infrastructure" = "delay_cause_rail_infrastructure",
                                            "Traffic management" = "delay_cause_traffic_management",
                                            "Rolling Stock" = "delay_cause_rolling_stock",
                                            "Station Management "= "delay_cause_station_management",
                                            "Travelers"="delay_cause_travelers"
                                            
                                          )),
                              textOutput("value24"),
                              )
             
             
             
             
             )
   
  
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  
  output$value1 <- renderText(
    {
    year_choosen <-input$year_choice
    temp<-true_trains[true_trains$year==(as.integer(year_choosen)),]
    paste("1 : The total number of trains that have been carried out :",sum(temp$total_num_trips)-sum(temp$num_of_canceled_trains),"trains")
    }
  )
  output$value2 <- renderText(
    {
      year_choosen <-input$year_choice
      temp<-true_trains[true_trains$year==(as.integer(year_choosen)),]
      paste("2 : The total number of delayed trains at departure :",sum(temp$num_late_at_departure),"trains")
    }
  )
  output$value3 <- renderText(
    {
      year_choosen <-input$year_choice
      temp<-true_trains[true_trains$year==(as.integer(year_choosen)),]
      paste("2 : The total number of delayed trains at departure :",sum(temp$num_arriving_late),"trains")
    }
  )
  output$value4 <- renderText(
    {
      year_choosen <-input$year_choice
      temp<- temp<-true_trains[true_trains$year==(as.integer(year_choosen)),]
      tot_train_del= sum(temp$total_num_trips)
      #del_dep_train=nrow(true_trains[true_trains$year==(as.integer(year_choosen))&true_trains$num_late_at_departure>0,])
      del_dep_train = sum(temp$num_late_at_departure)
      paste("4 : The average number of delayed trains at departure :",tot_train_del/del_dep_train, "trains")
    }
  )
  output$value5 <- renderText(
    {
      year_choosen <-input$year_choice
      temp<- temp<-true_trains[true_trains$year==(as.integer(year_choosen)),]
      
      tot_train_del= sum(temp$total_num_trips)
      del_arr_train=sum(temp$num_arriving_late)
      paste("The average number of delayed trains at arrival :",tot_train_del/del_arr_train)
    }
  )
  
  
  output$value6 <- renderText(
    {
      year_choosen <-input$year_choice
      temp<-true_trains[true_trains$year==(as.integer(year_choosen)),]
      
      paste("The total average departure delay time of all trains :",sum(temp$avg_delay_all_departing), "minutes")
    }
  )
  output$value7 <- renderText(
    {
      year_choosen <-input$year_choice
      temp<-true_trains[true_trains$year==(as.integer(year_choosen)),]
      
      paste("The total average arrival delay time of all trains :",sum(temp$avg_delay_all_arriving), "minutes")
    }
  )
  output$value8 <- renderText(
    {
      year_choosen <-input$year_choice
      temp<-true_trains[true_trains$year==(as.integer(year_choosen))&(true_trains$num_late_at_departure>0|true_trains$num_arriving_late>0),]
      temp[["avg_delay_all_departing"]][is.na(temp[["avg_delay_all_departing"]])] <- 0
      paste("The average departure delay time of delayed trains :",sum(temp$avg_delay_all_departing)/nrow(temp), "minutes")
    }
  )
  
  output$value9 <- renderText(
    {
      year_choosen <-input$year_choice
      temp<-true_trains[true_trains$year==(as.integer(year_choosen))&(true_trains$num_late_at_departure>0|true_trains$num_arriving_late>0),]
      temp[["avg_delay_all_arriving"]][is.na(temp[["avg_delay_all_arriving"]])] <- 0
      paste("The average arrival delay time of delayed trains :",sum(temp$avg_delay_all_arriving)/nrow(temp),"minutes")
    }
  )
  output$value10 <- renderText(
    {
      year_choosen <-input$year_choice
      temp<-true_trains[true_trains$year==(as.integer(year_choosen)),]
      paste("The total number of cancelled trains :",sum(temp$num_of_canceled_trains),"trains")
    }
  )
  
  output$value11 <- renderText(
    {
      year_choosen <-input$year_choice
      temp<-true_trains[true_trains$year==(as.integer(year_choosen)),]
      canceled_train <-sum(temp$num_of_canceled_trains)
      total_train <-sum(temp$total_num_trips)
      paste("10 : The percentage (proportion) of cancelled trains :",(canceled_train/total_train)*100,"percent")
    }
  )
  output$value12 <- renderText(
    {
      year_choosen <-input$year_choice
      temp<-true_trains[true_trains$year==(as.integer(year_choosen)),]
      cause <- as.character(input$cause_choice)
      
      ouioui<-melt(temp,id.vars=c("year"),measure.vars=c("delay_cause_external_cause","delay_cause_rail_infrastructure","delay_cause_traffic_management",
                                                         "delay_cause_rolling_stock","delay_cause_station_management","delay_cause_travelers"))
      paste("11 : The percentage (proportion) of delay causes :",(nrow(ouioui[ouioui$variable==cause&ouioui$value>0,])/nrow(ouioui))*100,"percent")
      
    }
  )
  
  
  ########################################################################################################################################################
  
  output$value13 <- renderText(
    {
      dep_station <-as.character(input$dep_choice)
      temp<-true_trains[true_trains$departure_station==dep_station,]
      paste("1 : The total number of trains that have been carried out :",sum(temp$total_num_trips)-sum(temp$num_of_canceled_trains),"trains")
      
    }
  )
  output$value14 <- renderText(
    {
      dep_station <-as.character(input$dep_choice)
      temp<-true_trains[true_trains$departure_station==dep_station,]
      paste("2 : The total number of delayed trains at departure :",sum(temp$num_late_at_departure),"trains")
    }
  )
  output$value15 <- renderText(
    {
      dep_station <-as.character(input$dep_choice)
      temp<-true_trains[true_trains$departure_station==dep_station,]
      temp[["num_arriving_late"]][is.na(temp[["num_arriving_late"]])] <- 0
      paste("3 : The total number of delayed trains at arrival :",sum(temp$num_arriving_late),"trains")
    }
  )
  output$value16 <- renderText(
    {
      dep_station <-as.character(input$dep_choice)
      temp<-true_trains[true_trains$departure_station==dep_station,]
      tot_train_del= sum(temp$total_num_trips)
      #del_dep_train=nrow(true_trains[true_trains$year==(as.integer(year_choosen))&true_trains$num_late_at_departure>0,])
      
      del_dep_train = sum(temp$num_late_at_departure)
      paste("4 : The average number of delayed trains at departure :",tot_train_del/del_dep_train, "trains")
    }
  )
  output$value17 <- renderText(
    {
      dep_station <-as.character(input$dep_choice)
      temp<-true_trains[true_trains$departure_station==dep_station,]
      tot_train_del= sum(temp$total_num_trips)
      del_arr_train=sum(temp$num_arriving_late)
      paste("5 :The average number of delayed trains at arrival :",tot_train_del/del_arr_train,"trains")
    }
  )
  
  output$value18 <- renderText(
    {
      dep_station <-as.character(input$dep_choice)
      temp<-true_trains[true_trains$departure_station==dep_station,]
      
      paste("6 : The total average departure delay time of all trains :",sum(temp$avg_delay_all_departing), "minutes")
    }
  )
  output$value19 <- renderText(
    {
      dep_station <-as.character(input$dep_choice)
      
      temp<-true_trains[true_trains$departure_station==dep_station,]
      
      paste("7 : The total average arrival delay time of all trains :",sum(temp$avg_delay_all_arriving), "minutes")
      
    }
  )
  output$value20 <- renderText(
    {
      dep_station <- as.character(input$dep_choice)
      temp<-true_trains[true_trains$departure_station==dep_station,]
      temp[["avg_delay_all_departing"]][is.na(temp[["avg_delay_all_departing"]])] <- 0
      paste("8 : The average departure delay time of delayed trains :",sum(temp$avg_delay_all_departing)/nrow(temp), "minutes")
    }
  )
  
  output$value21 <- renderText(
    {
      dep_station <- as.character(input$dep_choice)
      temp<-true_trains[true_trains$departure_station==dep_station,]
      temp[["avg_delay_all_arriving"]][is.na(temp[["avg_delay_all_arriving"]])] <- 0
      paste("9 : The average arrival delay time of delayed trains :",sum(temp$avg_delay_all_arriving)/nrow(temp),"minutes")
    }
  )
  output$value22 <- renderText(
    {
      dep_station <- as.character(input$dep_choice)
      temp<-true_trains[true_trains$departure_station==dep_station,]
      paste("10 : The total number of cancelled trains :",sum(temp$num_of_canceled_trains),"trains")
    }
  )
  
  output$value23 <- renderText(
    {
      dep_station <- as.character(input$dep_choice)
      temp<-true_trains[true_trains$departure_station==dep_station,]
      canceled_train <-sum(temp$num_of_canceled_trains)
      total_train <-sum(temp$total_num_trips)
      paste("11 : The percentage (proportion) of cancelled trains :",(canceled_train/total_train)*100,"percent")
    }
  )
  output$value24 <- renderText(
    {
      dep_station <- as.character(input$dep_choice)
      temp<-true_trains[true_trains$departure_station==dep_station,]
      
      cause <- as.character(input$cause_choice2)
      
      ouioui<-melt(temp,id.vars=c("year"),measure.vars=c("delay_cause_external_cause","delay_cause_rail_infrastructure","delay_cause_traffic_management",
                                                         "delay_cause_rolling_stock","delay_cause_station_management","delay_cause_travelers"))
      
      paste("12 : The percentage (proportion) of delay causes :",(nrow(ouioui[ouioui$variable==cause&ouioui$value>0,])/nrow(ouioui))*100,"percent")
      
    }
  )
  ########################################################
  ########################################################
  output$mymap <- renderLeaflet({
    
    leaflet(data = ap_coord) %>% addTiles() %>%
    addMarkers(~LONGITUDE, ~LATITUDE)
    
  })
  

#################################################
  output$flights_per_airline <- renderTable(
    
    {
      #The total number of flights per airports
      result=data.frame(table(flights$AIRLINE))

    }
  )
  output$delayed_flights_per_airline <- renderTable(
    {
      #The total number of flights per airports
      df <- flights[flights$DEPARTURE_DELAY>0 |flights$ARRIVAL_DELAY>0,]
      result <- data.frame(table(df$AIRLINE))
    }
  )
  
  output$mean_time_per_airline <- renderTable(
    {
      #The total number of flights per airports
      aggregate(flights$ELAPSED_TIME, list(flights$AIRLINE), mean)
    }
  )
  
  output$mean_distance_per_airline <- renderTable(
    {
      #The total number of flights per airports
      aggregate(list("Mean dist. in km" =flights$DISTANCE), list(flights$AIRLINE), mean)
    }
  )
  
  output$total_distance_per_airline <- renderTable(
    {
      #The total number of flights per airports
      aggregate(list("Total dist. in km" =flights$DISTANCE), list(flights$AIRLINE), sum)
    }
  )
  
  output$average_depdelay_per_airline <- renderTable(
    {
      #The total number of flights per airports
      
      aggregate(list("Mean dep. delay " =flights$DEPARTURE_DELAY), list(flights$AIRLINE), mean)
    }
  )
  
  output$average_arrdelay_per_airline <- renderTable(
    {
      #The total number of flights per airports
      aggregate(list("Mean arr. delay " =flights$ARRIVAL_DELAY), list(flights$AIRLINE), mean)
    }
  )
###############################################################
  output$flights_per_dep <- renderTable(
    
    {
      #The total number of flights per airports
      result=data.frame(table(flights$ORIGIN_AIRPORT))
      
    }
  )
  output$delayed_flights_per_dep <- renderTable(
    {
      #The total number of delayed flights per airports
      df <- flights[flights$DEPARTURE_DELAY>0 |flights$ARRIVAL_DELAY>0,]
      result <- data.frame(table(df$ORIGIN_AIRPORT))
    }
  )
  
  output$mean_time_per_dep <- renderTable(
    {
      #The total number of flights per airports
      aggregate(flights$ELAPSED_TIME, list(flights$ORIGIN_AIRPORT), mean)
    }
  )
  
  output$mean_distance_per_dep <- renderTable(
    {
      #The total number of flights per airports
      aggregate(list("Mean dist. in km" =flights$DISTANCE), list(flights$ORIGIN_AIRPORT), mean)
    }
  )
  
  output$total_distance_per_dep <- renderTable(
    {
      #The total number of flights per airports
      aggregate(list("Total dist. in km" =flights$DISTANCE), list(flights$ORIGIN_AIRPORT), sum)
    }
  )
  
  output$average_depdelay_per_dep <- renderTable(
    {
      #The total number of flights per airports
      aggregate(list("Mean dep. delay " =flights$DEPARTURE_DELAY), list(flights$ORIGIN_AIRPORT), mean)
    }
  )
  
  output$average_arrdelay_per_dep <- renderTable(
    {
      #The total number of flights per airports
      aggregate(list("Mean arr. delay " =flights$ARRIVAL_DELAY), list(flights$ORIGIN_AIRPORT), mean)
    }
  )
}

# Run the application 
shinyApp(ui = ui, server = server)
