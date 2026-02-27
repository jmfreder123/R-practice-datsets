# ============================================================
# Script 14: Regression Assumptions and Diagnostics
# Dataset: Theme Park Rides
# Course: PhD Multiple Regression / Advanced Stats
# ============================================================
# Topics Covered:
#   - The four key regression assumptions
#   - Residual plots for checking assumptions
#   - Normality of residuals (Shapiro-Wilk, Q-Q plot)
#   - Homoscedasticity (constant variance)
#   - Outliers and influential cases (Cook's distance)
#   - Small-N considerations
# ============================================================

# --- Step 1: Load the Data ---
rides <- read.csv("14_theme_park_rides.csv")

# --- Step 2: Overview ---
str(rides)
head(rides)
dim(rides)  # Note: only 75 observations -- small sample!

# --- Step 3: Fit a Regression Model ---
# Predict guest satisfaction from speed, wait time, and thrill rating
model <- lm(guest_satisfaction ~ max_speed_mph + avg_wait_time_min +
              thrill_rating, data = rides)
summary(model)

# --- Step 4: The Four Assumptions ---
# 1. Linearity: relationship between X and Y is linear
# 2. Independence: observations are independent
# 3. Normality: residuals are normally distributed
# 4. Homoscedasticity: residuals have constant variance

# --- Step 5: Residual Plots ---
par(mfrow = c(2, 2))
plot(model)
par(mfrow = c(1, 1))

# Plot 1 - Residuals vs Fitted:
#   Look for: random scatter around 0, no curves or patterns
#   Problem: a curve suggests non-linearity

# Plot 2 - Normal Q-Q:
#   Look for: points following the diagonal line
#   Problem: deviation at the tails suggests non-normality

# Plot 3 - Scale-Location:
#   Look for: flat red line, evenly spread points
#   Problem: a funnel shape suggests heteroscedasticity

# Plot 4 - Residuals vs Leverage:
#   Look for: no points beyond Cook's distance lines
#   Problem: points outside the lines are influential

# --- Step 6: Formal Test of Normality ---
shapiro.test(residuals(model))

# If p > .05, residuals are approximately normal
# If p < .05, normality assumption may be violated

# Q-Q plot closeup
qqnorm(residuals(model), main = "Q-Q Plot of Residuals")
qqline(residuals(model), col = "red")

# Histogram of residuals
hist(residuals(model),
     main = "Histogram of Residuals",
     xlab = "Residuals",
     col = "lightblue",
     breaks = 15)

# --- Step 7: Checking for Outliers ---
# Cook's distance measures influence of each observation
cooks_d <- cooks.distance(model)

# Plot Cook's distance
plot(cooks_d,
     main = "Cook's Distance",
     ylab = "Cook's D",
     pch = 19,
     col = ifelse(cooks_d > 4 / nrow(rides), "red", "black"))
abline(h = 4 / nrow(rides), col = "red", lty = 2)

# Which observations are potentially influential?
influential <- which(cooks_d > 4 / nrow(rides))
influential
rides[influential, ]

# --- Step 8: Leverage ---
hat_values <- hatvalues(model)
plot(hat_values,
     main = "Leverage Values",
     ylab = "Hat Value",
     pch = 19)
abline(h = 2 * length(coef(model)) / nrow(rides), col = "red", lty = 2)

# --- Step 9: What to Do About Violations ---
# Small N (75) means:
#   - Less statistical power
#   - Outliers have more influence
#   - Harder to detect non-normality
#   - Wider confidence intervals

# Compare model with and without influential cases
rides_clean <- rides[-influential, ]
model_clean <- lm(guest_satisfaction ~ max_speed_mph + avg_wait_time_min +
                    thrill_rating, data = rides_clean)

summary(model)       # Original
summary(model_clean) # Without influential cases
# Do the conclusions change? That tells you how robust the results are.

# ============================================================
# Practice on Your Own:
#   1. Add height_ft and duration_seconds to the model
#   2. Check assumptions for the expanded model
#   3. Are there any new influential observations?
# ============================================================
