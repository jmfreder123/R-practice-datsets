# ============================================================
# Script 8: Boxplots and One-Way ANOVA Introduction
# Dataset: Superheroes Power Index
# Course: PhD Intro to Data Analysis
# ============================================================
# Topics Covered:
#   - Boxplots for comparing groups
#   - Interpreting boxplot components (median, IQR, whiskers)
#   - One-way ANOVA: comparing means across 3+ groups
#   - Interpreting the F-statistic and p-value
#   - When to use ANOVA vs. t-test
# ============================================================

# --- Step 1: Load the Data ---
heroes <- read.csv("08_superheroes_power_index.csv")

# --- Step 2: Overview ---
str(heroes)
head(heroes)

# What groups do we have?
table(heroes$universe)
table(heroes$alignment)

# --- Step 3: Descriptive Stats by Group ---
# Mean strength by universe
tapply(heroes$strength, heroes$universe, mean)

# Mean intelligence by alignment
tapply(heroes$intelligence, heroes$alignment, mean)

# More detailed summary
aggregate(cbind(strength, intelligence, speed) ~ universe,
          data = heroes, FUN = mean)

# --- Step 4: Boxplots ---
# Strength by universe
boxplot(strength ~ universe,
        data = heroes,
        main = "Strength by Universe",
        xlab = "Universe",
        ylab = "Strength",
        col = c("lightblue", "lightyellow"))

# Reading a boxplot:
#   - Bold line = median
#   - Box = interquartile range (IQR: 25th to 75th percentile)
#   - Whiskers = extend to min/max within 1.5 * IQR
#   - Dots beyond whiskers = outliers

# Intelligence by alignment
boxplot(intelligence ~ alignment,
        data = heroes,
        main = "Intelligence by Alignment",
        ylab = "Intelligence",
        col = c("tomato", "lightgreen", "gray80"))

# --- Step 5: One-Way ANOVA ---
# Research question: Does mean combat_skill differ by alignment?
# (Hero vs. Neutral vs. Villain)

# First, look at the group means
tapply(heroes$combat_skill, heroes$alignment, mean)

# Run the ANOVA
anova_result <- aov(combat_skill ~ alignment, data = heroes)
summary(anova_result)

# Interpretation:
#   F value = ratio of between-group variance to within-group variance
#   Pr(>F) = p-value
#   If p < .05, at least one group mean is significantly different

# --- Step 6: Another ANOVA ---
# Does speed differ by universe?
tapply(heroes$speed, heroes$universe, mean)

anova_speed <- aov(speed ~ universe, data = heroes)
summary(anova_speed)

# --- Step 7: ANOVA with Visualization ---
boxplot(combat_skill ~ alignment,
        data = heroes,
        main = "Combat Skill by Alignment (ANOVA)",
        ylab = "Combat Skill",
        col = c("tomato", "lightgreen", "gray80"))

# Add group means as points
group_means <- tapply(heroes$combat_skill, heroes$alignment, mean)
points(1:length(group_means), group_means, pch = 18, col = "blue", cex = 2)

# ============================================================
# Practice on Your Own:
#   1. Run an ANOVA comparing durability across alignment groups
#   2. Create a boxplot of intelligence by universe
#   3. Which variable shows the biggest difference across groups?
# ============================================================
