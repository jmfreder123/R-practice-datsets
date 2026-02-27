# ============================================================
# Script 1: Introduction to R Basics
# Dataset: Star Wars Characters
# Course: PhD Intro to Data Analysis
# ============================================================
# Topics Covered:
#   - Loading CSV data into R
#   - Exploring data with str(), head(), summary()
#   - Basic descriptive statistics (mean, median, sd)
#   - Subsetting rows and columns
#   - The $ operator
# ============================================================

# --- Step 1: Load the Data ---
starwars <- read.csv("01_star_wars_characters.csv")

# --- Step 2: Get Oriented ---
# How many rows and columns?
dim(starwars)

# What does the data look like?
head(starwars)

# What are the variable names?
names(starwars)

# What types are the variables? (numeric, character, etc.)
str(starwars)

# --- Step 3: Quick Summary of Everything ---
summary(starwars)

# --- Step 4: Accessing Individual Variables ---
# Use the $ operator to pull out a single column
starwars$height_cm

# What is the mean height?
mean(starwars$height_cm)

# Median height?
median(starwars$height_cm)

# Standard deviation?
sd(starwars$height_cm)

# --- Step 5: A Few More Useful Functions ---
# Range
range(starwars$height_cm)

# How many observations?
length(starwars$height_cm)

# Count unique species
table(starwars$species)

# Count by affiliation
table(starwars$affiliation)

# --- Step 6: Subsetting Data ---
# Get only Rebel Alliance members
rebels <- starwars[starwars$affiliation == "Rebel Alliance", ]
dim(rebels)
head(rebels)

# What is the mean height of rebels?
mean(rebels$height_cm)

# Get characters taller than 180 cm
tall_characters <- starwars[starwars$height_cm > 180, ]
dim(tall_characters)

# --- Step 7: Basic Plotting ---
# A simple histogram of height
hist(starwars$height_cm,
     main = "Distribution of Character Heights",
     xlab = "Height (cm)",
     col = "lightblue")

# A simple boxplot of force sensitivity by affiliation
boxplot(force_sensitivity_score ~ affiliation,
        data = starwars,
        main = "Force Sensitivity by Affiliation",
        xlab = "Affiliation",
        ylab = "Force Sensitivity Score",
        col = "lightyellow")

# ============================================================
# Practice on Your Own:
#   1. What is the mean weight_kg for each species?
#   2. How many characters have won more than 5 lightsaber duels?
#   3. Create a histogram of midi_chlorian_count
# ============================================================
