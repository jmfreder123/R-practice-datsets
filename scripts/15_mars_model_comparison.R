# ============================================================
# Script 15: Hierarchical Regression and Model Comparison
# Dataset: Mars Colony Simulation
# Course: PhD Multiple Regression / Advanced Stats
# ============================================================
# Topics Covered:
#   - Building models in steps (hierarchical regression)
#   - Comparing nested models with anova()
#   - Change in R-squared
#   - AIC and BIC for model selection
#   - Interpreting incremental contributions
# ============================================================

# --- Step 1: Load the Data ---
mars <- read.csv("15_mars_colony_simulation.csv")

# --- Step 2: Overview ---
str(mars)
head(mars)
summary(mars)

# --- Step 3: Research Question ---
# What predicts mental health scores in Mars colonists?
# We will build models in steps to see what matters most.

# --- Step 4: Step 1 - Demographics ---
# Start with basic variables: years on Mars and exercise
model1 <- lm(mental_health_score ~ years_on_mars + exercise_hours_per_week,
             data = mars)
summary(model1)

# --- Step 5: Step 2 - Add Environmental Factors ---
model2 <- lm(mental_health_score ~ years_on_mars + exercise_hours_per_week +
               radiation_exposure_msv + water_recycling_efficiency,
             data = mars)
summary(model2)

# --- Step 6: Step 3 - Add Social/Work Factors ---
model3 <- lm(mental_health_score ~ years_on_mars + exercise_hours_per_week +
               radiation_exposure_msv + water_recycling_efficiency +
               food_production_kg_per_month +
               earth_communication_satisfaction,
             data = mars)
summary(model3)

# --- Step 7: Compare Nested Models ---
# anova() tests whether each step significantly improves the model
anova(model1, model2, model3)

# Interpretation:
#   If p < .05 for a model comparison, the added predictors
#   significantly improve prediction beyond the previous step.

# --- Step 8: Track R-Squared Across Steps ---
cat("Model 1 R-squared:", summary(model1)$r.squared, "\n")
cat("Model 2 R-squared:", summary(model2)$r.squared, "\n")
cat("Model 3 R-squared:", summary(model3)$r.squared, "\n")

cat("\nModel 1 Adj R-squared:", summary(model1)$adj.r.squared, "\n")
cat("Model 2 Adj R-squared:", summary(model2)$adj.r.squared, "\n")
cat("Model 3 Adj R-squared:", summary(model3)$adj.r.squared, "\n")

# Change in R-squared
cat("\nDelta R-sq (Step 1 -> 2):",
    summary(model2)$r.squared - summary(model1)$r.squared, "\n")
cat("Delta R-sq (Step 2 -> 3):",
    summary(model3)$r.squared - summary(model2)$r.squared, "\n")

# --- Step 9: AIC and BIC ---
# Lower values = better model (penalizes for complexity)
AIC(model1, model2, model3)
BIC(model1, model2, model3)

# AIC tends to favor more complex models
# BIC penalizes complexity more heavily

# --- Step 10: Include Habitat Type ---
mars$habitat_type <- factor(mars$habitat_type)

model4 <- lm(mental_health_score ~ years_on_mars + exercise_hours_per_week +
               radiation_exposure_msv + water_recycling_efficiency +
               food_production_kg_per_month +
               earth_communication_satisfaction + habitat_type,
             data = mars)
summary(model4)

# Does habitat type add anything?
anova(model3, model4)

# ============================================================
# Practice on Your Own:
#   1. Build your own hierarchy with different variable ordering
#   2. Does the order of entry change the final model?
#   3. Which single predictor has the largest effect on mental health?
# ============================================================
