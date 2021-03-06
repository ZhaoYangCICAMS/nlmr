% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/piecewise.R
\name{piecewise_mr}
\alias{piecewise_mr}
\title{Instrumental variable analysis using a piecewise linear function}
\usage{
piecewise_mr(y, x, g, covar = NULL, family = "gaussian", q = 10,
  xpos = "mean", nboot = 100, fig = T, ref = mean(x), pref_x = "x",
  pref_x_ref = "x", pref_y = "y", ci_quantiles = 10, breaks = NULL)
}
\arguments{
\item{y}{vector of outcome values.}

\item{x}{vector of exposure values.}

\item{g}{the instrumental variable.}

\item{covar}{data.frame of covariates.}

\item{family}{a description of the error distribution and link function to be used in the model. For frac_poly_mr this can be a character string naming either the gaussian (i.e. for continuous data) or binomial (i.e. for binary data) family function.}

\item{q}{the number of quantiles the exposure distribution is to be split into. Within each quantile a causal effect will be fitted, known as a localised average causal effect (LACE). The default is deciles (i.e. 10 quantiles).}

\item{nboot}{the number of bootstrap replications (if required). The default is 100 replications.}

\item{fig}{a logical statement as to whether the user wants the results displayed in a figure. The default is false.}

\item{ref}{the reference point for the figure. This is the value of the function that represents the expected difference in the outcome compared with this reference value when the exposure is set to different values. The default is the mean of x.}

\item{pref_x}{the prefix/label for the x-axis. The default is "x".}

\item{pref_x_ref}{the prefix for the reference value displayed on the y-axis. The default is "x".}

\item{pref_y}{the prefix/label for the y-axis. The default is "y".}

\item{ci_quantiles}{the number of quantiles at which confidence intervals are to be displayed. The default is deciles (i.e. 10).}

\item{breaks}{breaks on the y-axis of the figure.}
}
\value{
List of non-linear MR results from the piecewise MR approach.

\item{n}{number of individuals.}

\item{model}{the model specifications. The first column is the number of quantiles (q); the second column is the number of bootstrap replications performed (nboot).}

\item{coefficients}{the regression estimates. The first column is the regression coefficients (beta); the second column is the standard errors of regression coefficients (se); the third column is the lower confidence interval (lci); the fourth column is the upper confidence interval (uci); the fifth column is the p-value (pval).}

\item{lace}{the localised average causal effect estimate in each quantile. The first column is the regression coefficients (beta); the second column is the standard errors of the regression coefficients (se).}

\item{xcoef}{the association between the instrument and the exposure in each quantile. The first column is the regression coefficients (beta); the second column is the standard errors of regression coefficients (se).}

\item{p_tests}{the p-value of the non-linearity tests. The first column is the p-value of the test between the fractional polynomial degrees (fp_d1_d2); the second column is the p-value from the fractional polynomial non-linearity test (fp); the third column is the p-value from the quadratic test (quad); the fourth column is the p-value from the Cochran Q test (Q).}

\item{p_heterogeneity}{the p-value of heterogeneity. The first column is the p-value of the Cochran Q heterogeneity test (Q); the second column is the p-value from the trend test (trend).}
}
\description{
piecewise_mr performs instumental variable analysis by fitting a piecewise linear function to localised average causal effects.
}
\examples{
### IV (g), exposure (x) & outcome (y)
epsx = rexp(10000)
u = runif(10000, 0, 1)
g = rbinom(10000, 2, 0.3)
epsy = rnorm(10000)
ag = 0.25
x = 1 + ag*g + u + epsx
y = 0.15*x^2 + 0.8*u + epsy

### Covariates (c)
c1 = rnorm(10000)
c2 = rnorm(10000)
c3 = rbinom(10000,2,0.33)
c = data.frame(c1=c1, c2=c2, c3=as.factor(c3))

### Analyses
fp = fracpoly_mr(y, x, g, c, family="gaussian", q=10, d=1, ci="model_se", fig=T)
summary(fp)
plm = piecewise_mr(y, x, g, c, family="gaussian", q=10, nboot=100, fig=T)
summary(plm)
}
\author{
James R Staley <jrstaley95@gmail.com>
}
