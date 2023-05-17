library(shiny)
library(quantmod)
library(forecast)
library(ggplot2)
library(shinythemes)

# Define UI
ui <- fluidPage(
  theme = shinytheme("flatly"),
  
  titlePanel("ARIMA Modeling Application"),
  
  sidebarLayout(
    sidebarPanel(
      h4("Stock Selection"),
      textInput("tickerInput", "Stock Ticker Symbol:", "AAPL"),
      actionButton("runButton", "Run ARIMA Model", class = "btn-primary mt-2")
    ),
    
    mainPanel(
      h3("ARIMA Model Results"),
      hr(),
      
      tabsetPanel(
        type = "tabs",
        id = "tabs",
        
        # Forecast Plot Tab
        tabPanel(
          title = "Forecast Plot",
          fluidRow(
            column(
              width = 12,
              plotOutput("forecastPlot1", width = "100%", height = "300px")
            )
          )
        ),
        
        # Forecast Table Tab
        tabPanel(
          title = "Forecast Table",
          fluidRow(
            column(
              width = 12,
              tableOutput("forecastTable1")
            )
          )
        ),
        
        # Residuals Plot Tab
        tabPanel(
          title = "Residuals Plot",
          fluidRow(
            column(
              width = 12,
              plotOutput("residualsPlot", width = "100%", height = "300px")
            )
          )
        ),
        
        # ACF Plot Tab
        tabPanel(
          title = "ACF Plot",
          fluidRow(
            column(
              width = 12,
              plotOutput("acfPlot", width = "100%", height = "300px")
            )
          )
        ),
        
        # PACF Plot Tab
        tabPanel(
          title = "PACF Plot",
          fluidRow(
            column(
              width = 12,
              plotOutput("pacfPlot", width = "100%", height = "300px")
            )
          )
        ),
        # Model Summary Tab
        tabPanel(
          title = "Model Summary",
          fluidRow(
            column(
              width = 12,
              verbatimTextOutput("modelSummary")  # Use verbatimTextOutput to preserve formatting
            )
          )
        ),
        
        # About Tab
        tabPanel(
          title = "About",
          fluidRow(
            column(
              width = 12,
              uiOutput("aboutContent")            )
          )
        )
      )
    )
  )
)


# Define server
server <- function(input, output) {
  data <- reactiveValues(arimaModel = NULL, forecasts = NULL, ts_data = NULL)
  
  observeEvent(input$runButton, {
    ticker <- input$tickerInput
    
    # Download the stock data
    getSymbols(ticker, from = "2010-01-01", to = Sys.Date())
    
    # Extract the adjusted close price
    stock_data <- Ad(get(ticker))
    
    # Create a time series object
    data$ts_data <- ts(stock_data, frequency = 1)
    
    # Fit an ARIMA model
    data$arimaModel <- auto.arima(data$ts_data, seasonal = TRUE)
    
    # Generate forecasts
    data$forecasts <- forecast(data$arimaModel, h = 500)
  })
  
  output$modelSummary <- renderPrint({
    if (!is.null(data$arimaModel)) {
      summary_text <- capture.output(summary(data$arimaModel))
      aic <- data$arimaModel$aic
      bic <- data$arimaModel$bic
      grade <- switch(
        data$arimaModel$arma[2], 
        "0" = "A",
        "1" = "B",
        "2" = "C",
        "3" = "D",
        "4" = "E",
        "5" = "F",
        "Unknown"
      )
      grade_text <- paste("ARIMA Model Grade:", grade)
      summary_text <- c(summary_text, paste("AIC:", aic), paste("BIC:", bic), grade_text)
      
      # Return the summary text
      return(summary_text)
    }
  })
  
  output$forecastPlot1 <- renderPlot({
    if (!is.null(data$forecasts)) {
      autoplot(data$forecasts) + 
        ggtitle("Forecast Plot 1") +
        theme(plot.title = element_text(size = 16, face = "bold"))
    }
  })
  
  output$forecastTable1 <- renderTable({
    if (!is.null(data$forecasts)) {
      forecast_data <- data.frame(Time = 1:length(data$forecasts$mean), data$forecasts$mean)
      forecast_data
    }
  })
  
  output$residualsPlot <- renderPlot({
    if (!is.null(data$arimaModel)) {
      autoplot(data$arimaModel$residuals) + 
        ggtitle("Residuals Plot") +
        theme(plot.title = element_text(size = 16, face = "bold"))
    }
  })
  
  output$acfPlot <- renderPlot({
    if (!is.null(data$arimaModel)) {
      ggAcf(data$arimaModel$residuals) + 
        ggtitle("ACF of Residuals") +
        theme(plot.title = element_text(size = 16, face = "bold"))
    }
  })
  
  output$pacfPlot <- renderPlot({
    if (!is.null(data$arimaModel)) {
      ggPacf(data$arimaModel$residuals) + 
        ggtitle("PACF of Residuals") +
        theme(plot.title = element_text(size = 16, face = "bold"))
    }
  })
  output$aboutContent <- renderUI({
    includeMarkdown("about.Rmd")
  })
}

# Run the application
shinyApp(ui, server)
