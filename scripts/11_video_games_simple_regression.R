# ============================================================
# Script 11: Simple Linear Regression
# Dataset: Video Game Sales
# Course: PhD Multiple Regression / Advanced Stats
# ============================================================
# Topics Covered:
#   - The lm() function for regression
#   - Interpreting coefficients (intercept, slope)
#   - R-squared and model fit
#   - Residual plots
#   - Plotting the regression line
# ============================================================

# --- Step 1: Load the Data ---
games <- read.csv("11_video_game_sales.csv")

# --- Step 2: Overview ---
str(games)
head(games)

# --- Step 3: Research Question ---
# Does metacritic score predict units sold?

# Quick look at the relationship
plot(games$metacritic_score, games$units_sold_millions,
     main = "Metacritic Score vs. Units Sold",
     xlab = "Metacritic Score",
     ylab = "Units Sold (Millions)",
     pch = 19,
     col = rgb(0, 0, 0, 0.3))

# --- Step 4: Fit a Simple Linear Regression ---
model1 <- lm(units_sold_millions ~ metacritic_score, data = games)

# View the results
summary(model1)

# Key output to interpret:
#   Coefficients:
#     (Intercept) = predicted Y when X = 0
#     metacritic_score = slope (change in Y for 1-unit change in X)
#   R-squared = proportion of variance in Y explained by X
#   F-statistic = overall model significance

# --- Step 5: Interpret the Coefficients ---
coef(model1)

# The slope tells us: for every 1-point increase in metacritic score,
# units sold change by [slope] millions

# 95% confidence intervals for the coefficients
confint(model1)

# --- Step 6: Plot with Regression Line ---
plot(games$metacritic_score, games$units_sold_millions,
     main = "Simple Regression: Metacritic -> Units Sold",
     xlab = "Metacritic Score",
     ylab = "Units Sold (Millions)",
     pch = 19,
     col = rgb(0, 0, 0, 0.3))
abline(model1, col = "red", lwd = 2)

# --- Step 7: Residual Diagnostics ---
# Base R diagnostic plots (2x2 grid)
par(mfrow = c(2, 2))
plot(model1)
par(mfrow = c(1, 1))

# What to look for:
#   Residuals vs Fitted: should be randomly scattered (no pattern)
#   Normal Q-Q: residuals should follow the diagonal line
#   Scale-Location: should show roughly equal spread
#   Residuals vs Leverage: identifies influential observations

# --- Step 8: Predicted Values ---
# Get predicted values for the dataset
games$predicted <- predict(model1)
games$residuals <- residuals(model1)

# Look at a few
head(games[, c("metacritic_score", "units_sold_millions",
               "predicted", "residuals")])

# --- Step 9: Another Predictor ---
# Does price predict units sold?
model2 <- lm(units_sold_millions ~ price_usd, data = games)
summary(model2)

# Compare R-squared values
# Which predictor explains more variance in units sold?

# ============================================================
# Practice on Your Own:
#   1. Does development_time_months predict metacritic_score?
#   2. Examine the residual plots for your model
#   3. Compare the R-squared for different single predictors
# ============================================================
