# Enhanced PSM Analysis for Liver Transplant Patients with Automatic Covariate Selection and Quality Assessment
# Load necessary libraries
library(MatchIt)
library(haven)
library(tableone)
library(cobalt)
library(lme4)
library(lmerTest)
library(ggplot2)
library(knitr)
library(effsize)
library(pwr)

# Load data
my_data <- read.csv("Y:/Rachel Wolansky/Transplant and Trauma/HCUP/Data Out/Step 6 Ensuring Trauma Codes, Livers Only.csv")

# Define all potential covariates for initial assessment
all_xvars <- c("AGE", "RACE", "SEX", "CMR_AIDS", "CMR_ALCOHOL", "CMR_CANCER_LEUK", "CMR_CANCER_LYMPH", 
               "CMR_CANCER_METS", "CMR_CANCER_NSITU", "CMR_CANCER_SOLID", "CMR_DEMENTIA",
               "CMR_DEPRESS", "CMR_DIAB_CX", "CMR_DIAB_UNCX", "CMR_DRUG_ABUSE", "CMR_HTN_CX",
               "CMR_HTN_UNCX", "CMR_LUNG_CHRONIC", "CMR_OBESE", "CMR_PERIVASC", "CMR_THYROID_HYPO", 
               "CMR_THYROID_OTH", "CMR_CKD", "HOSP_BEDSIZE", 
               "HOSP_LOCTEACH", "HOSP_REGION", "H_CONTRL", "PAY1")

# ============================================================================
# STEP 1: PRE-MATCHING ASSESSMENT AND AUTOMATIC COVARIATE SELECTION
# ============================================================================

# Check treatment variable distribution
cat("Treatment Variable Distribution:\n")
print(table(my_data$livertxp))
cat("\nTreatment Variable Summary:\n")
print(summary(my_data$livertxp))

# Create initial Table 1 with all covariates
cat("\n", paste(rep("=", 80), collapse=""), "\n")
cat("PRE-MATCHING BALANCE ASSESSMENT\n")
cat(paste(rep("=", 80), collapse=""), "\n")

table1_pre <- CreateTableOne(vars = all_xvars, 
                             strata = "livertxp", 
                             data = my_data, 
                             test = FALSE)

# Print table with SMDs
table1_pre_output <- print(table1_pre, smd = TRUE, printToggle = FALSE)
print(table1_pre_output)

# Extract SMDs and automatically select covariates with SMD > 0.1
table1_matrix <- print(table1_pre, smd = TRUE, printToggle = FALSE)

# Extract SMD column (last column) and variable names
smd_col <- ncol(table1_matrix)
smd_values <- as.numeric(table1_matrix[, smd_col])
var_names <- rownames(table1_matrix)

# Clean variable names by removing "(mean (SD))" suffix
clean_var_names <- gsub(" \\(mean \\(SD\\)\\)", "", var_names)
names(smd_values) <- clean_var_names

# Remove missing values and select variables with SMD > 0.1
smd_values <- smd_values[!is.na(smd_values)]
high_smd_vars <- names(smd_values)[abs(smd_values) > 0.1]

# Only include variables with SMD > 0.1
selected_vars <- high_smd_vars[high_smd_vars %in% all_xvars]

cat("\n" , paste(rep("=", 60), collapse=""), "\n")
cat("AUTOMATIC COVARIATE SELECTION RESULTS\n")
cat(paste(rep("=", 60), collapse=""), "\n")
cat("Variables with SMD > 0.1:\n")
if(length(high_smd_vars) > 0) {
  for(var in high_smd_vars) {
    if(var %in% names(smd_values)) {
      cat(sprintf("  %s: SMD = %.3f\n", var, smd_values[var]))
    }
  }
} else {
  cat("  No variables with SMD > 0.1 found\n")
}

cat("\nFinal selected variables for PSM:\n")
cat(paste(" ", selected_vars, collapse = "\n"))
cat("\n")

# ============================================================================
# STEP 2: PROPENSITY SCORE MATCHING
# ============================================================================

cat("\n", paste(rep("=", 80), collapse=""), "\n")
cat("PROPENSITY SCORE MATCHING\n")
cat(paste(rep("=", 80), collapse=""), "\n")

# Create formula with selected variables
formula <- as.formula(paste("livertxp ~", paste(selected_vars, collapse = " + ")))
cat("Matching formula:", deparse(formula), "\n\n")

# Perform propensity score matching
psmatch <- matchit(formula, 
                   data = my_data, 
                   method = "nearest", 
                   estimand = "ATT", 
                   ratio = 1,
                   caliper = 0.2)  # Adding caliper for better matches

# Get matched data
matched_data <- match.data(psmatch)

# ============================================================================
# STEP 3: POST-MATCHING QUALITY ASSESSMENT
# ============================================================================

cat("MATCHING SUMMARY:\n")
print(summary(psmatch))

# Sample sizes
cat("\nSample Sizes:\n")
cat(sprintf("Original treated: %d\n", sum(my_data$livertxp == 1)))
cat(sprintf("Original controls: %d\n", sum(my_data$livertxp == 0)))
cat(sprintf("Matched treated: %d\n", sum(matched_data$livertxp == 1)))
cat(sprintf("Matched controls: %d\n", sum(matched_data$livertxp == 0)))
cat(sprintf("Matching efficiency: %.1f%%\n", 
            (sum(matched_data$livertxp == 1) / sum(my_data$livertxp == 1)) * 100))

# Balance assessment using cobalt
cat("\n", paste(rep("=", 60), collapse=""), "\n")
cat("BALANCE ASSESSMENT (COBALT)\n")
cat(paste(rep("=", 60), collapse=""), "\n")

bal_tab <- bal.tab(psmatch, un = TRUE, thresholds = c(m = 0.1))
print(bal_tab)

# Love plot for visual balance assessment
cat("\nGenerating balance plot...\n")
love_plot <- love.plot(psmatch, 
                       binary = "std", 
                       thresholds = c(m = 0.1),
                       var.order = "unadjusted",
                       title = "Standardized Mean Differences Before and After Matching")
print(love_plot)

# Post-matching table
cat("\n", paste(rep("=", 60), collapse=""), "\n")
cat("POST-MATCHING BALANCE TABLE\n")
cat(paste(rep("=", 60), collapse=""), "\n")

table_matched <- CreateTableOne(vars = selected_vars, 
                                strata = "livertxp", 
                                data = matched_data, 
                                test = FALSE)
print(table_matched, smd = TRUE)

# ============================================================================
# STEP 4: PROPENSITY SCORE DIAGNOSTICS
# ============================================================================

cat("\n", paste(rep("=", 60), collapse=""), "\n")
cat("PROPENSITY SCORE DIAGNOSTICS\n")
cat(paste(rep("=", 60), collapse=""), "\n")

# Propensity score distribution plots
ps_data <- data.frame(
  ps = c(psmatch$distance, matched_data$distance),
  group = factor(c(ifelse(psmatch$treat == 1, "Treated", "Control"),
                   ifelse(matched_data$livertxp == 1, "Treated (Matched)", "Control (Matched)")),
                 levels = c("Treated", "Control", "Treated (Matched)", "Control (Matched)")),
  dataset = c(rep("Before Matching", length(psmatch$distance)), 
              rep("After Matching", nrow(matched_data)))
)

ps_plot <- ggplot(ps_data, aes(x = ps, fill = group)) +
  geom_histogram(alpha = 0.6, bins = 30, position = "identity") +
  facet_wrap(~dataset, scales = "free_y") +
  labs(title = "Propensity Score Distribution",
       x = "Propensity Score",
       y = "Frequency") +
  theme_minimal()
print(ps_plot)

# Overall balance statistics
balance_stats <- bal.tab(psmatch, un = TRUE)
cat(sprintf("Pseudo R-squared before matching: %.4f\n", 
            balance_stats$Balance$M.0.Un))
cat(sprintf("Pseudo R-squared after matching: %.4f\n", 
            balance_stats$Balance$M.0.Adj))

# ============================================================================
# STEP 5: OUTCOME ANALYSIS (CORRECTED)
# ============================================================================

cat("\n", paste(rep("=", 80), collapse=""), "\n")
cat("OUTCOME ANALYSIS: LENGTH OF STAY\n")
cat(paste(rep("=", 80), collapse=""), "\n")

# Check LOS distribution
cat("Length of Stay Distribution:\n")
print(summary(matched_data$LOS))

# Create histogram
los_hist <- ggplot(matched_data, aes(x = LOS)) +
  geom_histogram(bins = 30, alpha = 0.7) +
  facet_wrap(~factor(livertxp, labels = c("No Transplant", "Liver Transplant"))) +
  labs(title = "Distribution of Length of Stay by Group",
       x = "Length of Stay (days)",
       y = "Frequency") +
  theme_minimal()
print(los_hist)

# Descriptive statistics by group
summary_stats <- aggregate(LOS ~ livertxp, data = matched_data, 
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
summary_df$Group <- ifelse(summary_df$Group == 0, "No Transplant", "Liver Transplant")

cat("\nDescriptive Statistics:\n")
print(kable(summary_df, digits = 2, format = "pipe"))

# CORRECTED STATISTICAL TESTS (UNPAIRED)
cat("\n", paste(rep("=", 60), collapse=""), "\n")
cat("STATISTICAL TESTS (CORRECTED - UNPAIRED)\n")
cat(paste(rep("=", 60), collapse=""), "\n")

# Unpaired t-test
t_test_result <- t.test(LOS ~ livertxp, data = matched_data, paired = FALSE)

# Mann-Whitney U test (unpaired non-parametric)
wilcox_result <- wilcox.test(LOS ~ livertxp, data = matched_data, paired = FALSE)

# Calculate effect size (Cohen's d)
cohen_d_result <- cohen.d(matched_data$LOS[matched_data$livertxp == 1], 
                          matched_data$LOS[matched_data$livertxp == 0])

# Create results table
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

cat("\nStatistical Test Results:\n")
print(kable(results_table, format = "pipe", align = c("l", "c", "c", "c")))

cat(sprintf("\nMean difference (Transplant - No Transplant): %.2f days\n", 
            t_test_result$estimate[1] - t_test_result$estimate[2]))
cat(sprintf("95%% Confidence Interval: [%.2f, %.2f]\n", 
            t_test_result$conf.int[1], t_test_result$conf.int[2]))

# ============================================================================
# STEP 6: POWER ANALYSIS
# ============================================================================

cat("\n", paste(rep("=", 60), collapse=""), "\n")
cat("POWER ANALYSIS\n")
cat(paste(rep("=", 60), collapse=""), "\n")

# Sample sizes
n_treated <- sum(matched_data$livertxp == 1)
n_control <- sum(matched_data$livertxp == 0)
observed_d <- abs(cohen_d_result$estimate)

# Calculate achieved power
achieved_power <- pwr.t.test(n = min(n_treated, n_control), 
                             d = observed_d, 
                             sig.level = 0.05, 
                             type = "two.sample")

cat(sprintf("Sample size per group: %d\n", min(n_treated, n_control)))
cat(sprintf("Observed effect size (Cohen's d): %.3f\n", observed_d))
cat(sprintf("Achieved power: %.3f (%.1f%%)\n", achieved_power$power, achieved_power$power * 100))

# Power for clinically meaningful differences
meaningful_differences <- c(0.5, 1.0, 1.5, 2.0)  # days
cat("\nPower for detecting clinically meaningful differences:\n")

pooled_sd <- sqrt(((n_treated - 1) * var(matched_data$LOS[matched_data$livertxp == 1], na.rm = TRUE) + 
                     (n_control - 1) * var(matched_data$LOS[matched_data$livertxp == 0], na.rm = TRUE)) / 
                    (n_treated + n_control - 2))

for(diff in meaningful_differences) {
  effect_size <- diff / pooled_sd
  power_for_diff <- pwr.t.test(n = min(n_treated, n_control), 
                               d = effect_size, 
                               sig.level = 0.05, 
                               type = "two.sample")$power
  cat(sprintf("  %g day difference: %.3f (%.1f%%)\n", diff, power_for_diff, power_for_diff * 100))
}

# ============================================================================
# STEP 7: QUALITY ASSESSMENT SUMMARY
# ============================================================================

cat("\n", paste(rep("=", 80), collapse=""), "\n")
cat("PSM QUALITY ASSESSMENT SUMMARY\n")
cat(paste(rep("=", 80), collapse=""), "\n")

# Count variables with good balance (SMD < 0.1) after matching
balance_table <- bal.tab(psmatch)

# Extract numeric SMD values (exclude non-numeric rows like sample sizes)
if("Diff.Adj" %in% names(balance_table$Balance)) {
  post_match_smd <- balance_table$Balance$Diff.Adj
} else if("SMD.Adj" %in% names(balance_table$Balance)) {
  post_match_smd <- balance_table$Balance$SMD.Adj
} else {
  # Check what columns are available
  print(names(balance_table$Balance))
  post_match_smd <- balance_table$Balance[,ncol(balance_table$Balance)] # last column often has adjusted SMDs
}

# Remove non-numeric entries (like sample size rows)
post_match_smd <- post_match_smd[!is.na(as.numeric(post_match_smd))]
post_match_smd <- as.numeric(post_match_smd)

# Now calculate balance statistics
good_balance_count <- sum(abs(post_match_smd) < 0.1, na.rm = TRUE)
total_vars_count <- length(post_match_smd[!is.na(post_match_smd)])

cat("BALANCE ASSESSMENT:\n")
cat(sprintf("- Variables with SMD < 0.1 after matching: %d/%d (%.1f%%)\n", 
            good_balance_count, total_vars_count, 
            (good_balance_count/total_vars_count) * 100))
cat(sprintf("- Mean absolute SMD after matching: %.3f\n", 
            mean(abs(post_match_smd), na.rm = TRUE)))
cat(sprintf("- Max absolute SMD after matching: %.3f\n", 
            max(abs(post_match_smd), na.rm = TRUE)))

cat("\nMATCHING EFFICIENCY:\n")
cat(sprintf("- Treated patients matched: %d/%d (%.1f%%)\n", 
            n_treated, sum(my_data$livertxp == 1),
            (n_treated/sum(my_data$livertxp == 1)) * 100))

cat("\nSTATISTICAL POWER:\n")
if(achieved_power$power >= 0.8) {
  cat("- Power assessment: ADEQUATE (≥80%)\n")
} else if(achieved_power$power >= 0.6) {
  cat("- Power assessment: MODERATE (60-80%)\n")
} else {
  cat("- Power assessment: LOW (<60%)\n")
}

cat("\nOVERALL ASSESSMENT:\n")
if(good_balance_count/total_vars_count >= 0.8 && achieved_power$power >= 0.6) {
  cat("- PSM Quality: GOOD - Adequate balance and reasonable power\n")
} else if(good_balance_count/total_vars_count >= 0.6) {
  cat("- PSM Quality: FAIR - Some balance issues or low power\n")
} else {
  cat("- PSM Quality: POOR - Significant balance issues\n")
}

cat("\n", paste(rep("=", 80), collapse=""), "\n")
cat("ANALYSIS COMPLETE\n")
cat(paste(rep("=", 80), collapse=""), "\n")