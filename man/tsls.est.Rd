\name{tsls.est}
\alias{tsls.est}
\title{The Two-Stage Least Squares (TSLS) estimator.}
\description{Computes the TSLS estimator for a two-stage structural model, as well
   as the set of standard errors for each individual estimator, and
   the sample estimate of the asymptotic variance/covariance matrix.}
\usage{
  tsls.est(y,X,Z,SE=FALSE)
}
\arguments{
  \item{y}{Numeric: A vector of observations, representing the outcome variable.}
  \item{X}{Numeric: A matrix of observations, whose number of columns
    corresponds to the number of predictors in the model, and the number
    of rows should be conformal with the number of entries in \eqn{y}. This
    matrix may contain both endogenous and exogenous variables.}
  \item{Z}{Numeric: A matrix of observations representing the
    intrumental variables (IVs) in the first-stage structural equation. The
    number of IVs should be at least as large as the number of
    endogenous variables in \eqn{X}.}
  \item{SE}{Logical: If TRUE, then the function also returns the
     standard errors of the individual TSLS estimator, and a sample
     estimate of its asymptotic variance/covariance matrix.}
}
\details{
  The TSLS estimator is applied to a two-stage structural
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
  vector of error terms.

  The first-stage level of the model is given by a multivariate
  multiple regression. That is, this is a linear modle with a
  \emph{multivariate} outcome variable, as well as \emph{multiple}
  predictors. This first-stage model is represented in this manner, 
     \deqn{X = Z\Gamma + \Delta},
  where \eqn{X} is the matrix of predictors from the second-stage
  equation, \eqn{Z} is a matrix of instrumental variables (IVs) of order
  \eqn{n \times l}, \eqn{\Gamma} is a matrix of unknown parameters of
  order \eqn{l\times k}; whereas \eqn{\Delta} denotes an unknown matrix of order
  \eqn{n\times k} of error terms. 

  Whenever certain variables in \eqn{X} are assumed to be exogenous,
  these variables should be incorporated into 
  \eqn{Z}. That is, all the exogneous variables are their own
  instruments. Moreover, it is also assumed that the model contains at
  least as many instruments as predictors, in the sense that \eqn{l\geq
    k}, as commonly donein practice (Wooldridge, 2002). Also, the matrices,
  \eqn{X^TX}, \eqn{Z^TX}, and \eqn{Z^TZ} are all assumed to be full
  rank. Finally, both \eqn{X} and \eqn{Z} should comprise a column of
  one's, representing the intercept in each structural equation. 

  The formula for the TSLS estimator is then obtained in the standard
  fashion by the following equation,
     \deqn{\hat\beta_{TSLS} := (\hat{X}^T\hat{X})^{-1}(\hat{X}^{T}y),}
  where \eqn{\hat{X}:=H_zX}, is the orthogonal projection of the matrix
  \eqn{X}, onto the vector space spanned by the columns of \eqn{Z}; and
  \eqn{H_{z}:=Z(Z^{T}Z)^{-1}Z^{T}} is the hat matrix of the first-stage
  multivariate regression.

  When requested by the user, the standard errors of each entry in
  \eqn{\hat\beta_{TSLS}} are also provided, as a vector. These are
  computed by taking the squareroot of the diagonal entries of the sample asymptotic
  variance/covariance matrix, which is given by the following equation,
     \deqn{\hat\Sigma_{TSLS} := \hat\sigma^{2}(\hat{X}^{T}\hat{X})^{-1},}
  in which the sample residual sum of squares is
  \eqn{\hat\sigma^{2}:=(y - X\hat\beta_{TSLS})^{T}(y - X\hat\beta_{TSLS})/(n-k)}.
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

### Compute TSLS estimator with SEs and variance/covariance matrix.
print(tsls.est(y,X,Z));
print(tsls.est(y,X,Z,SE=TRUE));

}
\keyword{ols.est}
\keyword{sps.est}
