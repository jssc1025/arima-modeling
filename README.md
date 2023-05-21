# ARIMA Modeling Application

This project is an ARIMA Modeling Application implemented in R using the Shiny framework. The application allows users to input a stock ticker symbol and generates ARIMA models to forecast future stock prices. It provides visualizations of forecasted stock prices, model diagnostics, and summary statistics.

## Methodology

The ARIMA (Autoregressive Integrated Moving Average) models are fitted to historical stock price data using the "quantmod" and "forecast" packages. These models capture the underlying patterns and trends in the stock prices, enabling users to make informed predictions about future price movements. The application utilizes automatic model selection and generates forecasts based on the selected ARIMA model.

### ARIMA Models

- **AR (Autoregressive)**: The AR component models the dependency of the current observation on past observations in a linear regression fashion.
- **MA (Moving Average)**: The MA component models the dependency of the current observation on past error terms or residuals.
- **I (Integrated)**: The I component deals with differencing the time series to achieve stationarity, which is necessary for ARIMA modeling.

# Features

The ARIMA Modeling Application provides the following features:

- **Stock Selection**: Users can input a stock ticker symbol to fetch historical stock price data.
- **Run ARIMA Model**: Users can run ARIMA models on the selected stock data to generate forecasted stock prices.
- **Forecast Plot**: The application visualizes the forecasted stock prices using a line plot, allowing users to observe the predicted future price movements.
- **Forecast Table**: Users can view a table of the forecasted stock prices, providing a detailed breakdown of the predicted values over time.
- **Residuals Plot**: The application generates a plot of the residuals of the ARIMA model, allowing users to assess the goodness of fit and identify any remaining patterns or anomalies.
- **ACF Plot**: The application plots the autocorrelation function (ACF) of the residuals, providing insights into the presence of any remaining autocorrelation in the model.
- **PACF Plot**: The application plots the partial autocorrelation function (PACF) of the residuals, helping users identify the significant lag values for the AR and MA components of the ARIMA model.
- **Model Summary**: Users can access the summary statistics of the ARIMA model, including the Akaike Information Criterion (AIC) and Bayesian Information Criterion (BIC), which indicate the goodness of fit and the complexity of the model.

# Future Work

The application can be enhanced with additional features, such as:

- Allowing users to select different time periods for historical data, providing flexibility in analyzing specific time ranges.
- Providing more customization options for the forecasted stock price plot, such as adjusting the color scheme, line style, or adding confidence intervals.
- Incorporating other time series models, such as SARIMA (Seasonal ARIMA) or exponential smoothing methods like Holt-Winters, for comparison and ensemble forecasting, allowing users to explore alternative modeling approaches.


# Disclaimer

This application is for informational purposes only and does not constitute financial advice. The accuracy and reliability of the stock price forecasts are subject to various factors and should not be solely relied upon for investment decisions.

# Contact Information

For any questions or feedback, please contact:

- Seung Soo (Joseph) Chae
- Email: jssc1025@gmail.com
- GitHub: [jssc1025](https://github.com/jssc1025)
