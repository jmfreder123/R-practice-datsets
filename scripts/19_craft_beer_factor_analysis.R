# ============================================================
# Script 19: Exploratory Factor Analysis
# Dataset: Craft Beer
# Course: PhD Multiple Regression / Advanced Stats
# ============================================================
# Topics Covered:
#   - When and why to use factor analysis
#   - Checking factorability (KMO, Bartlett's test)
#   - Determining number of factors (scree plot, eigenvalues)
#   - Running factor analysis with factanal()
#   - Interpreting factor loadings and rotation
# ============================================================

# --- Step 1: Load the Data ---
beer <- read.csv("19_craft_beer.csv")

# --- Step 2: Overview ---
str(beer)
head(beer)
summary(beer)

# --- Step 3: Select Variables for Factor Analysis ---
# Factor analysis works with continuous/numeric variables
# We will use the beer characteristics
beer_vars <- beer[, c("abv", "ibu", "srm_color", "rating",
                       "num_ratings", "price_per_pint_usd")]

summary(beer_vars)

# --- Step 4: Check Correlations ---
# Factor analysis assumes variables are correlated
# (if they weren't correlated, there would be no underlying factors)
cor_matrix <- cor(beer_vars, use = "complete.obs")
round(cor_matrix, 3)

# --- Step 5: Bartlett's Test of Sphericity ---
# Tests whether the correlation matrix is significantly different
# from an identity matrix (i.e., are there correlations to explain?)

# install.packages("psych")  # uncomment if needed
library(psych)

cortest.bartlett(cor_matrix, n = nrow(beer_vars))

# If p < .05, the variables are sufficiently correlated for FA

# --- Step 6: KMO (Kaiser-Meyer-Olkin) ---
# Measures sampling adequacy for factor analysis
KMO(cor_matrix)

# Overall MSA should be > .50 (ideally > .60)
# Individual variable MSA shows which items are suitable

# --- Step 7: How Many Factors? ---
# Scree plot
eigen_values <- eigen(cor_matrix)$values
eigen_values

plot(eigen_values, type = "b",
     main = "Scree Plot",
     xlab = "Factor Number",
     ylab = "Eigenvalue",
     pch = 19)
abline(h = 1, col = "red", lty = 2)  # Kaiser criterion: eigenvalue > 1

# Parallel analysis (more sophisticated method)
fa.parallel(beer_vars, fm = "ml", fa = "fa")

# --- Step 8: Run Factor Analysis ---
# Extract factors (start with the number suggested by scree/parallel)
fa_result <- factanal(beer_vars, factors = 2, rotation = "varimax")
fa_result

# Key output:
#   Loadings: how strongly each variable loads on each factor
#   SS loadings: variance explained by each factor
#   Proportion Var: proportion of total variance explained
#   p-value: test of whether the number of factors is sufficient

# --- Step 9: Interpret the Factors ---
# Loadings > |.40| are typically considered meaningful
print(fa_result$loadings, cutoff = 0.4)

# What do the factors represent?
# Look at which variables load together and name the factor
# e.g., if abv and ibu load on Factor 1 -> "Beer Intensity"
# e.g., if rating and num_ratings load on Factor 2 -> "Popularity"

# --- Step 10: Try Different Rotations ---
# Varimax: factors are uncorrelated (orthogonal)
fa_varimax <- factanal(beer_vars, factors = 2, rotation = "varimax")
print(fa_varimax$loadings, cutoff = 0.4)

# Promax: factors are allowed to correlate (oblique)
fa_promax <- factanal(beer_vars, factors = 2, rotation = "promax")
print(fa_promax$loadings, cutoff = 0.4)

# --- Step 11: Using psych Package for More Detail ---
fa_psych <- fa(beer_vars, nfactors = 2, rotate = "varimax", fm = "ml")
fa_psych

# Visualization
fa.diagram(fa_psych, main = "Factor Analysis Diagram")

# ============================================================
# Practice on Your Own:
#   1. Try extracting 3 factors instead of 2 -- does it improve?
#   2. Which rotation gives the cleanest loading pattern?
#   3. Compute factor scores and add them to the dataset
#      Hint: fa_psych$scores
# ============================================================
