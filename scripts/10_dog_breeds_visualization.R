# ============================================================
# Script 10: Data Visualization with Base R and ggplot2
# Dataset: Dog Breeds
# Course: PhD Intro to Data Analysis
# ============================================================
# Topics Covered:
#   - Base R plots (hist, plot, boxplot, barplot)
#   - Introduction to ggplot2
#   - Building plots layer by layer
#   - Customizing colors, labels, and themes
#   - Saving plots
# ============================================================

# --- Step 1: Load the Data ---
dogs <- read.csv("10_dog_breeds.csv")

# --- Step 2: Overview ---
str(dogs)
head(dogs)
table(dogs$akc_group)

# --- Step 3: Base R Plots (Review) ---
# Histogram
hist(dogs$avg_weight_lbs,
     main = "Distribution of Dog Breed Weights",
     xlab = "Average Weight (lbs)",
     col = "tan",
     breaks = 20)

# Scatterplot
plot(dogs$avg_weight_lbs, dogs$life_expectancy_years,
     main = "Weight vs. Life Expectancy",
     xlab = "Weight (lbs)",
     ylab = "Life Expectancy (years)",
     pch = 19,
     col = "darkblue")

# Boxplot
boxplot(avg_weight_lbs ~ akc_group,
        data = dogs,
        main = "Weight by AKC Group",
        ylab = "Weight (lbs)",
        col = "lightblue",
        las = 2,
        cex.axis = 0.7)

# --- Step 4: Introduction to ggplot2 ---
# Install if needed (uncomment the line below):
# install.packages("ggplot2")
library(ggplot2)

# ggplot2 works in layers:
#   1. ggplot() = set up the data and aesthetic mappings
#   2. geom_*() = add the geometry (points, bars, etc.)
#   3. labs()   = add labels
#   4. theme_*() = change the overall look

# --- Step 5: ggplot2 Histogram ---
ggplot(dogs, aes(x = avg_weight_lbs)) +
  geom_histogram(bins = 20, fill = "steelblue", color = "white") +
  labs(title = "Distribution of Dog Breed Weights",
       x = "Average Weight (lbs)",
       y = "Count") +
  theme_minimal()

# --- Step 6: ggplot2 Scatterplot ---
ggplot(dogs, aes(x = avg_weight_lbs, y = life_expectancy_years)) +
  geom_point(color = "darkblue", alpha = 0.6) +
  geom_smooth(method = "lm", color = "red", se = TRUE) +
  labs(title = "Weight vs. Life Expectancy",
       x = "Average Weight (lbs)",
       y = "Life Expectancy (years)") +
  theme_minimal()

# --- Step 7: ggplot2 Boxplot ---
ggplot(dogs, aes(x = akc_group, y = avg_weight_lbs, fill = akc_group)) +
  geom_boxplot() +
  labs(title = "Weight by AKC Group",
       x = "AKC Group",
       y = "Average Weight (lbs)") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        legend.position = "none")

# --- Step 8: ggplot2 Bar Chart ---
ggplot(dogs, aes(x = akc_group)) +
  geom_bar(fill = "coral") +
  labs(title = "Number of Breeds by AKC Group",
       x = "AKC Group",
       y = "Count") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# --- Step 9: Color by a Third Variable ---
ggplot(dogs, aes(x = avg_weight_lbs, y = life_expectancy_years,
                 color = factor(hypoallergenic))) +
  geom_point(alpha = 0.7, size = 2) +
  scale_color_manual(values = c("tomato", "steelblue"),
                     labels = c("No", "Yes"),
                     name = "Hypoallergenic") +
  labs(title = "Weight vs. Life Expectancy by Hypoallergenic Status",
       x = "Weight (lbs)",
       y = "Life Expectancy (years)") +
  theme_minimal()

# --- Step 10: Saving a Plot ---
# Save the last plot to a file
ggsave("dog_breeds_scatterplot.png", width = 8, height = 5)

# ============================================================
# Practice on Your Own:
#   1. Create a ggplot histogram of life_expectancy_years
#   2. Make a boxplot of intelligence_rank by akc_group
#   3. Try a scatterplot of avg_height_inches vs avg_weight_lbs,
#      colored by akc_group
# ============================================================
