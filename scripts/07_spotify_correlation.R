# ============================================================
# Script 7: Correlation
# Dataset: Spotify Streaming
# Course: PhD Intro to Data Analysis
# ============================================================
# Topics Covered:
#   - Pearson correlation (cor, cor.test)
#   - Interpreting r, p-value, confidence interval
#   - Correlation matrices
#   - Scatterplots
#   - Understanding correlation vs. causation
# ============================================================

# --- Step 1: Load the Data ---
spotify <- read.csv("07_spotify_streaming.csv")

# --- Step 2: Overview ---
str(spotify)
head(spotify)

# --- Step 3: Simple Correlation ---
# Is there a relationship between danceability and streams?
cor(spotify$danceability, spotify$streams_millions)

# Full test with p-value and confidence interval
cor.test(spotify$danceability, spotify$streams_millions)

# Interpretation:
#   r = correlation coefficient (-1 to +1)
#   p-value = is this significantly different from 0?
#   95% CI = range of plausible values for the true correlation

# --- Step 4: More Correlations ---
# Energy and valence (positivity)
cor.test(spotify$energy, spotify$valence)

# BPM and danceability
cor.test(spotify$bpm, spotify$danceability)

# Duration and streams
cor.test(spotify$duration_seconds, spotify$streams_millions)

# --- Step 5: Correlation Matrix ---
# Select only numeric columns for the matrix
numeric_vars <- spotify[, c("streams_millions", "duration_seconds", "bpm",
                             "danceability", "energy", "valence",
                             "acousticness")]

# Full correlation matrix
cor_matrix <- cor(numeric_vars)
round(cor_matrix, 3)

# --- Step 6: Scatterplots ---
# Danceability vs. streams
plot(spotify$danceability, spotify$streams_millions,
     main = "Danceability vs. Streams",
     xlab = "Danceability",
     ylab = "Streams (Millions)",
     pch = 19,
     col = rgb(0.2, 0.4, 0.6, 0.4))

# Add a best-fit line
abline(lm(streams_millions ~ danceability, data = spotify),
       col = "red", lwd = 2)

# Energy vs. valence
plot(spotify$energy, spotify$valence,
     main = "Energy vs. Valence",
     xlab = "Energy",
     ylab = "Valence (Positivity)",
     pch = 19,
     col = rgb(0.6, 0.2, 0.4, 0.4))
abline(lm(valence ~ energy, data = spotify), col = "red", lwd = 2)

# --- Step 7: Scatterplot Matrix ---
# Quick look at all pairwise relationships
pairs(numeric_vars[, 1:5],
      main = "Scatterplot Matrix (First 5 Variables)",
      pch = 19,
      col = rgb(0, 0, 0, 0.2))

# --- Step 8: Important Reminder ---
# Correlation does NOT imply causation.
# Just because danceability and streams are correlated
# does NOT mean making a song more danceable causes more streams.

# ============================================================
# Practice on Your Own:
#   1. What is the correlation between acousticness and energy?
#   2. Which pair of variables has the strongest correlation?
#   3. Create a scatterplot of bpm vs. danceability
# ============================================================
