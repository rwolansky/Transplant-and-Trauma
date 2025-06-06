########## KIDNEY LOVE PLOT ###########

library(MatchIt)
library(tableone)
library(cobalt)
library(ggplot2)
library(knitr)

# Load data
my_data <- read.csv("Y:/Rachel Wolansky/Transplant and Trauma/HCUP/Data Out/Step 6 Ensuring Trauma Codes, Kidneys Only.csv")

# Define all potential covariates
all_xvars <- c("AGE", "RACE", "SEX", "CMR_AIDS", "CMR_ALCOHOL", "CMR_CANCER_LEUK", "CMR_CANCER_LYMPH", 
               "CMR_CANCER_METS", "CMR_CANCER_NSITU", "CMR_CANCER_SOLID", "CMR_DEMENTIA",
               "CMR_DEPRESS", "CMR_DIAB_CX", "CMR_DIAB_UNCX", "CMR_DRUG_ABUSE", "CMR_HTN_CX",
               "CMR_HTN_UNCX", "CMR_LUNG_CHRONIC", "CMR_OBESE", "CMR_PERIVASC", "CMR_THYROID_HYPO", 
               "CMR_THYROID_OTH", "CMR_CKD", "HOSP_BEDSIZE", 
               "HOSP_LOCTEACH", "HOSP_REGION", "H_CONTRL", "PAY1")

# Pre-matching balance
table1_pre <- CreateTableOne(vars = all_xvars, strata = "kidneytxp", data = my_data, test = FALSE)
table1_matrix <- print(table1_pre, smd = TRUE, printToggle = FALSE)

# Extract variables with SMD > 0.1
smd_col <- ncol(table1_matrix)
smd_values <- as.numeric(table1_matrix[, smd_col])
var_names <- gsub(" \\(mean \\(SD\\)\\)", "", rownames(table1_matrix))
names(smd_values) <- var_names

smd_values <- smd_values[!is.na(smd_values)]
high_smd_vars <- names(smd_values)[abs(smd_values) > 0.1]

# Only include variables with SMD > 0.1 
selected_vars <- high_smd_vars[high_smd_vars %in% all_xvars]

# Perform matching
formula <- as.formula(paste("kidneytxp ~", paste(selected_vars, collapse = " + ")))
psmatch <- matchit(formula, data = my_data, method = "nearest", estimand = "ATT", ratio = 1, caliper = 0.2)

# Create love plot
var.names <- c(
  "AGE" = "Age",
  "SEX" = "Sex", 
  "RACE" = "Race",
  "CMR_ALCOHOL" = "Alcohol abuse",
  "CMR_DEMENTIA" = "Dementia",
  "CMR_DIAB_CX" = "Diabetes, Complicated",
  "CMR_DRUG_ABUSE" = "Drug abuse",
  "CMR_HTN_CX" = "Hypertension, Complicated",
  "CMR_HTN_UNCX" = "Hypertension, Uncomplicated",
  "CMR_LUNG_CHRONIC" = "Chronic lung disease",
  "CMR_CKD" = "Chronic kidney disease",
  "PAY1" = "Insurance"
)

love_plot <- love.plot(psmatch,
                       stats = "mean.diff",
                       threshold = .1,
                       abs = TRUE,
                       var.order = "unadjusted",
                       drop.distance = TRUE,
                       binary = "std",
                       continuous = "std",
                       colors = c("red", "blue"),
                       sample.names = c("Unmatched", "Matched"),
                       position = "bottom",
                       var.names = var.names,
                       title = "Balance Before and After Matching in Kidney Transplant Subgroup") +
  theme_bw() +
  theme(
    legend.position = "bottom",
    plot.title = element_text(hjust = 0.5),
    axis.text.y = element_text(size = 10)
  ) +
  labs(y = "Covariate")

print(love_plot)

# Save the plot
ggsave("kidney_transplant_love_plot.png", plot = love_plot, 
       width = 10, height = 8, dpi = 300, bg = "white")


########LIVER LOVE PLOT######

library(MatchIt)
library(tableone)
library(cobalt)
library(ggplot2)
library(knitr)

# Load data
my_data <- read.csv("Y:/Rachel Wolansky/Transplant and Trauma/HCUP/Data Out/Step 6 Ensuring Trauma Codes, Livers Only.csv")

# Define all potential covariates
all_xvars <- c("AGE", "RACE", "SEX", "CMR_AIDS", "CMR_ALCOHOL", "CMR_CANCER_LEUK", "CMR_CANCER_LYMPH", 
               "CMR_CANCER_METS", "CMR_CANCER_NSITU", "CMR_CANCER_SOLID", "CMR_DEMENTIA",
               "CMR_DEPRESS", "CMR_DIAB_CX", "CMR_DIAB_UNCX", "CMR_DRUG_ABUSE", "CMR_HTN_CX",
               "CMR_HTN_UNCX", "CMR_LUNG_CHRONIC", "CMR_OBESE", "CMR_PERIVASC", "CMR_THYROID_HYPO", 
               "CMR_THYROID_OTH", "CMR_CKD", "HOSP_BEDSIZE", 
               "HOSP_LOCTEACH", "HOSP_REGION", "H_CONTRL", "PAY1")

# Pre-matching balance
table1_pre <- CreateTableOne(vars = all_xvars, strata = "livertxp", data = my_data, test = FALSE)
table1_matrix <- print(table1_pre, smd = TRUE, printToggle = FALSE)

# Extract variables with SMD > 0.1
smd_col <- ncol(table1_matrix)
smd_values <- as.numeric(table1_matrix[, smd_col])
var_names <- gsub(" \\(mean \\(SD\\)\\)", "", rownames(table1_matrix))
names(smd_values) <- var_names

smd_values <- smd_values[!is.na(smd_values)]
high_smd_vars <- names(smd_values)[abs(smd_values) > 0.1]

# Only include variables with SMD > 0.1
selected_vars <- high_smd_vars[high_smd_vars %in% all_xvars]

# Perform matching
formula <- as.formula(paste("livertxp ~", paste(selected_vars, collapse = " + ")))
psmatch <- matchit(formula, data = my_data, method = "nearest", estimand = "ATT", ratio = 1, caliper = 0.2)

# Create love plot
var.names <- c(
  "AGE" = "Age",
  "SEX" = "Sex", 
  "RACE" = "Race",
  "CMR_ALCOHOL" = "Alcohol abuse",
  "CMR_DEMENTIA" = "Dementia",
  "CMR_DEPRESS" = "Depression",
  "CMR_DIAB_CX" = "Diabetes, Complicated",
  "CMR_HTN_CX" = "Hypertension, Complicated",
  "CMR_HTN_UNCX" = "Hypertension, Uncomplicated",
  "CMR_CKD" = "Chronic kidney disease",
  "HOSP_BEDSIZE" = "Hospital bed size",
  "HOSP_LOCTEACH" = "Hospital location/teaching",
  "PAY1" = "Insurance"
)

love_plot <- love.plot(psmatch,
                       stats = "mean.diff",
                       threshold = .1,
                       abs = TRUE,
                       var.order = "unadjusted",
                       drop.distance = TRUE,
                       binary = "std",
                       continuous = "std",
                       colors = c("red", "blue"),
                       sample.names = c("Unmatched", "Matched"),
                       position = "bottom",
                       var.names = var.names,
                       title = "Balance Before and After Matching in Liver Transplant Subgroup") +
  theme_bw() +
  theme(
    legend.position = "bottom",
    plot.title = element_text(hjust = 0.5),
    axis.text.y = element_text(size = 10)
  ) +
  labs(y = "Covariate")

print(love_plot)

# Save the plot
ggsave("liver_transplant_love_plot.png", plot = love_plot, 
       width = 10, height = 8, dpi = 300, bg = "white")