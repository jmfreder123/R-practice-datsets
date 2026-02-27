# 📊 Fun Teaching Datasets for Statistics & Data Science

A collection of 20 creative, simulated datasets designed for teaching introductory and intermediate statistics courses. Each dataset is available in **five formats**: CSV, Stata (.dta), SPSS (.sav), SAS Transport (.xpt), and Excel (.xlsx).

These datasets were built to make learning data analysis more engaging. Instead of dry, generic examples, students work with Star Wars characters, Hogwarts grades, zombie survival data, and more — while still encountering real-world statistical structures like skewed distributions, count data, proportions, and missing values.

---

## 📁 Repository Structure

```
├── csv/                 # R, Python, or general use
├── stata/               # Stata .dta files
├── spss/                # SPSS .sav files
├── sas/                 # SAS Transport .xpt files
├── xlsx/                # Microsoft Excel files
├── README.md
└── LICENSE
```

---

## 📋 Dataset Overview

| # | Dataset | N | Variables | Good For Teaching |
|---|---------|--:|:---------:|-------------------|
| 1 | Star Wars Characters | 87 | 9 | Descriptive stats, group comparisons |
| 2 | College Rankings | 250 | 12 | Multiple regression, correlation matrices |
| 3 | NBA Player Stats | 450 | 14 | Missing data, log transformations, prediction |
| 4 | Movie Box Office | 500 | 12 | Regression, interaction effects, dummy variables |
| 5 | Coffee Shop Sales | 1,000 | 10 | Frequency tables, chi-square, ANOVA |
| 6 | Pokémon Battle Stats | 151 | 13 | Computed variables, t-tests, distributions |
| 7 | Spotify Streaming | 800 | 12 | Correlation, beta regression, skewness |
| 8 | Superheroes Power Index | 120 | 12 | Factor analysis, clustering, group comparisons |
| 9 | Fast Food Nutrition | 300 | 11 | ANOVA, post-hoc tests, data visualization |
| 10 | Dog Breeds | 195 | 12 | Rank data, logistic regression, scatterplots |
| 11 | Video Game Sales | 600 | 12 | Dummy coding, moderation, multi-level categories |
| 12 | Airline Flights | 2,000 | 12 | Large-N analysis, binary outcomes, distributions |
| 13 | World Cup Soccer | 350 | 12 | Count models (Poisson), skewed continuous vars |
| 14 | Theme Park Rides | 75 | 12 | Small-N issues, outliers, assumption checking |
| 15 | Mars Colony Simulation | 200 | 11 | Continuous outcomes, multivariate relationships |
| 16 | Hogwarts Student Records | 280 | 12 | ANOVA, nested designs, proportions |
| 17 | Shark Tank Pitches | 180 | 12 | Logistic regression, odds ratios, decision modeling |
| 18 | Climate & City Data | 150 | 12 | Multicollinearity, index variables, scatterplot matrices |
| 19 | Craft Beer | 400 | 12 | Ordinal data, ratings, grouped bar charts |
| 20 | Zombie Apocalypse Survival | 500 | 13 | Survival-style analysis, mixed variable types |

---

## 🔧 Quick Start

### R
```r
# Any single dataset
starwars <- read.csv("csv/01_star_wars_characters.csv")

# Load all datasets at once
library(purrr)
files <- list.files("csv", pattern = "*.csv", full.names = TRUE)
datasets <- map(files, read.csv)
```

### Stata
```stata
use "stata/01_star_wars_characters.dta", clear
describe
summarize
```

### SPSS
```spss
GET FILE='spss/01_star_wars_characters.sav'.
DESCRIPTIVES VARIABLES=ALL.
```

### SAS
```sas
libname teach xport 'sas/01_star_wars_characters.xpt';
proc contents data=teach._all_; run;
proc means data=teach.01_star_wars_characters; run;
```

### Python
```python
import pandas as pd
df = pd.read_csv("csv/01_star_wars_characters.csv")
df.describe()
```

---

## 🎯 Variable Types Across Datasets

Each dataset includes a deliberate mix of variable types to support a range of exercises:

- **Continuous**: heights, scores, prices, ratings, percentages
- **Categorical**: genres, species, regions, types, affiliations
- **Binary/Dummy**: yes/no indicators (loyalty member, deal received, legendary)
- **Count**: wins, appearances, kills, detentions
- **Proportions/Rates**: shooting percentages, acceptance rates, efficiency scores
- **Ordinal**: rankings, Likert-style ratings, priority levels

---

## 📐 Suggested Course Mappings

| Course Topic | Recommended Datasets |
|---|---|
| Descriptive statistics & visualization | Coffee Shop (5), Fast Food (9), Dog Breeds (10) |
| t-tests & group comparisons | Star Wars (1), Pokémon (6), Hogwarts (16) |
| One-way & factorial ANOVA | Fast Food (9), Hogwarts (16), Craft Beer (19) |
| Chi-square & contingency tables | Coffee Shop (5), Movie Box Office (4), Shark Tank (17) |
| Simple & multiple regression | College Rankings (2), NBA (3), Spotify (7) |
| Logistic regression | Shark Tank (17), Dog Breeds (10), Zombie Survival (20) |
| Count models (Poisson) | World Cup (13), Superheroes (8), Star Wars (1) |
| Data wrangling & cleaning | NBA (3), Airline Flights (12), Video Games (11) |
| Data visualization projects | Theme Parks (14), Climate/Cities (18), Mars Colony (15) |
| Capstone / open-ended analysis | Zombie Survival (20), Airline Flights (12), College Rankings (2) |

---

## ⚠️ Important Notes

- **These are simulated data.** They are generated from probability distributions to mimic realistic structures. They do not represent real individuals, institutions, or entities.
- **Variable distributions were chosen intentionally.** Some variables are normally distributed; others are log-normal, Poisson, beta, or uniform. This is by design so students encounter realistic distributional variety.
- **Missing data** appears in a small number of datasets (e.g., NBA draft pick) to create organic opportunities for discussing missingness.
- **Sample sizes range from 75 to 2,000** so students experience both small-N limitations and large-N contexts.

---

## 🤝 Contributing

Suggestions for new datasets or improvements to existing ones are welcome. Please open an issue or submit a pull request.

---

## 📄 License

This project is licensed under the **MIT License** — see the [LICENSE](LICENSE) file for details. You are free to use, modify, and distribute these datasets for any purpose, including commercial use, with attribution.

---

## 📬 Citation

If you use these datasets in a course, workshop, or publication, a citation is appreciated but not required:

```
Fun Teaching Datasets for Statistics & Data Science (2026).
GitHub repository: https://github.com/jmfreder123/R-practice-datsets
```
