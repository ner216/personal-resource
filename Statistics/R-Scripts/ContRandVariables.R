# Chapter 5-6 helper functions
#
# Created By: Nolan Provencher
# 
# source("/path/to/file")

# ------------------------------------------------------------------------------
# First parameter is the function of x and y to integrate.
#   Ex. test_func = function(x,y){x^2 + y^2}
# Returns the value of the calculated definite integral
IntegrateDouble = function(f, y_lower, y_upper, x_lower, x_upper) {
  # First define inner integral with function
  inner_integral = function(x) {
    # Define integrand
    integrand_g = function(y) {
      f(x,y)
    }
    # Perform inner integration with respect to y
    # Since integrate() returns a list, we need the value field
    integrate(integrand_g, lower=y_lower, upper=y_upper)$value
  }
  
  # Now ensure that the inner integral is vectorized
  vectorized_inner_integral <- Vectorize(inner_integral)
  
  # At last, perform outer integration with respect to x
  final_result <- integrate(vectorized_inner_integral, lower=x_lower, upper=x_upper)$value
  
  return(final_result)
}

# ------------------------------------------------------------------------------
# Perform a partial integration of a function of x,y
# Takes a function of x and y of the R function data type
IntegratePartial = function(func, y_value, lower_bound, upper_bound) {
  
  integrand_x = function(x) {
    return(func(x, y_value))
  }
  
  result = integrate(f = integrand_x, lower = lower_bound, upper = upper_bound)
  return(result)
}

# ------------------------------------------------------------------------------
# This function outputs the expected value and variance of a given function f
# Parameters:
# f: single variable (Probability Density Function) (R function type)
# lower_bound: lower bound of integration
# upper_bound: upper bound of integration
# NOTES:
# Output Restult variable should be 1 for a valid PDF
IntegrateSingle = function(f, lower_bound, upper_bound) {
  # Create expected value functions
  EX = function(x){return(f(x) * x)}
  EXSQR = function(x){return(f(x) * x^2)}
  # Calculate plain result
  X_result = integrate(f, lower=lower_bound, upper=upper_bound)$value
  # Integrate expected value
  EX_result = integrate(EX,lower = lower_bound,upper = upper_bound)$value
  EXSQR_result = integrate(EXSQR,lower = lower_bound,upper = upper_bound)$value
  # Calculate variance
  VX_result = EXSQR_result - (EX_result^2)
  
  return(list(
    Result = X_result,
    Expected = EX_result, 
    Variance = VX_result
    ))
}

# ------------------------------------------------------------------------------
# Takes the joint pdf as function f(x,y)
# Returns joint expectation and marginal expectations for X and Y
JointExpected = function(f, y_lower, y_upper, x_lower, x_upper) {
  # func for joint expectation
  EXY = function(x,y) {return(f(x,y) * (x*y))}
  # func for marginal expectation of x
  EX = function(x,y) {return(f(x,y) * x)}
  # func for marginal expectation of y
  EY = function(x,y) {return(f(x,y) * y)}
  
  # Results of integration
  EXY_result = IntegrateDouble(EXY,y_lower,y_upper,x_lower,x_upper)
  EX_result = IntegrateDouble(EX,y_lower,y_upper,x_lower,x_upper)
  EY_result = IntegrateDouble(EY,y_lower,y_upper,x_lower,x_upper)
  
  return(list(
    Joint = EXY_result,
    MarginalX = EX_result,
    MarginalY = EY_result
    ))
}

# ------------------------------------------------------------------------------
# Takes a joint pdf of f(x,y) as a R function type
# returns the calculated marginal variances of X and Y
Variance = function(f, y_lower, y_upper, x_lower, x_upper) {
  # Calculate marginal variance for X
  EX2 = function(x,y){return(f(x,y)*(x^2))}
  EX = function(x,y){return(f(x,y)*x)}
  EX2_result = IntegrateDouble(EX2, y_lower, y_upper, x_lower, x_upper)
  EX_result = IntegrateDouble(EX, y_lower, y_upper, x_lower, x_upper)
  # Use variance formula V(X)=E(X^2)*[E(X)^2]
  VX_result = EX2_result - (EX_result^2)
  
  # Calculate marginal variance for Y
  EY2 = function(x,y){return(f(x,y)*(y^2))}
  EY = function(x,y){return(f(x,y)*y)}
  EY2_result = IntegrateDouble(EY2, y_lower, y_upper, x_lower, x_upper)
  EY_result = IntegrateDouble(EY, y_lower, y_upper, x_lower, x_upper)
  # Use variance formula V(Y)=E(Y^2)*[E(Y)^2]
  VY_result = EY2_result - (EY_result^2)
  
  # Return marginal variance results
  return(list(
    VarX = VX_result,
    VarY = VY_result
  ))
}

# ------------------------------------------------------------------------------
# Takes a joint pdf of f(x,y) as well as integral bounds
# Returns calculated covariance of X and Y
Covariance = function(f, y_lower, y_upper, x_lower, x_upper) {
  # Get expected values form JointExpected()
  expected = JointExpected(f, y_lower, y_upper, x_lower, x_upper)
  
  # Return covariance using shortcut Cov(X,Y)=(E[X,Y]-(E[X]*E[Y]))
  cov_result = (expected$Joint - (expected$MarginalX * expected$MarginalY))
  return(cov_result)
}

# ------------------------------------------------------------------------------
# Takes a joint pdf of f(x,y) as an R function type
# Returns the calculated correlation of X and Y
Correlate = function(f, y_lower, y_upper, x_lower, x_upper) {
  var = Variance(f, y_lower, y_upper, x_lower, x_upper)
  cov = Covariance(f, y_lower, y_upper, x_lower, x_upper)
  corr = cov / (sqrt(var$VarX * var$VarY))
  return(corr)
}

# ------------------------------------------------------------------------------
SumLog = function(vec) {
  sum_vec = sum(vec)
  sum_log_vec = sum(log(vec))
  
  return(list(Sum = sum_vec, SumLog = sum_log_vec))
}

# ------------------------------------------------------------------------------
EstimateParam <- function(x, 
                           mean_theoretical,    # function(theta) returning E[X]
                           log_likelihood_fun,  # function(theta, x) returning log-likelihood
                           theta_init = 1,      # initial guess for numerical methods
                           theta_bounds = c(-1e3, 1e3)) {
  
  stopifnot(is.numeric(x), length(x) > 1)
  
  # ---- Method of Moments Estimator ----
  xbar <- mean(x)
  f_mme <- function(theta) mean_theoretical(theta) - xbar
  
  theta_mme_num <- tryCatch(
    uniroot(f_mme, interval = theta_bounds)$root,
    error = function(e) NA
  )
  
  # ---- Maximum Likelihood Estimator ----
  neg_loglik <- function(theta) -log_likelihood_fun(theta, x)
  theta_mle_num <- tryCatch(
    optim(par = theta_init, fn = neg_loglik)$par,
    error = function(e) NA
  )
  
  # ---- Return results ----
  list(
    sample_mean = xbar,
    theta_MME_numeric = theta_mme_num,
    theta_MLE_numeric = theta_mle_num
  )
}

# ------------------------------------------------------------------------------
PlotLiklyhood <- function(x) {
  n <- length(x)
  theta_vals <- seq(-0.9, 10, length.out = 500)
  loglik_vals <- n * log(theta_vals + 1) + theta_vals * sum(log(x))
  plot(theta_vals, loglik_vals, type = "l", lwd = 2,
       xlab = expression(theta), ylab = "Log-Likelihood",
       main = "Log-Likelihood for f(x; θ) = (θ+1)x^θ")
  abline(v = -1 - n / sum(log(x)), col = "red", lwd = 2, lty = 2)
}
