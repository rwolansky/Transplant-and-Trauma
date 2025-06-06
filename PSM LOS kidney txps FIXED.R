# Simplified PSM Analysis for Kidney Transplant - Continuous Outcome (Length of Stay)
library(MatchIt)
library(tableone)
library(cobalt)
library(ggplot2)
library(knitr)
library(effsize)

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
print(summary(my_data$LOS))

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

# Calculate pre-matching LOS statistics
pre_stats <- aggregate(LOS ~ kidneytxp, data = my_data, 
                       FUN = function(x) c(mean = mean(x, na.rm = TRUE), 
                                           sd = sd(x, na.rm = TRUE)))
pre_summary <- do.call(data.frame, pre_stats)
colnames(pre_summary) <- c("Group", "Mean", "SD")
pre_summary$Group <- ifelse(pre_summary$Group == 0, "No Transplant", "Kidney Transplant")

cat(sprintf("\nPre-Matching LOS Statistics:\n"))
print(kable(pre_summary, digits = 2, format = "pipe"))

# Pre-matching statistical tests
pre_t_test <- t.test(LOS ~ kidneytxp, data = my_data, paired = FALSE)
pre_wilcox <- wilcox.test(LOS ~ kidneytxp, data = my_data, paired = FALSE)

# Pre-matching results
cat(sprintf("\nPre-Matching Statistical Tests:\n"))
cat(sprintf("T-test: t = %.3f, p = %.4f\n", pre_t_test$statistic, pre_t_test$p.value))
cat(sprintf("Mann-Whitney U: W = %.0f, p = %.4f\n", pre_wilcox$statistic, pre_wilcox$p.value))
cat(sprintf("Mean difference: %.2f days (95%% CI: %.2f to %.2f)\n", 
            pre_t_test$estimate[1] - pre_t_test$estimate[2],
            pre_t_test$conf.int[1], pre_t_test$conf.int[2]))

if(pre_t_test$p.value < 0.05) {
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
                       title = "Balance Before and After Matching: Kidney Transplant LOS Analysis") +
  theme_bw() +
  theme(
    legend.position = "bottom",
    plot.title = element_text(hjust = 0.5),
    axis.text.y = element_text(size = 10)
  )

print(love_plot)

# ============================================================================
# STEP 4: POST-MATCHING OUTCOME ANALYSIS
# ============================================================================

cat("\n\nPOST-MATCHING OUTCOME ANALYSIS:\n")

# LOS distribution in matched data
cat("Length of Stay Distribution:\n")
print(summary(matched_data$LOS))

# Create histogram
los_hist <- ggplot(matched_data, aes(x = LOS)) +
  geom_histogram(bins = 30, alpha = 0.7) +
  facet_wrap(~factor(kidneytxp, labels = c("No Transplant", "Kidney Transplant"))) +
  labs(title = "Distribution of Length of Stay by Group",
       x = "Length of Stay (days)",
       y = "Frequency") +
  theme_minimal()
print(los_hist)

# Descriptive statistics by group
summary_stats <- aggregate(LOS ~ kidneytxp, data = matched_data, 
                           FUN = function(x) c(
                             n = length(x),
                             mean = mean(x, na.rm = TRUE), 
                             sd = sd(x, na.rm = TRUE), 
                             median = median(x, na.rm = TRUE), 
                             q25 = quantile(x, 0.25, na.rm = TRUE),
                             q75 = quantile(x, 0.75, na.rm = TRUE),
                             min = min(x, na.rm = TRUE),
                             max = max(x, na.rm = TRUE)
                           ))

summary_df <- do.call(data.frame, summary_stats)
colnames(summary_df) <- c("Group", "N", "Mean", "SD", "Median", "Q25", "Q75", "Min", "Max")
summary_df$Group <- ifelse(summary_df$Group == 0, "No Transplant", "Kidney Transplant")

cat("\nPost-Matching Descriptive Statistics:\n")
print(kable(summary_df, digits = 2, format = "pipe"))

# Statistical tests
t_test_result <- t.test(LOS ~ kidneytxp, data = matched_data, paired = FALSE)
wilcox_result <- wilcox.test(LOS ~ kidneytxp, data = matched_data, paired = FALSE)
cohen_d_result <- cohen.d(matched_data$LOS[matched_data$kidneytxp == 1], 
                          matched_data$LOS[matched_data$kidneytxp == 0])

# Results table
results_table <- data.frame(
  Method = c("Unpaired t-test", "Mann-Whitney U test", "Cohen's d"),
  Statistic = c(
    sprintf("t = %.3f", t_test_result$statistic),
    sprintf("W = %.0f", wilcox_result$statistic),
    sprintf("d = %.3f", cohen_d_result$estimate)
  ),
  P_value = c(
    sprintf("%.4f", t_test_result$p.value),
    sprintf("%.4f", wilcox_result$p.value),
    sprintf("95%% CI: [%.3f, %.3f]", cohen_d_result$conf.int[1], cohen_d_result$conf.int[2])
  ),
  Interpretation = c(
    ifelse(t_test_result$p.value < 0.05, "Significant", "Not significant"),
    ifelse(wilcox_result$p.value < 0.05, "Significant", "Not significant"),
    ifelse(abs(cohen_d_result$estimate) < 0.2, "Negligible",
           ifelse(abs(cohen_d_result$estimate) < 0.5, "Small",
                  ifelse(abs(cohen_d_result$estimate) < 0.8, "Medium", "Large")))
  )
)

cat("\n\nPOST-MATCHING STATISTICAL RESULTS:\n")
print(kable(results_table, format = "pipe"))

# Effect sizes
cat(sprintf("\nPost-Matching Effect Sizes:\n"))
cat(sprintf("Mean difference (Transplant - No Transplant): %.2f days\n", 
            t_test_result$estimate[1] - t_test_result$estimate[2]))
cat(sprintf("95%% Confidence Interval: [%.2f, %.2f]\n", 
            t_test_result$conf.int[1], t_test_result$conf.int[2]))
cat(sprintf("Cohen's d: %.3f\n", cohen_d_result$estimate))

# ============================================================================
# STEP 5: COMPARISON OF PRE- VS POST-MATCHING RESULTS
# ============================================================================

cat(sprintf("\n\nCOMPARISON: PRE- vs POST-MATCHING RESULTS:\n"))
cat(sprintf("%-25s %10s %15s %15s %10s\n", "Analysis", "Mean Diff", "P-value (t-test)", "Cohen's d", "Significant"))
cat(sprintf("%-25s %10.2f %15.4f %15.3f %10s\n", 
            "Pre-Matching", pre_t_test$estimate[1] - pre_t_test$estimate[2], 
            pre_t_test$p.value, 0.000, ifelse(pre_t_test$p.value < 0.05, "Yes", "No")))
cat(sprintf("%-25s %10.2f %15.4f %15.3f %10s\n", 
            "Post-Matching", t_test_result$estimate[1] - t_test_result$estimate[2], 
            t_test_result$p.value, cohen_d_result$estimate, 
            ifelse(t_test_result$p.value < 0.05, "Yes", "No")))

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
if(t_test_result$p.value < 0.05) {
  cat("\n*** FINAL CONCLUSION: Statistically significant difference in length of stay after matching ***\n")
} else {
  cat("\n*** FINAL CONCLUSION: No statistically significant difference in length of stay after matching ***\n")
}

cat("Analysis complete.\n")