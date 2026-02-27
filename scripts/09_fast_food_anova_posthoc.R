# ============================================================
# Script 9: ANOVA and Post-Hoc Tests
# Dataset: Fast Food Nutrition
# Course: PhD Intro to Data Analysis
# ============================================================
# Topics Covered:
#   - One-way ANOVA (review)
#   - Post-hoc pairwise comparisons (TukeyHSD)
#   - Interpreting which groups differ
#   - Effect size (eta-squared)
#   - Visualizing group differences
# ============================================================

# --- Step 1: Load the Data ---
fastfood <- read.csv("09_fast_food_nutrition.csv")

# --- Step 2: Overview ---
str(fastfood)
head(fastfood)

table(fastfood$chain)
table(fastfood$category)

# --- Step 3: Research Question ---
# Do average calories differ across fast food chains?

# Group means
tapply(fastfood$calories, fastfood$chain, mean)

# Group standard deviations
tapply(fastfood$calories, fastfood$chain, sd)

# Group sizes
table(fastfood$chain)

# --- Step 4: Run the ANOVA ---
# Make sure chain is a factor
fastfood$chain <- factor(fastfood$chain)

anova_cal <- aov(calories ~ chain, data = fastfood)
summary(anova_cal)

# If p < .05, we know at least one chain differs
# But WHICH chains differ from which? We need post-hoc tests.

# --- Step 5: Tukey's HSD Post-Hoc Test ---
tukey_result <- TukeyHSD(anova_cal)
tukey_result

# Each row compares two chains:
#   diff = difference in means
#   lwr, upr = 95% confidence interval for the difference
#   p adj = adjusted p-value (corrected for multiple comparisons)

# Visualize the Tukey results
plot(tukey_result, las = 1, cex.axis = 0.6)

# --- Step 6: Effect Size (Eta-Squared) ---
# Eta-squared = SS_between / SS_total
# It tells you what proportion of variance is explained by group membership

anova_table <- summary(anova_cal)[[1]]
anova_table

ss_between <- anova_table["chain", "Sum Sq"]
ss_total <- sum(anova_table[, "Sum Sq"])
eta_sq <- ss_between / ss_total
eta_sq

# Rules of thumb: .01 = small, .06 = medium, .14 = large

# --- Step 7: Another ANOVA ---
# Do calories differ by food category?
tapply(fastfood$calories, fastfood$category, mean)

anova_cat <- aov(calories ~ category, data = fastfood)
summary(anova_cat)

TukeyHSD(anova_cat)

# --- Step 8: Visualization ---
# Boxplot of calories by chain
boxplot(calories ~ chain,
        data = fastfood,
        main = "Calories by Fast Food Chain",
        ylab = "Calories",
        col = "lightyellow",
        las = 2)

# Boxplot of calories by category
boxplot(calories ~ category,
        data = fastfood,
        main = "Calories by Food Category",
        ylab = "Calories",
        col = "lightblue",
        las = 2,
        cex.axis = 0.8)

# ============================================================
# Practice on Your Own:
#   1. Run an ANOVA on sodium_mg by chain
#   2. Which chains differ significantly on sodium?
#   3. Calculate eta-squared for the sodium ANOVA
# ============================================================
