\name{ols.est}
\alias{ols.est}
\title{The Ordinary Least Squares (OLS) Estimator.}
\description{Compute the OLS estimator of a multiple regression, as well
  as the set of standard errors for the individual vector entries, and
  the estimate of the asymptotic variance/covariance matrix.}
\usage{
  ols.est(y,X,SE=FALSE)
}
\arguments{
   \item{y}{Numeric: A vector of observations, representing the outcome variable.}
  \item{X}{Numeric: A matrix of observations, whose number of columns
    corresponds to the number of predictors in the model, and the number
    of rows should be conformal with the number of entries in \eqn{y}. This
    matrix may contain both endogenous and exogenous variables.}
  \item{SE}{Logical: If TRUE, then the function also returns the
     standard errors of the individual TSLS estimator, and a sample
     estimate of its asymptotic variance/covariance matrix.}
}
\details{
  The OLS estimator is computed for a standard one-stage structural
  model. We here adopt the terminology commonly used in
  econometrics. See, for example, the references below for Cameron 
  and Trivedi (2005), Davidson and MacKinnon (1993), as well as
  Wooldridge (2002). The second-stage equation is thus modelled as follows,
     \deqn{y = X\beta + \epsilon,}
  in which \eqn{y} is a vector of \eqn{n} observations representing the
  outcome variable, \eqn{X} is a matrix of order \eqn{n\times k}
  denoting the predictors of the model, and comprised of both exogenous
  and endogenous variables, \eqn{\beta} is the \eqn{k}-dimensional
  vector of parameters of interest; whereas \eqn{\epsilon} is an unknown
  vector of error terms. The formula for the OLS estimator is then
  obtained in the standard fashion by the following equation,
     \deqn{\hat\beta_{OLS} := (X^TX)^{-1}(X^{T}y),}
  with variance/covariance matrix given by
      \deqn{\hat\Sigma_{OLS} := \hat\sigma^{2}(X^{T}X)^{-1},}
  in which the sample residual sum of squares is
  \eqn{\hat\sigma^{2}:=(y - X\hat\beta_{OLS})^{T}(y -
    X\hat\beta_{OLS})/(n-k)}.
}
\value{
  \item{list}{A list with one or three arguments, depending on whether
     the user has activated the SE flag. The first element (est) in the list
     is the TSLS estimate of the model in vector format. The second
     element (se) is the vector of standard errors; and the third
     element (var) is the sample estimate of the asymptotic
     variance/covariance matrix.}
}
\author{
   Cedric E. Ginestet <cedric.ginestet@kcl.ac.uk>
}
\references{
Cameron, A. and Trivedi, P. (2005). Microeconometrics: Methods and Applications. Cam-
bridge University press, Cambridge.

Davidson, R. and MacKinnon, J.G. (1993). Estimation and inference in econometrics. OUP
Catalogue.
  
Wooldridge, J. (2002). Econometric analysis of cross-section and panel data. MIT press,
London.
}
\examples{

### Generate a simple example with synthetic data, and no intercept. 
n <- 100; k <- 3; l <- 3;
Ga<- diag(rep(1,l)); be <- rep(1,k);
Z <- matrix(0,n,l); for(j in 1:l) Z[,j] <- rnorm(n); 
X <- matrix(0,n,k); for(j in 1:k) X[,j] <- Z[,j]*Ga[j,j] + rnorm(n); 
y <- X\%*\%be + rnorm(n);

### Compute OLS estimator with SEs and variance/covariance matrix.
print(ols.est(y,X))
print(ols.est(y,X,SE=TRUE))

}
\keyword{tsls.est}
\keyword{sps.est}
