# ============================================================
# Script 20: Full Analysis Workflow (Capstone)
# Dataset: Zombie Apocalypse Survival
# Course: PhD Multiple Regression / Advanced Stats
# ============================================================
# Topics Covered:
#   - Complete analysis from start to finish
#   - Exploratory data analysis (EDA)
#   - Variable selection and model building
#   - Regression diagnostics
#   - Interpreting and reporting results
#   - This ties together everything from the course
# ============================================================

# --- Step 1: Load the Data ---
zombies <- read.csv("20_zombie_apocalypse_survival.csv")

# --- Step 2: Exploratory Data Analysis ---
str(zombies)
head(zombies)
summary(zombies)

# What are we predicting?
# days_survived = how long a person survived
hist(zombies$days_survived,
     main = "Distribution of Days Survived",
     xlab = "Days Survived",
     col = "tomato",
     breaks = 25)

# --- Step 3: Check Variable Types ---
# Categorical variables
table(zombies$shelter_type)
table(zombies$previous_occupation)

# Binary variables
table(zombies$medical_training)
table(zombies$bitten)

# Continuous variables
summary(zombies[, c("group_size", "weapons_count", "food_supply_days",
                     "water_supply_days", "fitness_level",
                     "zombie_kills", "morale_score")])

# --- Step 4: Bivariate Exploration ---
# Which variables relate to survival?

# Correlation with days_survived (numeric vars only)
numeric_vars <- zombies[, c("days_survived", "group_size", "weapons_count",
                             "food_supply_days", "water_supply_days",
                             "fitness_level", "zombie_kills",
                             "morale_score")]
round(cor(numeric_vars), 3)

# Group differences by shelter type
tapply(zombies$days_survived, zombies$shelter_type, mean)

# Medical training effect
tapply(zombies$days_survived, zombies$medical_training, mean)

# Visualize key relationships
par(mfrow = c(2, 2))
plot(zombies$fitness_level, zombies$days_survived,
     pch = 19, col = rgb(0,0,0,0.3),
     xlab = "Fitness Level", ylab = "Days Survived")
plot(zombies$morale_score, zombies$days_survived,
     pch = 19, col = rgb(0,0,0,0.3),
     xlab = "Morale Score", ylab = "Days Survived")
plot(zombies$food_supply_days, zombies$days_survived,
     pch = 19, col = rgb(0,0,0,0.3),
     xlab = "Food Supply (Days)", ylab = "Days Survived")
boxplot(days_survived ~ shelter_type, data = zombies,
        col = "lightblue", las = 2, cex.axis = 0.7,
        ylab = "Days Survived")
par(mfrow = c(1, 1))

# --- Step 5: Build the Model (Step by Step) ---
# Convert categorical variables
zombies$shelter_type <- factor(zombies$shelter_type)
zombies$previous_occupation <- factor(zombies$previous_occupation)

# Step 1: Physical preparedness
model1 <- lm(days_survived ~ fitness_level + weapons_count, data = zombies)
summary(model1)

# Step 2: Add resources
model2 <- lm(days_survived ~ fitness_level + weapons_count +
               food_supply_days + water_supply_days, data = zombies)
summary(model2)

# Step 3: Add social and psychological factors
model3 <- lm(days_survived ~ fitness_level + weapons_count +
               food_supply_days + water_supply_days +
               group_size + morale_score + medical_training,
             data = zombies)
summary(model3)

# Step 4: Full model with shelter type
model4 <- lm(days_survived ~ fitness_level + weapons_count +
               food_supply_days + water_supply_days +
               group_size + morale_score + medical_training +
               shelter_type, data = zombies)
summary(model4)

# --- Step 6: Compare Models ---
anova(model1, model2, model3, model4)

# Track R-squared
cat("R-squared progression:\n")
cat("  Model 1:", round(summary(model1)$r.squared, 4), "\n")
cat("  Model 2:", round(summary(model2)$r.squared, 4), "\n")
cat("  Model 3:", round(summary(model3)$r.squared, 4), "\n")
cat("  Model 4:", round(summary(model4)$r.squared, 4), "\n")

# AIC comparison
AIC(model1, model2, model3, model4)

# --- Step 7: Diagnostics on Best Model ---
par(mfrow = c(2, 2))
plot(model4)
par(mfrow = c(1, 1))

# Check multicollinearity
library(car)
vif(model4)

# Check normality of residuals
shapiro.test(residuals(model4))

# Influential observations
cooks_d <- cooks.distance(model4)
plot(cooks_d, pch = 19, main = "Cook's Distance",
     col = ifelse(cooks_d > 4/nrow(zombies), "red", "black"))
abline(h = 4/nrow(zombies), col = "red", lty = 2)

# --- Step 8: Standardized Coefficients ---
# Which predictors matter most?
zombies_z <- zombies
numeric_cols <- c("days_survived", "fitness_level", "weapons_count",
                  "food_supply_days", "water_supply_days",
                  "group_size", "morale_score")
zombies_z[numeric_cols] <- scale(zombies_z[numeric_cols])

model_z <- lm(days_survived ~ fitness_level + weapons_count +
                food_supply_days + water_supply_days +
                group_size + morale_score + medical_training +
                shelter_type, data = zombies_z)
summary(model_z)

# --- Step 9: Visualize Final Model Results ---
library(ggplot2)

# Coefficient plot
coefs <- summary(model4)$coefficients[-1, ]
coef_df <- data.frame(
  Variable = rownames(coefs),
  Estimate = coefs[, 1],
  SE = coefs[, 2],
  p = coefs[, 4]
)
coef_df$Significant <- ifelse(coef_df$p < 0.05, "Yes", "No")

ggplot(coef_df, aes(x = reorder(Variable, Estimate), y = Estimate,
                     color = Significant)) +
  geom_point(size = 3) +
  geom_errorbar(aes(ymin = Estimate - 1.96 * SE,
                     ymax = Estimate + 1.96 * SE), width = 0.2) +
  geom_hline(yintercept = 0, linetype = "dashed") +
  coord_flip() +
  labs(title = "Regression Coefficients: Predicting Survival",
       x = "", y = "Unstandardized Coefficient") +
  theme_minimal()

# ============================================================
# Congratulations! You have completed all 20 practice scripts.
#
# Practice on Your Own:
#   1. Try adding previous_occupation to the model
#   2. Run a logistic regression predicting bitten (0/1)
#   3. What is the single best predictor of zombie survival?
# ============================================================
