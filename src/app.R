options(shiny.port = 8050, shiny.autoreload = TRUE)

library(shiny)
library(ggplot2)
library(dplyr)
library(plotly)
library(shinydashboard)
library(bslib)
library(bsicons)


# Load data
data_long <- read.csv("data/ebola_long.csv")
data_long$Date <- as.Date(data_long$Date)

data_short <- read.csv("data/ebola_short.csv")
data_short$Date <- as.Date(data_short$Date)


# Layout
ui <- fluidPage(
  theme = bslib::bs_theme(bootswatch = 'superhero'),
  
  fluidRow(
    titlePanel(("Ebola Explorer")),
    h6("Exploring the 2014-2016 Ebola Outbreak through cumulative cases, deaths, and case fatality rate")
    ),
  
  br(),
  
  fluidRow(column(3,
           selectInput(
             "country",
             "Select country:",
             choices = c(unique(data_long$Country)),
             selected = "Guinea"
           )
    ),
    column(9,
           sliderInput(
             'x_range',
             'Time period:',
             min = data_long$Date |> min(),
             max = data_long$Date |> max(),
             value = c(data_long$Date |> min(), data_long$Date |> max())
           )
    )
  ),
  br(),
  
  fluidRow(      
    column(8,
           h2("Cumulative Cases and Deaths"),
           h6("Totals including confirmed, probable, and suspected events"),
           plotlyOutput("plot_cases_deaths")
    ),
    column(4,
           h2("Country Specific Statistics"),
           value_box(
             title = "Case Fatality Rate",
             value = textOutput('country_cfr'),
             showcase = bs_icon("percent"),
             p("The proportion of people who die from Ebola among all individuals diagnosed with the disease.")
           ),
           value_box(
             title = "Mortality Rate",
             value = textOutput('mortality_rate'),
             showcase = bs_icon("percent"),
             p("The proportion of deaths in a population due to Ebola over this time period.")
           )
    )
    
  ),
  br(),
  
  
  fluidRow(
    column(6,
           h2("Cases Worldwide"),
           plot_ly(data_short, type='choropleth', locationmode = 'country names',
                   locations=~Country, z=~Cases, text=~Country, color=~Cases,
                   colorscale='Portland')
    ),
    column(6,
           h2("Deaths Worldwide"),
           plot_ly(data_short, type='choropleth', locationmode = 'country names',
                   locations=~Country, z=~Deaths, text=~Country, color=~Deaths,
                   colorscale='Portland')
    )
  ),
  br(),
  h6("Created by Merete Lutz"),
  h6("Last Updated: April 21, 2024"),
  tags$a("GitHub Repository", href = "https://github.ubc.ca/MDS-2023-24/DSCI_532_individual-assignment_merete")
)

# Server side callbacks/reactivity
server <- function(input, output, session) {
  
  filtered_long_data <- reactive({
    data_long |>
      filter(Country == input$country) |>
      filter(between(Date, input$x_range[1], input$x_range[2]))
    
  })
  
  filtered_short_data <- reactive({
    data_short |>
      filter(Country == input$country) |>
      filter(between(Date, input$x_range[1], input$x_range[2]))
    
  })
  
  output$plot_cases_deaths <- renderPlotly({
    return(
      ggplotly(
        ggplot(filtered_long_data(),
               aes(x = Date, y = Value, color = Statistic)) +
          geom_line(aes(color = Statistic)) +
          scale_color_manual(values = c("Cases" = "blue", "Deaths" = "red")) +
          labs(
            x = "Date",
            y = "Number of Cases or Deaths",
            color = ''
          )
      )
    )
  })
  
  output$country_cfr <- renderText({
    # Calculate CFR for country
    max_deaths <- max(filtered_short_data()$Deaths)
    max_cases <- max(filtered_short_data()$Cases)
    cfr <- round(max_deaths/max_cases*100, 1)
    cfr
  })
  
  output$mortality_rate <- renderText({
    # Calculate Mortality for country
    max_deaths <- max(filtered_short_data()$Deaths)
    
    if (input$country == 'Guinea') {
      pop <- 11930000
    } else if (input$country == 'United States of America') {
      pop <- 323100000
    } else if (input$country == 'Nigeria') {
      pop <- 188700000
    } else if (input$country == 'Liberia') {
      pop <- 4706000
    } else if (input$country == 'Sierra Leone') {
      pop <- 7494000
    } else if (input$country == 'Senegal') {
      pop <- 14750000
    } else if (input$country == 'Italy') {
      pop <- 60630000
    } else if (input$country == 'Spain') {
      pop <- 46480000
    } else if (input$country == 'United Kingdom') {
      pop <- 65610000
    } else {
      pop <- 18700000
    }
  
    mortality_rate <- round((max_deaths/pop*100),3)
    mortality_rate
  })

  
}



# Run the app/dashboard
shinyApp(ui, server)



