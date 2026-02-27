# ============================================================
# Script 13: Dummy Coding and Categorical Predictors
# Dataset: World Cup Soccer
# Course: PhD Multiple Regression / Advanced Stats
# ============================================================
# Topics Covered:
#   - Including categorical predictors in regression
#   - How R creates dummy codes automatically
#   - Interpreting dummy-coded coefficients
#   - Changing the reference category
#   - Regression with mixed predictor types
# ============================================================

# --- Step 1: Load the Data ---
worldcup <- read.csv("13_world_cup_soccer.csv")

# --- Step 2: Overview ---
str(worldcup)
head(worldcup)

table(worldcup$confederation)
table(worldcup$position)

# --- Step 3: Categorical Predictors in Regression ---
# Convert to factor
worldcup$position <- factor(worldcup$position)
worldcup$confederation <- factor(worldcup$confederation)

levels(worldcup$position)
levels(worldcup$confederation)

# --- Step 4: Regression with a Categorical Predictor ---
# Does position predict goals scored?
model1 <- lm(goals ~ position, data = worldcup)
summary(model1)

# R automatically creates dummy variables:
#   The first level (alphabetically) is the REFERENCE category
#   Each coefficient = difference from the reference group
#   e.g., positionForward = mean difference between Forwards and Defenders

# Verify with group means
tapply(worldcup$goals, worldcup$position, mean)

# --- Step 5: Changing the Reference Category ---
# Set "Midfielder" as reference
worldcup$position <- relevel(worldcup$position, ref = "Midfielder")

model2 <- lm(goals ~ position, data = worldcup)
summary(model2)

# Now all comparisons are relative to Midfielders

# --- Step 6: Mixed Model (Continuous + Categorical) ---
# Predict goals from age, caps (experience), and position
model3 <- lm(goals ~ age + caps + position, data = worldcup)
summary(model3)

# Interpretation:
#   age coefficient = effect of age on goals, controlling for
#     caps and position
#   positionForward = how many more/fewer goals forwards score
#     compared to midfielders, controlling for age and caps

# --- Step 7: Multiple Categorical Predictors ---
model4 <- lm(goals ~ age + caps + position + confederation, data = worldcup)
summary(model4)

# Many coefficients now! Each dummy variable gets its own line.

# --- Step 8: Check How Many Dummies Were Created ---
# Number of dummies = number of levels - 1
nlevels(worldcup$position)       # levels
nlevels(worldcup$confederation)  # levels
# Total dummy variables = (levels_position - 1) + (levels_confed - 1)

# --- Step 9: Visualize ---
boxplot(goals ~ position,
        data = worldcup,
        main = "Goals by Position",
        ylab = "Goals",
        col = "lightgreen")

# Scatterplot with color by position
library(ggplot2)
ggplot(worldcup, aes(x = caps, y = goals, color = position)) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "Caps vs. Goals by Position",
       x = "Caps (Games Played)",
       y = "Goals") +
  theme_minimal()

# ============================================================
# Practice on Your Own:
#   1. Predict market_value_millions_eur from age, goals, and
#      confederation
#   2. Change the reference category for confederation
#   3. How many dummy variables does your full model have?
# ============================================================
