# Simplified PSM Analysis for Kidney Transplant - Binary Outcome (Renal Failure)
library(MatchIt)
library(tableone)
library(cobalt)
library(ggplot2)
library(knitr)
library(survival)

# Load data
my_data <- read.csv("Y:/Rachel Wolansky/Transplant and Trauma/HCUP/Data Out/Step 6 Ensuring Trauma Codes, Kidneys Only.csv")

# Define all potential covariates
all_xvars <- c("AGE", "RACE", "SEX", "CMR_AIDS", "CMR_ALCOHOL", "CMR_CANCER_LEUK", "CMR_CANCER_LYMPH", 
               "CMR_CANCER_METS", "CMR_CANCER_NSITU", "CMR_CANCER_SOLID", "CMR_DEMENTIA",
               "CMR_DEPRESS", "CMR_DIAB_CX", "CMR_DIAB_UNCX", "CMR_DRUG_ABUSE", "CMR_HTN_CX",
               "CMR_HTN_UNCX", "CMR_LUNG_CHRONIC", "CMR_OBESE", "CMR_PERIVASC", "CMR_THYROID_HYPO", 
               "CMR_THYROID_OTH", "CMR_CKD", "HOSP_BEDSIZE", 
               "HOSP_LOCTEACH", "HOSP_REGION", "H_CONTRL", "PAY1")

# ============================================================================
# STEP 1: PRE-MATCHING ASSESSMENT AND COVARIATE SELECTION
# ============================================================================

# Check variables
cat("Treatment Variable Distribution:\n")
print(table(my_data$kidneytxp))
cat("\nOutcome Distribution:\n")
print(table(my_data$renalfailure, my_data$kidneytxp))

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

cat("Selected variables for matching:\n")
cat(paste(" ", selected_vars, collapse = "\n"))

# ============================================================================
# STEP 2: PRE-MATCHING OUTCOME ANALYSIS
# ============================================================================

cat("\n\nPRE-MATCHING OUTCOME ANALYSIS:\n")

# Pre-matching outcome distribution
pre_outcome_table <- table(my_data$renalfailure, my_data$kidneytxp, 
                           dnn = c("Renal Failure", "Kidney Transplant"))
print(pre_outcome_table)

# Calculate pre-matching failure rates
pre_rates <- prop.table(pre_outcome_table, margin = 2)
pre_control_rate <- pre_rates[2, 1]
pre_treated_rate <- pre_rates[2, 2]

cat(sprintf("\nPre-Matching Failure Rates:\n"))
cat(sprintf("No Transplant: %.1f%% (%d/%d)\n", 
            pre_control_rate * 100, pre_outcome_table[2,1], sum(pre_outcome_table[,1])))
cat(sprintf("Kidney Transplant: %.1f%% (%d/%d)\n", 
            pre_treated_rate * 100, pre_outcome_table[2,2], sum(pre_outcome_table[,2])))

# Pre-matching statistical tests
pre_fisher_test <- fisher.test(pre_outcome_table)
pre_chi_test <- chisq.test(pre_outcome_table)

# Pre-matching results
cat(sprintf("\nPre-Matching Statistical Tests:\n"))
cat(sprintf("Fisher's Exact Test: OR = %.2f, p = %.4f (95%% CI: %.2f-%.2f)\n",
            pre_fisher_test$estimate, pre_fisher_test$p.value, 
            pre_fisher_test$conf.int[1], pre_fisher_test$conf.int[2]))
cat(sprintf("Chi-square Test: χ² = %.3f, p = %.4f\n",
            pre_chi_test$statistic, pre_chi_test$p.value))

# Pre-matching effect sizes
pre_risk_diff <- pre_treated_rate - pre_control_rate
cat(sprintf("Pre-Matching Risk Difference: %.3f (%.1f percentage points)\n", 
            pre_risk_diff, pre_risk_diff * 100))

if(pre_fisher_test$p.value < 0.05) {
  cat("*** PRE-MATCHING: Statistically significant difference ***\n")
} else {
  cat("*** PRE-MATCHING: No statistically significant difference ***\n")
}

# ============================================================================
# STEP 3: PROPENSITY SCORE MATCHING
# ============================================================================

# Perform matching
formula <- as.formula(paste("kidneytxp ~", paste(selected_vars, collapse = " + ")))
psmatch <- matchit(formula, data = my_data, method = "nearest", estimand = "ATT", ratio = 1, caliper = 0.2)

# Get matched data
matched_data <- match.data(psmatch)

# Check balance
cat("\n\nMATCHING SUMMARY:\n")
print(summary(psmatch))

bal_tab <- bal.tab(psmatch, un = TRUE, thresholds = c(m = 0.1))
print(bal_tab)

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
                       title = "Balance Before and After Matching: Kidney Transplant Analysis") +
  theme_bw() +
  theme(
    legend.position = "bottom",
    plot.title = element_text(hjust = 0.5),
    axis.text.y = element_text(size = 10)
  )

print(love_plot)

# ============================================================================
# STEP 4: POST-MATCHING OUTCOME ANALYSIS WITH MCNEMAR'S TEST
# ============================================================================

cat("\n\nPOST-MATCHING OUTCOME ANALYSIS:\n")

# Create paired data for McNemar's test
# Each matched pair should have one treated and one control unit
matched_pairs <- matched_data[order(matched_data$subclass, matched_data$kidneytxp), ]

# Create data frame with pairs side by side
treated_outcomes <- matched_pairs$renalfailure[matched_pairs$kidneytxp == 1]
control_outcomes <- matched_pairs$renalfailure[matched_pairs$kidneytxp == 0]

# Create McNemar contingency table
# Rows: Control outcome, Columns: Treated outcome
mcnemar_table <- table(control_outcomes, treated_outcomes,
                       dnn = c("Control (No Transplant)", "Treated (Transplant)"))

cat("McNemar's Test Contingency Table (Matched Pairs):\n")
print(mcnemar_table)

# Calculate concordant and discordant pairs
concordant_both_fail <- mcnemar_table[2, 2]  # Both fail
concordant_both_survive <- mcnemar_table[1, 1]  # Both survive
discordant_control_fail <- mcnemar_table[2, 1]  # Control fails, treated survives
discordant_treated_fail <- mcnemar_table[1, 2]  # Control survives, treated fails

total_pairs <- sum(mcnemar_table)

cat(sprintf("\nPaired Outcomes Summary:\n"))
cat(sprintf("Total matched pairs: %d\n", total_pairs))
cat(sprintf("Both survived: %d pairs (%.1f%%)\n", 
            concordant_both_survive, (concordant_both_survive/total_pairs)*100))
cat(sprintf("Both failed: %d pairs (%.1f%%)\n", 
            concordant_both_fail, (concordant_both_fail/total_pairs)*100))
cat(sprintf("Control failed, Treated survived: %d pairs (%.1f%%)\n", 
            discordant_control_fail, (discordant_control_fail/total_pairs)*100))
cat(sprintf("Control survived, Treated failed: %d pairs (%.1f%%)\n", 
            discordant_treated_fail, (discordant_treated_fail/total_pairs)*100))

# Perform McNemar's test
mcnemar_result <- mcnemar.test(mcnemar_table, correct = TRUE)

# Calculate effect sizes for matched pairs
treated_failure_rate <- sum(treated_outcomes) / length(treated_outcomes)
control_failure_rate <- sum(control_outcomes) / length(control_outcomes)
matched_risk_diff <- treated_failure_rate - control_failure_rate

# Calculate odds ratio for McNemar's test
# OR = (discordant pairs in favor of treatment) / (discordant pairs against treatment)
if(discordant_treated_fail > 0) {
  mcnemar_or <- discordant_treated_fail / discordant_control_fail
} else {
  mcnemar_or <- Inf
}

# Calculate confidence interval for OR
if(discordant_control_fail > 0 && discordant_treated_fail > 0) {
  log_or <- log(mcnemar_or)
  se_log_or <- sqrt(1/discordant_control_fail + 1/discordant_treated_fail)
  ci_lower <- exp(log_or - 1.96 * se_log_or)
  ci_upper <- exp(log_or + 1.96 * se_log_or)
} else {
  ci_lower <- NA
  ci_upper <- NA
}

# Also run conditional logistic regression for comparison
clogit_model <- clogit(renalfailure ~ kidneytxp + strata(subclass), data = matched_data)

# Results table
results_table <- data.frame(
  Method = c("McNemar's Test", "Conditional Logistic Regression"),
  Odds_Ratio = c(
    ifelse(is.finite(mcnemar_or), sprintf("%.2f", mcnemar_or), "Inf"),
    sprintf("%.2f", exp(coef(clogit_model)["kidneytxp"]))
  ),
  P_value = c(
    sprintf("%.4f", mcnemar_result$p.value),
    sprintf("%.4f", summary(clogit_model)$coefficients["kidneytxp", "Pr(>|z|)"])
  ),
  CI_95 = c(
    ifelse(is.finite(mcnemar_or) && !is.na(ci_lower), 
           sprintf("%.2f-%.2f", ci_lower, ci_upper), "Not calculated"),
    sprintf("%.2f-%.2f", exp(confint(clogit_model)["kidneytxp", 1]), exp(confint(clogit_model)["kidneytxp", 2]))
  ),
  Significant = c(
    ifelse(mcnemar_result$p.value < 0.05, "Yes", "No"),
    ifelse(summary(clogit_model)$coefficients["kidneytxp", "Pr(>|z|)"] < 0.05, "Yes", "No")
  )
)

cat("\n\nPOST-MATCHING STATISTICAL RESULTS:\n")
print(kable(results_table, format = "pipe"))

cat(sprintf("\nMcNemar's Test Details:\n"))
cat(sprintf("Chi-square statistic: %.3f\n", mcnemar_result$statistic))
cat(sprintf("P-value: %.4f\n", mcnemar_result$p.value))
cat(sprintf("Discordant pairs: %d (analysis based on these pairs)\n", 
            discordant_control_fail + discordant_treated_fail))

cat(sprintf("\nPost-Matching Effect Sizes:\n"))
cat(sprintf("Risk Difference: %.3f (%.1f percentage points)\n", matched_risk_diff, matched_risk_diff * 100))
cat(sprintf("Control group failure rate: %.1f%% (%d/%d)\n", 
            control_failure_rate * 100, sum(control_outcomes), length(control_outcomes)))
cat(sprintf("Treated group failure rate: %.1f%% (%d/%d)\n", 
            treated_failure_rate * 100, sum(treated_outcomes), length(treated_outcomes)))

# ============================================================================
# STEP 5: COMPARISON OF PRE- VS POST-MATCHING RESULTS
# ============================================================================

cat(sprintf("\n\nCOMPARISON: PRE- vs POST-MATCHING RESULTS:\n"))
cat(sprintf("%-25s %10s %15s %15s %10s\n", "Analysis", "OR", "P-value", "Risk Diff (%)", "Significant"))
cat(sprintf("%-25s %10.2f %15.4f %15.1f %10s\n", 
            "Pre-Matching (Fisher)", pre_fisher_test$estimate, pre_fisher_test$p.value, 
            pre_risk_diff * 100, ifelse(pre_fisher_test$p.value < 0.05, "Yes", "No")))
cat(sprintf("%-25s %10s %15.4f %15.1f %10s\n", 
            "Post-Matching (McNemar)", 
            ifelse(is.finite(mcnemar_or), sprintf("%.2f", mcnemar_or), "Inf"),
            mcnemar_result$p.value, 
            matched_risk_diff * 100, ifelse(mcnemar_result$p.value < 0.05, "Yes", "No")))

# ============================================================================
# STEP 6: QUALITY SUMMARY
# ============================================================================

# Balance quality
balance_stats <- bal.tab(psmatch)
post_match_smd <- balance_stats$Balance$Diff.Adj
post_match_smd <- as.numeric(post_match_smd[!is.na(as.numeric(post_match_smd))])
good_balance <- sum(abs(post_match_smd) < 0.1, na.rm = TRUE)
total_vars <- length(post_match_smd)

cat(sprintf("\n\nQUALITY ASSESSMENT:\n"))
cat(sprintf("Variables with good balance: %d/%d (%.1f%%)\n", 
            good_balance, total_vars, (good_balance/total_vars) * 100))
cat(sprintf("Matching efficiency: %d/%d (100.0%%)\n", 
            sum(matched_data$kidneytxp == 1), sum(my_data$kidneytxp == 1)))

# Final conclusion
if(mcnemar_result$p.value < 0.05) {
  cat("\n*** FINAL CONCLUSION: McNemar's test shows statistically significant difference in renal failure risk between matched pairs ***\n")
} else {
  cat("\n*** FINAL CONCLUSION: McNemar's test shows no statistically significant difference in renal failure risk between matched pairs ***\n")
}

cat("\nNOTE: McNemar's test is specifically designed for matched pairs data and focuses on discordant pairs.\n")
cat("Analysis complete.\n")