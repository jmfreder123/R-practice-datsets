# ============================================================
# Script 2: Data Types and Summary Statistics
# Dataset: College Rankings
# Course: PhD Intro to Data Analysis
# ============================================================
# Topics Covered:
#   - Checking and converting data types
#   - Factor variables
#   - Summary statistics by group (tapply, aggregate)
#   - Basic histograms and scatterplots
# ============================================================

# --- Step 1: Load the Data ---
colleges <- read.csv("02_college_rankings.csv")

# --- Step 2: Examine the Structure ---
str(colleges)
head(colleges)

# --- Step 3: Understanding Data Types ---
# Check the class of individual variables
class(colleges$tuition_usd)        # numeric
class(colleges$institution_type)   # character
class(colleges$enrollment)         # integer or numeric

# R reads text as character by default
# Convert to factor when it represents categories
colleges$institution_type <- factor(colleges$institution_type)
colleges$region <- factor(colleges$region)

# Now check the levels
levels(colleges$institution_type)
levels(colleges$region)

# --- Step 4: Summary Statistics ---
# Overall summary
summary(colleges$tuition_usd)
summary(colleges$graduation_rate_6yr)

# Specific descriptive stats
mean(colleges$tuition_usd)
median(colleges$tuition_usd)
sd(colleges$tuition_usd)

# --- Step 5: Summary Statistics by Group ---
# Mean tuition by institution type
tapply(colleges$tuition_usd, colleges$institution_type, mean)

# Mean graduation rate by region
tapply(colleges$graduation_rate_6yr, colleges$region, mean)

# Using aggregate for a cleaner table
aggregate(tuition_usd ~ institution_type, data = colleges, FUN = mean)
aggregate(graduation_rate_6yr ~ region, data = colleges, FUN = mean)

# Multiple summaries at once
aggregate(cbind(tuition_usd, graduation_rate_6yr) ~ institution_type,
          data = colleges, FUN = mean)

# --- Step 6: Histograms ---
# Distribution of tuition
hist(colleges$tuition_usd,
     main = "Distribution of Tuition (USD)",
     xlab = "Tuition",
     col = "steelblue",
     breaks = 20)

# Distribution of acceptance rates
hist(colleges$acceptance_rate,
     main = "Acceptance Rates Across Colleges",
     xlab = "Acceptance Rate",
     col = "coral",
     breaks = 20)

# --- Step 7: Scatterplot ---
# Is there a relationship between tuition and graduation rate?
plot(colleges$tuition_usd, colleges$graduation_rate_6yr,
     main = "Tuition vs. Graduation Rate",
     xlab = "Tuition (USD)",
     ylab = "6-Year Graduation Rate",
     pch = 19,
     col = "darkblue")

# ============================================================
# Practice on Your Own:
#   1. What is the median SAT score by region?
#   2. Create a histogram of student_faculty_ratio
#   3. Make a scatterplot of acceptance_rate vs graduation_rate_6yr
# ============================================================
