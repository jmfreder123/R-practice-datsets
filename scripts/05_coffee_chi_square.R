# ============================================================
# Script 5: Chi-Square Test of Independence
# Dataset: Coffee Shop Sales
# Course: PhD Intro to Data Analysis
# ============================================================
# Topics Covered:
#   - Contingency tables for two categorical variables
#   - Chi-square test of independence
#   - Interpreting test output (X-squared, df, p-value)
#   - Expected vs. observed frequencies
#   - Visualizing with bar plots
# ============================================================

# --- Step 1: Load the Data ---
coffee <- read.csv("05_coffee_shop_sales.csv")

# --- Step 2: Overview ---
str(coffee)
head(coffee)

# Check the categorical variables
table(coffee$drink)
table(coffee$size)
table(coffee$day_of_week)
table(coffee$milk_type)

# --- Step 3: Research Question ---
# Is drink choice independent of milk type?
# In other words: do people who order certain drinks
# tend to choose certain milk types?

# --- Step 4: Build the Contingency Table ---
drink_milk <- table(coffee$drink, coffee$milk_type)
drink_milk

# Add margins so we can see totals
addmargins(drink_milk)

# --- Step 5: Run the Chi-Square Test ---
chi_result <- chisq.test(drink_milk)
chi_result

# Key output:
#   X-squared = the test statistic
#   df = degrees of freedom
#   p-value = probability under the null hypothesis

# --- Step 6: Dig Deeper ---
# What were the expected frequencies (if independent)?
chi_result$expected

# Compare observed vs. expected
chi_result$observed
round(chi_result$expected, 1)

# Residuals (how far off was each cell?)
round(chi_result$residuals, 2)

# --- Step 7: Another Example ---
# Is there an association between size and loyalty membership?
size_loyalty <- table(coffee$size, coffee$customer_loyalty_member)
size_loyalty

chisq.test(size_loyalty)

# --- Step 8: Visualize ---
# Stacked bar plot: drink by milk type
barplot(table(coffee$milk_type, coffee$drink),
        legend = TRUE,
        main = "Milk Type by Drink Ordered",
        xlab = "Drink",
        ylab = "Count",
        col = c("burlywood", "lightblue", "gray80", "lightyellow"),
        las = 2,
        cex.names = 0.7,
        args.legend = list(x = "topright", cex = 0.7))

# Side-by-side bar plot: size by loyalty member
barplot(table(coffee$customer_loyalty_member, coffee$size),
        beside = TRUE,
        legend = TRUE,
        main = "Drink Size by Loyalty Membership",
        xlab = "Size",
        ylab = "Count",
        col = c("tomato", "steelblue"),
        args.legend = list(x = "topright",
                           legend = c("Non-Member", "Member")))

# ============================================================
# Practice on Your Own:
#   1. Test whether day_of_week and drink are independent
#   2. What does the expected frequency table look like?
#   3. Which cells have the largest residuals?
# ============================================================
