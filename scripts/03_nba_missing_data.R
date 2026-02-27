# ============================================================
# Script 3: Handling Missing Data
# Dataset: NBA Player Stats
# Course: PhD Intro to Data Analysis
# ============================================================
# Topics Covered:
#   - Identifying missing values (NA)
#   - is.na(), complete.cases()
#   - Using na.rm = TRUE in functions
#   - Counting and summarizing missingness
#   - Removing vs. keeping incomplete cases
# ============================================================

# --- Step 1: Load the Data ---
nba <- read.csv("03_nba_player_stats.csv")

# --- Step 2: First Look ---
str(nba)
head(nba)
summary(nba)

# Notice: draft_pick has NA values (undrafted players)

# --- Step 3: Finding Missing Data ---
# Check for NAs in draft_pick
is.na(nba$draft_pick)

# How many are missing?
sum(is.na(nba$draft_pick))

# What proportion is missing?
mean(is.na(nba$draft_pick))

# Check every column for missing values
colSums(is.na(nba))

# --- Step 4: What Happens When You Ignore NAs ---
# This will return NA!
mean(nba$draft_pick)

# Fix it with na.rm = TRUE
mean(nba$draft_pick, na.rm = TRUE)
median(nba$draft_pick, na.rm = TRUE)
sd(nba$draft_pick, na.rm = TRUE)

# --- Step 5: Working with Complete Cases ---
# Which rows have no missing values anywhere?
complete.cases(nba)

# How many complete cases?
sum(complete.cases(nba))

# Create a dataset with only complete cases
nba_complete <- nba[complete.cases(nba), ]
dim(nba)           # original
dim(nba_complete)  # after removing incomplete rows

# --- Step 6: Exploring the Data ---
# Descriptive stats for key variables
summary(nba$ppg)
summary(nba$salary_millions)

# Mean points per game by position
tapply(nba$ppg, nba$position, mean)

# --- Step 7: Quick Visualizations ---
# Histogram of points per game
hist(nba$ppg,
     main = "Points Per Game Distribution",
     xlab = "Points Per Game",
     col = "orange",
     breaks = 25)

# Boxplot of salary by position
boxplot(salary_millions ~ position,
        data = nba,
        main = "Salary by Position",
        xlab = "Position",
        ylab = "Salary (Millions)",
        col = "lightgreen",
        las = 2)

# Scatterplot: does age relate to points per game?
plot(nba$age, nba$ppg,
     main = "Age vs. Points Per Game",
     xlab = "Age",
     ylab = "PPG",
     pch = 19,
     col = "purple")

# ============================================================
# Practice on Your Own:
#   1. What is the mean salary for drafted vs. undrafted players?
#      Hint: create a new variable indicating drafted or not
#   2. What is the correlation between games_played and ppg?
#      (use cor() with use = "complete.obs")
#   3. Create a histogram of salary_millions
# ============================================================
