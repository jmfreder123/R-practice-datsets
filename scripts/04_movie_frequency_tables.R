# ============================================================
# Script 4: Frequency Tables and Cross-Tabulations
# Dataset: Movie Box Office
# Course: PhD Intro to Data Analysis
# ============================================================
# Topics Covered:
#   - One-way frequency tables with table()
#   - Proportions with prop.table()
#   - Two-way cross-tabulations
#   - Bar plots for categorical data
#   - Adding margins to tables
# ============================================================

# --- Step 1: Load the Data ---
movies <- read.csv("04_movie_box_office.csv")

# --- Step 2: Overview ---
str(movies)
head(movies)

# --- Step 3: One-Way Frequency Tables ---
# How many movies in each genre?
table(movies$genre)

# How many by MPAA rating?
table(movies$mpaa_rating)

# Save a table as an object
genre_counts <- table(movies$genre)
genre_counts

# Sort the table
sort(genre_counts, decreasing = TRUE)

# --- Step 4: Proportions ---
# Convert counts to proportions
prop.table(genre_counts)

# Round for cleaner output
round(prop.table(genre_counts), 3)

# Proportions for MPAA ratings
round(prop.table(table(movies$mpaa_rating)), 3)

# --- Step 5: Two-Way Cross-Tabulations ---
# Genre by MPAA rating
cross_tab <- table(movies$genre, movies$mpaa_rating)
cross_tab

# Row proportions (what proportion of each genre got each rating?)
round(prop.table(cross_tab, margin = 1), 3)

# Column proportions (within each rating, what genres appear?)
round(prop.table(cross_tab, margin = 2), 3)

# Add row and column totals
addmargins(cross_tab)

# --- Step 6: Sequel vs. Non-Sequel ---
# How many sequels?
table(movies$sequel)

# Mean domestic gross: sequel vs. original
tapply(movies$domestic_gross_millions, movies$sequel, mean)

# --- Step 7: Bar Plots ---
# Bar plot of genre counts
barplot(sort(table(movies$genre), decreasing = TRUE),
        main = "Movies by Genre",
        xlab = "Genre",
        ylab = "Count",
        col = "steelblue",
        las = 2,
        cex.names = 0.8)

# Grouped bar plot: genre by MPAA rating
barplot(table(movies$mpaa_rating, movies$genre),
        beside = TRUE,
        legend = TRUE,
        main = "MPAA Rating by Genre",
        xlab = "Genre",
        ylab = "Count",
        col = c("gold", "tomato", "skyblue", "gray"),
        las = 2,
        cex.names = 0.7,
        args.legend = list(x = "topright", cex = 0.8))

# --- Step 8: Histogram of a Continuous Variable ---
hist(movies$domestic_gross_millions,
     main = "Distribution of Domestic Gross",
     xlab = "Domestic Gross (Millions)",
     col = "lightcoral",
     breaks = 30)

# ============================================================
# Practice on Your Own:
#   1. Create a frequency table for release_month
#   2. What proportion of movies are rated R?
#   3. Make a cross-tab of sequel by mpaa_rating
# ============================================================
