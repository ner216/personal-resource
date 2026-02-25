# Chapter 7 and 8 helper functions
#
# Created by Nolan Provencher
#
#

# NOTE: K.factor(n,f=NULL,alpha,p,2) returns k
# xbar plus/minus k * s

# Chapter 7 helper functions: --------------------------------------------------

# T func
# qt: find one tailed t-table values
# dt: PDF
# pt: CDF

# Calculate values for critical T values (Student T distribution)
# alpha: area under curve at ends of graph
# df: degrees of freedom (n-1)
# List returned contains:
#  Two-tail confidence interval value
#  Single tail upper confidence bound value
#  Single tail lower confidence bound value
critical_t = function(alpha, df) {
    two_tail = qt(1-alpha/2, df)
    single_tail_upper = qt(1-alpha,df)
    single_tail_lower = qt(alpha,df)
    return(list(
      TwoTailUpper = two_tail,
      TwoTailLower = -(two_tail),
      SingleTailUpper = single_tail_upper,
      SingleTailLower = single_tail_lower
    ))
}

# Calculate values for critical Z values (Standard Normal Distribution)
# List returned contains:
#  Left critical Z value
#  Right critical Z value
#  Left Tail
#  Right Tail
critical_z = function(alpha) {
  left_critical = qnorm(alpha/2, lower.tail = TRUE)
  right_critical = qnorm(1-alpha/2, lower.tail = TRUE)
  
  left_tail = qnorm(alpha, lower.tail = TRUE)
  right_tail = qnorm(1-alpha, lower.tail = TRUE)
  
  return(list(
    LeftCriticalZ = left_critical,
    RightCriticalZ = right_critical,
    LeftTail = left_tail,
    RightTail = right_tail
  ))
}

# Returns confidence interval for true average on z interval
# NOTE: Use two-tale if question just asks for range (ie. confidence interval)
# PARAMETERS:
# alpha: decimal-percent
# xbar: sample average
# n: sample size
# sigma: std deviation
# one_tail: TRUE for one-tail test, FALSE for two-tail test.
z_interval_formula = function(alpha, xbar, n, sigma, one_tail) {
  
  if (one_tail == TRUE) {
    z_value = 1 - alpha
  } else {
    z_value = (1 - alpha) / 2
  }
  
  z_value_critical = abs(qnorm(z_value))
  std_error = sigma / sqrt(n)
  
  margin_of_error = z_value_critical * std_error
  
  upper_confidence_bound = xbar + margin_of_error
  lower_confidence_bound = xbar - margin_of_error
  
  return(list(
    Zcritical = z_value_critical,
    MarginError = margin_of_error,
    LCB = lower_confidence_bound,
    UCB = upper_confidence_bound
  ))
}

# Returns confidence interval for true average on student t interval
# NOTE: Use when only sample standard deviation is known (s)
# PARAMETERS:
# alpha: percent confidence as decimal
# df: degrees freedom (sample size - 1)
# xbar: sample mean
# n: sample size
# s: standard deviation
# one_tail: TRUE for one-tail test, FALSE for two-tail test.
t_interval_formula = function(alpha, df, xbar, n, s, one_tail) {
  if (one_tail == TRUE) {
    t_crit = abs(qt(1 - alpha, df))
  } else {
    t_crit = abs(qt((1 - alpha)/ 2, df))
  }
  
  std_error = s / sqrt(n)
  margin_of_error = t_crit * std_error
  upper_confidence_bound = xbar + margin_of_error
  lower_confidence_bound = xbar - margin_of_error
  
  return(list(
    Tcritical = t_crit,
    MarginOfError = margin_of_error,
    LCB = lower_confidence_bound,
    UCB = upper_confidence_bound
  ))
}

# DESCRIPTION:
# Approximate confidence bound with proportions (Using Wald Method)
# One tailed gives more detailed increase/decrease info
# Use when specifically looking for limit bounds
# Two tailed is broader and only shows a 'change'
# Use when focas is on range or any difference in value
# PARAMETERS:
# phat: The sample proportion as a decimal
# alpha: confidence level as decimal
# n: sample size
# one_tail: TRUE for one-tail test, FALSE for two-tail test
std_norm_approx = function(phat, alpha, n, one_tail) {
  # Get absolute value of left(one tail) critical z value
  if (one_tail == TRUE) {
    crit_z = abs(qnorm(1 - alpha))
  } else {
    crit_z = abs(qnorm((1 - alpha)/2))
  }
  
  std_error = sqrt((phat*(1-phat)) / n)
  margin_of_error = crit_z * std_error
  
  lower_confidence_bound = phat - margin_of_error
  upper_confidence_bound = phat + margin_of_error
  
  return(list(
    Zcritical = crit_z,
    MarginOfError = margin_of_error,
    LCB = lower_confidence_bound,
    UCB = upper_confidence_bound
  ))
}

prediction_interval_t = function(alpha, xbar, n, s) {
  df = n-1 # degrees of freedom
  t_crit = qt((1-alpha)/2,df)
  
  std_error = sqrt(1 + (1/n))
  margin_of_error = t_crit * s * std_error
  upper_predict_bound = xbar + margin_of_error
  lower_predict_bound = xbar - margin_of_error
  
  return(list(
    Tcritical = t_crit,
    MarginOfError = margin_of_error,
    UPB = upper_predict_bound,
    LPB = lower_predict_bound
  ))
}

confidence_for_sigma_variance = function(alpha, n, var) {
  df = n-1
  chi2_critical_upper = qchisq((1-alpha),df)
  chi2_critical_lower = qchisq(alpha,df)
  
  upper_variance = (n-1)*var / chi2_critical_upper
  lower_variance = (n-1)*var / chi2_critical_lower
  
  upper_std_deviation = sqrt(upper_variance)
  lower_std_deviation = sqrt(lower_variance)
  
  return(list(
    UpperVarianceBound = upper_variance,
    LowerVarianceBound = lower_variance,
    UpperStdDeviation = upper_std_deviation,
    LowerStdDeviation = lower_std_deviation
  ))
}

# Chapter 8 helper functions: --------------------------------------------------

# mue repreasents the greek letter meaning average
calculate_type_2_err_z_test = function(
    alpha, 
    mue_null, 
    mue_alt, 
    sample_size, 
    std_deviation
  ) {
  
    std_error = std_deviation / sqrt(sample_size)
  
    critical_c = qnorm(alpha,mue_null,std_error)
    z_score = (critical_c - mue_alt) / std_error
    
    area_left = pnorm(z_score)
    area_right = 1-area_left
    
    return(list(
      Ccritical = critical_c,
      Zscore = z_score,
      AreaLeft = area_left,
      AreaRight_COMMON_ANS = area_right
    ))
}

# Returns the converted z-score, area left of z-score, area right of z-score.
calculate_z_test = function(point, mean, sigma, sample_size) {
  numerater = point - mean
  std_error = sigma / sqrt(sample_size)
  z_score = numerater / std_error
  
  area_to_left = pnorm(z_score)
  area_to_right = 1 - area_to_left
  
  return(list(
    Zscore = z_score,
    AreaLeft = area_to_left,
    AreaRight = area_to_right
  ))
}

calculate_t_test = function(
    xbar, 
    mue, 
    sample_deviation, 
    sample_size, 
    critical_t_value
  ) {
  
  denominator = sample_deviation / sqrt(sample_size)
  numerater = xbar - mue
  t_score = numerater / denominator
  
  if (t_score > critical_t_value || t_score < -(critical_t_value)) {
    reject_null_hyp = TRUE
  } else {
    reject_null_hyp = FALSE
  }
  
  return(list(
    Tscore = t_score,
    DecisionValue = critical_t_value,
    RejectNullHyp = reject_null_hyp
  ))
}

