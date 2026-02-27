# ============================================================
# Script 12: Multiple Regression
# Dataset: Airline Flights
# Course: PhD Multiple Regression / Advanced Stats
# ============================================================
# Topics Covered:
#   - Multiple regression with lm()
#   - Adding multiple predictors
#   - Interpreting partial regression coefficients
#   - R-squared vs. Adjusted R-squared
#   - Comparing models
# ============================================================

# --- Step 1: Load the Data ---
flights <- read.csv("12_airline_flights.csv")

# --- Step 2: Overview ---
str(flights)
head(flights)
summary(flights)

# --- Step 3: Research Question ---
# What factors predict arrival delay?

# --- Step 4: Start Simple ---
# Single predictor: departure delay -> arrival delay
model1 <- lm(arrival_delay_min ~ departure_delay_min, data = flights)
summary(model1)

# --- Step 5: Add More Predictors ---
# Multiple regression: add distance and ticket price
model2 <- lm(arrival_delay_min ~ departure_delay_min + distance_miles +
               ticket_price_usd, data = flights)
summary(model2)

# Interpretation of partial coefficients:
#   Each coefficient = the effect of that predictor
#   HOLDING ALL OTHER PREDICTORS CONSTANT
#   This is the key difference from simple regression

# --- Step 6: Compare Models ---
# R-squared vs. Adjusted R-squared
# R-squared always goes up when you add predictors
# Adjusted R-squared penalizes for extra predictors

# Model 1 R-squared
summary(model1)$r.squared
summary(model1)$adj.r.squared

# Model 2 R-squared
summary(model2)$r.squared
summary(model2)$adj.r.squared

# --- Step 7: Add Even More Predictors ---
model3 <- lm(arrival_delay_min ~ departure_delay_min + distance_miles +
               ticket_price_usd + passengers + month,
             data = flights)
summary(model3)

# Compare all three models
anova(model1, model2, model3)

# --- Step 8: Standardized Coefficients ---
# To compare the relative importance of predictors,
# standardize all variables (z-scores)
flights_z <- as.data.frame(scale(flights[, c("arrival_delay_min",
                                              "departure_delay_min",
                                              "distance_miles",
                                              "ticket_price_usd",
                                              "passengers")]))

model_z <- lm(arrival_delay_min ~ departure_delay_min + distance_miles +
                ticket_price_usd + passengers, data = flights_z)
summary(model_z)

# Now the coefficients are standardized betas
# Larger absolute value = stronger predictor

# --- Step 9: Residual Diagnostics ---
par(mfrow = c(2, 2))
plot(model2)
par(mfrow = c(1, 1))

# ============================================================
# Practice on Your Own:
#   1. Add weather_delay to model3. Does it improve the model?
#   2. What is the strongest predictor of arrival delay?
#   3. Check the residual plots -- any concerns?
# ============================================================
