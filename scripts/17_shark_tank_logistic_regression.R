# ============================================================
# Script 17: Logistic Regression
# Dataset: Shark Tank Pitches
# Course: PhD Multiple Regression / Advanced Stats
# ============================================================
# Topics Covered:
#   - When to use logistic regression (binary outcome)
#   - glm() with family = binomial
#   - Interpreting log-odds coefficients
#   - Converting to odds ratios
#   - Model fit and classification
# ============================================================

# --- Step 1: Load the Data ---
shark <- read.csv("17_shark_tank_pitches.csv")

# --- Step 2: Overview ---
str(shark)
head(shark)

# Our outcome: got_deal (0 = no deal, 1 = got a deal)
table(shark$got_deal)
prop.table(table(shark$got_deal))

# --- Step 3: Why Not Regular Regression? ---
# Linear regression can predict values outside 0-1
# Logistic regression keeps predictions between 0 and 1
# It models the LOG-ODDS of the outcome

# --- Step 4: Simple Logistic Regression ---
# Does revenue predict whether they got a deal?
model1 <- glm(got_deal ~ revenue_prior_year_usd, data = shark,
              family = binomial)
summary(model1)

# Interpretation:
#   The coefficient is in LOG-ODDS
#   Positive = higher X increases probability of Y = 1
#   Negative = higher X decreases probability of Y = 1

# --- Step 5: Odds Ratios ---
# Exponentiate coefficients to get odds ratios
exp(coef(model1))

# Odds ratio interpretation:
#   OR > 1: higher odds of getting a deal
#   OR < 1: lower odds of getting a deal
#   OR = 1: no effect

# 95% CI for odds ratios
exp(confint(model1))

# --- Step 6: Multiple Logistic Regression ---
model2 <- glm(got_deal ~ revenue_prior_year_usd + equity_offered_pct +
                ask_amount_usd + years_in_business,
              data = shark, family = binomial)
summary(model2)

# Odds ratios for all predictors
round(exp(coef(model2)), 4)
round(exp(confint(model2)), 4)

# --- Step 7: Adding a Categorical Predictor ---
shark$industry <- factor(shark$industry)
shark$patent_held <- factor(shark$patent_held)

model3 <- glm(got_deal ~ revenue_prior_year_usd + equity_offered_pct +
                ask_amount_usd + patent_held + industry,
              data = shark, family = binomial)
summary(model3)

# --- Step 8: Model Fit ---
# Null deviance vs. Residual deviance
# Bigger drop = better model

# Pseudo R-squared (McFadden's)
null_deviance <- model2$null.deviance
residual_deviance <- model2$deviance
pseudo_r2 <- 1 - (residual_deviance / null_deviance)
cat("McFadden's Pseudo R-squared:", pseudo_r2, "\n")

# AIC for model comparison (lower = better)
AIC(model1, model2, model3)

# --- Step 9: Predicted Probabilities ---
shark$predicted_prob <- predict(model2, type = "response")

# Look at some predictions
head(shark[, c("got_deal", "predicted_prob", "revenue_prior_year_usd",
               "ask_amount_usd")])

# Classify: if predicted prob > 0.5, predict "deal"
shark$predicted_deal <- ifelse(shark$predicted_prob > 0.5, 1, 0)

# Confusion matrix
table(Predicted = shark$predicted_deal, Actual = shark$got_deal)

# Accuracy
mean(shark$predicted_deal == shark$got_deal)

# ============================================================
# Practice on Your Own:
#   1. Does entrepreneur_age predict getting a deal?
#   2. What is the odds ratio for num_sharks_interested?
#   3. What accuracy does your best model achieve?
# ============================================================
