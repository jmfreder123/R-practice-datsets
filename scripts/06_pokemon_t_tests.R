# ============================================================
# Script 6: t-Tests and Group Comparisons
# Dataset: Pokemon Battle Stats
# Course: PhD Intro to Data Analysis
# ============================================================
# Topics Covered:
#   - Creating new computed variables
#   - One-sample t-test
#   - Independent samples t-test
#   - Interpreting t, df, p-value, confidence intervals
#   - Checking assumptions (normality)
# ============================================================

# --- Step 1: Load the Data ---
pokemon <- read.csv("06_pokemon_battle_stats.csv")

# --- Step 2: Overview ---
str(pokemon)
head(pokemon)
summary(pokemon)

# --- Step 3: Create a New Variable ---
# Offensive power = attack + sp_attack
pokemon$offense <- pokemon$attack + pokemon$sp_attack

# Defensive power = defense + sp_defense
pokemon$defense_total <- pokemon$defense + pokemon$sp_defense

summary(pokemon$offense)
summary(pokemon$defense_total)

# --- Step 4: One-Sample t-Test ---
# Is the average speed different from 100?
t.test(pokemon$speed, mu = 100)

# Interpretation:
#   t = test statistic
#   df = degrees of freedom
#   p-value = probability of this result if true mean = 100
#   95% CI = range of plausible values for the true mean

# --- Step 5: Independent Samples t-Test ---
# Do legendary Pokemon have higher base_stat_total than non-legendary?

# First, check the groups
table(pokemon$is_legendary)

# Look at the means
tapply(pokemon$base_stat_total, pokemon$is_legendary, mean)

# Run the t-test
t.test(base_stat_total ~ is_legendary, data = pokemon)

# Note: R uses Welch's t-test by default (does not assume equal variances)
# For the classic equal-variance version:
t.test(base_stat_total ~ is_legendary, data = pokemon, var.equal = TRUE)

# --- Step 6: Another Comparison ---
# Compare attack scores between Pokemon with and without a secondary type
pokemon$has_secondary <- ifelse(pokemon$secondary_type == "", "No", "Yes")
table(pokemon$has_secondary)

tapply(pokemon$attack, pokemon$has_secondary, mean)
t.test(attack ~ has_secondary, data = pokemon)

# --- Step 7: Checking Normality ---
# Histogram of speed
hist(pokemon$speed,
     main = "Distribution of Speed",
     xlab = "Speed",
     col = "gold",
     breaks = 20)

# Shapiro-Wilk test for normality
shapiro.test(pokemon$speed)

# Q-Q plot
qqnorm(pokemon$speed, main = "Q-Q Plot: Speed")
qqline(pokemon$speed, col = "red")

# --- Step 8: Visualize the Group Difference ---
boxplot(base_stat_total ~ is_legendary,
        data = pokemon,
        names = c("Not Legendary", "Legendary"),
        main = "Base Stat Total: Legendary vs. Non-Legendary",
        ylab = "Base Stat Total",
        col = c("lightblue", "gold"))

# ============================================================
# Practice on Your Own:
#   1. Is the mean hp significantly different from 80?
#   2. Compare defense between legendary and non-legendary
#   3. Create a histogram of base_stat_total
# ============================================================
