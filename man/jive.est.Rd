\name{jive.est}
\alias{jive.est}
\title{The Jackknife Instrumental Variable Estimator (JIVE).}
\description{Compute the JIVE for a multiple regression, as well
  as the set of standard errors for the individual vector entries, and
  the estimate of the asymptotic variance/covariance matrix.}
\usage{
  jive.est(y,X,Z,SE=FALSE,n.bt=100)
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
     standard errors of the individual JIVE estimators, and a bootstrap
     estimate of its asymptotic variance/covariance matrix.}
  \item{n.bt}{Numeric: The number of bootstrap samples performed for
    estimating the variance/covariance matrix.
    This automatically occurs, whenever the user selects the
    SE to be true.}
}
\details{
  The JIVE was originally introduced by Angrist et al. (1995), in order to reduce the finite-sample
  bias of the TSLS estimator, when applied to a large number of
  instruments. Indeed, the TSLS estimator tends to behave poorly as the
  number of instruments increases. We briefly outline this method. See
  Angrist et al. (1999) for an exhaustive description.

  The model is identical to the one used in the rest of this package. That is,
  the second-stage equation is modelled as \eqn{y = X\beta + \epsilon,}
  in which \eqn{y} is a vector of \eqn{n} observations representing the
  outcome variable, \eqn{X} is a matrix of order \eqn{n\times k}
  denoting the predictors of the model, and comprised of both exogenous
  and endogenous variables, \eqn{\beta} is the \eqn{k}-dimensional
  vector of parameters of interest; whereas \eqn{\epsilon} is an unknown
  vector of error terms.
  Moreover, the first-stage level of the model is given by a multivariate
  multiple regression. That is, this is a linear modle with a
  \emph{multivariate} outcome variable, as well as \emph{multiple}
  predictors. This first-stage model is represented in this manner, 
  \eqn{X = Z\Gamma + \Delta},
  where \eqn{X} is the matrix of predictors from the second-stage
  equation, \eqn{Z} is a matrix of instrumental variables (IVs) of order
  \eqn{n \times l}, \eqn{\Gamma} is a matrix of unknown parameters of
  order \eqn{l\times k}; whereas \eqn{\Delta} denotes an unknown matrix of order
  \eqn{n\times k} of error terms. 

  For computing the JIVE, we first consider the estimator of the
  regression parameter in the first-stage equation, which is denoted by  
     \deqn{\hat\Gamma := ({Z}^{T}{Z})^{-1}({Z}^{T}{X}).}
  This matrix is of order \eqn{l\times k}. The matrix of predictors, \eqn{{X}}, projected
  onto the column space of the instruments is then given by
  \eqn{\hat{X}={Z}\hat\Gamma}. The JIVE proceeds by
  estimating each row of \eqn{\hat{X}} without using the corresponding data
  point. That is, the \eqn{i}th row in the jackknife matrix, \eqn{\hat{X}_{J}},
  is estimated without using the \eqn{i}th row of \eqn{{X}}.
  This is conducted as follows. For every \eqn{i=1,\ldots,n}, we first compute
  \deqn{\hat\Gamma_{(i)} :=
    ({Z}_{(i)}^{T}{Z}_{(i)})^{-1}({Z}_{(i)}^{T}{X}_{(i)}),}  
  where \eqn{{Z}_{(i)}} and \eqn{{X}_{(i)}} denote matrices \eqn{{Z}} and \eqn{{X}} after
  removal of the \eqn{i}th row, such that these two matrices are of order
  \eqn{(n-1)\times l} and \eqn{(n-1)\times k}, respectively. Then, the
  matrix \eqn{\hat{X}_{J}} is constructed by stacking these jackknife
  estimates of \eqn{\hat\Gamma}, after they have been pre-multiplied by the
  corresponding rows of \eqn{{Z}}, 
      \deqn{\hat{X}_{J} :=
	({z}_{1}\hat\Gamma_{(1)},\ldots,{z}_{n}\hat\Gamma_{(n)})^{T},}     
  where each \eqn{{z}_{i}} is an \eqn{l}-dimensional row vector. The JIVE
estimator is then obtained by replacing \eqn{\hat{X}} with
\eqn{\hat{X}_{J}} in the standard formula of the TSLS, such that 
\deqn{\hat\beta_{J} := (\hat{X}_{J}{}^{T}{X})^{-1}(\hat{X}_{J}{}^{T}{y}).}
In this package, we have additionally made use of the computational
formula suggested by Angrist et al. (1999), in which each row of
\eqn{\hat{X}_{J}} is calculated using 
\deqn{{z}_{i}\hat\Gamma_{(i)} = \frac{{z}_{i}\hat\Gamma -
    h_{i}{x}_{i}}{1-h_{i}},}
where \eqn{{z}_{i}\hat\Gamma_{(i)}}, \eqn{{z}_{i}\hat\Gamma} and
\eqn{{x}_{i}} are \eqn{k}-dimensional row vectors; and with \eqn{h_{i}} denoting
the leverage of the corresponding data point in the first-level
equation of our model, such that each \eqn{h_{i}} is defined as
\eqn{{z}_{i}({Z}^{T}{Z})^{-1}{z}_{i}^{T}}.
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
Angrist, J., Imbens, G., and Krueger, A.B. (1995). Jackknife instrumental variables esti-
mation. Technical Working Paper 172, National Bureau of Economic
Research.

Angrist, J.D., Imbens, G.W., and Krueger, A.B. (1999). Jackknife instrumental variables
estimation. Journal of Applied Econometrics, 14(1), 57--67.
}
\examples{

### Generate a simple example with synthetic data, and no intercept. 
n <- 100; k <- 3; l <- 3;
Ga<- diag(rep(1,l)); be <- rep(1,k);
Z <- matrix(0,n,l); for(j in 1:l) Z[,j] <- rnorm(n); 
X <- matrix(0,n,k); for(j in 1:k) X[,j] <- Z[,j]*Ga[j,j] + rnorm(n); 
y <- X\%*\%be + rnorm(n);

### Compute JIVE estimator with SEs and variance/covariance matrix.
print(jive.est(y,X,Z))
print(jive.est(y,X,Z,SE=TRUE));

}
\keyword{ols.est}
\keyword{tsls.est}
\keyword{sps.est}
