# ============================================================
# Script 18: Multicollinearity and VIF
# Dataset: Climate & City Data
# Course: PhD Multiple Regression / Advanced Stats
# ============================================================
# Topics Covered:
#   - What is multicollinearity and why it matters
#   - Detecting multicollinearity (correlations, VIF)
#   - Variance Inflation Factor (VIF) interpretation
#   - Consequences for regression coefficients
#   - Strategies for addressing multicollinearity
# ============================================================

# --- Step 1: Load the Data ---
cities <- read.csv("18_climate_city_data.csv")

# --- Step 2: Overview ---
str(cities)
head(cities)
summary(cities)

# --- Step 3: What Is Multicollinearity? ---
# When predictor variables are highly correlated with each other,
# it becomes difficult to isolate their individual effects.
# Coefficients become unstable and standard errors inflate.

# --- Step 4: Check Correlations Among Predictors ---
predictors <- cities[, c("population", "avg_temp_celsius",
                          "annual_rainfall_mm", "aqi_avg",
                          "green_space_pct", "public_transit_score",
                          "cost_of_living_index",
                          "co2_emissions_per_capita_tons",
                          "renewable_energy_pct")]

cor_matrix <- cor(predictors)
round(cor_matrix, 2)

# Look for correlations above |.80| between predictors

# --- Step 5: Fit a Regression Model ---
# Predict happiness index from city characteristics
model <- lm(happiness_index ~ population + avg_temp_celsius +
              annual_rainfall_mm + aqi_avg + green_space_pct +
              public_transit_score + cost_of_living_index +
              co2_emissions_per_capita_tons + renewable_energy_pct,
            data = cities)
summary(model)

# Note: some predictors might have large standard errors or
# unexpected sign flips -- a sign of multicollinearity

# --- Step 6: Variance Inflation Factor (VIF) ---
# install.packages("car")  # uncomment if needed
library(car)

vif(model)

# VIF interpretation:
#   VIF = 1: no multicollinearity
#   VIF > 5: moderate concern
#   VIF > 10: serious multicollinearity

# --- Step 7: What Happens with Multicollinearity ---
# Compare a model with correlated predictors to one without

# First: a smaller model without the redundant predictors
model_small <- lm(happiness_index ~ avg_temp_celsius + aqi_avg +
                    green_space_pct + public_transit_score,
                  data = cities)
summary(model_small)
vif(model_small)

# Compare coefficient stability
cat("Full model coefficients:\n")
round(coef(model), 4)
cat("\nReduced model coefficients:\n")
round(coef(model_small), 4)

# --- Step 8: Strategies for Addressing Multicollinearity ---
# 1. Remove highly correlated predictors
# 2. Combine correlated predictors into a composite/index
# 3. Use principal components regression
# 4. Center variables (helps with interaction terms)

# Example: Create a composite "environmental quality" index
cities$env_quality <- scale(cities$green_space_pct) +
                      scale(cities$renewable_energy_pct) -
                      scale(cities$co2_emissions_per_capita_tons) -
                      scale(cities$aqi_avg)

model_composite <- lm(happiness_index ~ avg_temp_celsius +
                        public_transit_score + cost_of_living_index +
                        env_quality, data = cities)
summary(model_composite)
vif(model_composite)

# --- Step 9: Visualize Predictor Correlations ---
# Heatmap-style visualization
library(ggplot2)

cor_df <- as.data.frame(as.table(cor_matrix))
names(cor_df) <- c("Var1", "Var2", "Correlation")

ggplot(cor_df, aes(x = Var1, y = Var2, fill = Correlation)) +
  geom_tile() +
  scale_fill_gradient2(low = "blue", mid = "white", high = "red",
                       midpoint = 0) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 7),
        axis.text.y = element_text(size = 7)) +
  labs(title = "Correlation Heatmap of City Predictors")

# ============================================================
# Practice on Your Own:
#   1. Which pair of predictors has the highest correlation?
#   2. Remove the variable with the highest VIF and refit
#   3. Does the model improve (compare Adj R-squared)?
# ============================================================
