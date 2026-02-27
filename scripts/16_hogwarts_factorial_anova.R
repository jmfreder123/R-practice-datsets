# ============================================================
# Script 16: Factorial ANOVA and Interaction Effects
# Dataset: Hogwarts Student Records
# Course: PhD Multiple Regression / Advanced Stats
# ============================================================
# Topics Covered:
#   - Two-way (factorial) ANOVA
#   - Main effects and interaction effects
#   - Interpreting interaction plots
#   - Simple effects analysis
#   - Effect sizes (eta-squared, partial eta-squared)
# ============================================================

# --- Step 1: Load the Data ---
hogwarts <- read.csv("16_hogwarts_student_records.csv")

# --- Step 2: Overview ---
str(hogwarts)
head(hogwarts)

table(hogwarts$house)
table(hogwarts$blood_status)

# --- Step 3: Research Question ---
# Do potions grades differ by house and blood status?
# Is there an interaction between house and blood status?

# Convert to factors
hogwarts$house <- factor(hogwarts$house)
hogwarts$blood_status <- factor(hogwarts$blood_status)

# --- Step 4: Descriptive Statistics ---
# Cell means
aggregate(potions_grade ~ house + blood_status,
          data = hogwarts, FUN = mean)

# Marginal means (main effects)
tapply(hogwarts$potions_grade, hogwarts$house, mean)
tapply(hogwarts$potions_grade, hogwarts$blood_status, mean)

# --- Step 5: Two-Way ANOVA ---
anova_model <- aov(potions_grade ~ house * blood_status, data = hogwarts)
summary(anova_model)

# The * operator includes:
#   - Main effect of house
#   - Main effect of blood_status
#   - Interaction (house:blood_status)

# Interpretation:
#   Main effect of house: do houses differ (averaging across blood status)?
#   Main effect of blood_status: do blood statuses differ (averaging across houses)?
#   Interaction: does the effect of one factor depend on the level of the other?

# --- Step 6: Interaction Plot ---
interaction.plot(hogwarts$house, hogwarts$blood_status,
                 hogwarts$potions_grade,
                 main = "Interaction Plot: Potions Grade",
                 xlab = "House",
                 ylab = "Mean Potions Grade",
                 col = c("red", "blue", "darkgreen"),
                 lwd = 2,
                 legend = TRUE,
                 trace.label = "Blood Status")

# If lines are parallel: no interaction
# If lines cross or diverge: interaction present

# --- Step 7: Effect Sizes ---
# Eta-squared for each effect
anova_table <- summary(anova_model)[[1]]
ss_values <- anova_table[, "Sum Sq"]
ss_total <- sum(ss_values)

cat("Eta-squared:\n")
cat("  House:", ss_values[1] / ss_total, "\n")
cat("  Blood Status:", ss_values[2] / ss_total, "\n")
cat("  Interaction:", ss_values[3] / ss_total, "\n")
cat("  Residual:", ss_values[4] / ss_total, "\n")

# --- Step 8: Post-Hoc Comparisons ---
TukeyHSD(anova_model, which = "house")
TukeyHSD(anova_model, which = "blood_status")

# --- Step 9: Another Outcome Variable ---
# Does defense against dark arts differ by house and year?
hogwarts$year <- factor(hogwarts$year)

anova2 <- aov(defense_dark_arts_grade ~ house * year, data = hogwarts)
summary(anova2)

# --- Step 10: Visualize with ggplot2 ---
library(ggplot2)

ggplot(hogwarts, aes(x = house, y = potions_grade, fill = blood_status)) +
  geom_boxplot() +
  labs(title = "Potions Grades by House and Blood Status",
       x = "House",
       y = "Potions Grade",
       fill = "Blood Status") +
  theme_minimal()

# ============================================================
# Practice on Your Own:
#   1. Run a factorial ANOVA on charms_grade ~ house * blood_status
#   2. Create the interaction plot -- is there an interaction?
#   3. Calculate eta-squared for each effect
# ============================================================
