\name{sps.est}
\alias{sps.est}
\title{Semi-parametric Stein-like (SPS) estimator.}
\description{Computes the SPS estimator for a two-stage structural model, as well
     as the set of standard errors for each individual estimator, and
     the sample estimate of the asymptotic variance/covariance matrix.}
\usage{
  sps.est(y,X,Z,SE=FALSE,ALPHA=TRUE,REF="TSLS",n.bt=100,n.btj=10)
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
     standard errors of the individual SPS estimators, and a sample (or
     bootstrap, if JIVE is selected as a reference estimator)
     estimate of its asymptotic variance/covariance matrix.}
  \item{ALPHA}{Logical: If TRUE, the function returns the value of the
     sample estimate of the parameter controlling the respective
     contribution of the \emph{reference} estimator (by default, this is the TSLS
     estimator), and the one of the \emph{alternative} estimator (by
     default, this is the OLS estimator).}
  \item{REF}{Character: Controls the choice of the \emph{reference}
    estimator in the SPS framework. This can accept two values: "TSLS" or "JIVE",
    with the former being the default option. The \emph{alternative}
    estimator is always the OLS estimator.}   
  \item{n.bt}{Numeric: The number of bootstrap samples performed, when
    the sample variance/covariance matrix is estimated using the
    bootstrap. This automatically occurs, whenever the user selects the
    JIVE as the reference estimator.}
  \item{n.btj}{Numeric: The number of boostrap iterations performed, when
    computing the SPS estimator, when using the JIVE as reference
    estimator. This option is only relevant, when JIVE has   
    been selected as the reference estimator. These iterations are used
    to compute the various components entering in the calculation of the
    SPS estimator.}  
}
\details{
  The SPS estimator is applied to a two-stage structural
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
     \deqn{X = Z\Gamma + \Delta,}
  where \eqn{X} is the matrix of predictors from the second-stage
  equation, \eqn{Z} is a matrix of instrumental variables (IVs) of order
  \eqn{n \times l}, \eqn{\Gamma} is a matrix of unknown parameters of
  order \eqn{l\times k}; whereas \eqn{\Delta} denotes an unknown matrix of order
  \eqn{n\times k} of error terms. 

  As for the TSLS estimator, whenever certain variables in \eqn{X} are
  assumed to be exogenous, these variables should be incorporated into 
  \eqn{Z}. That is, all the exogneous variables are their own
  instruments. Moreover, it is also assumed that the model contains at
  least as many instruments as predictors, in the sense that \eqn{l\geq
    k}, as commonly donein practice (Wooldridge, 2002). Also, the matrices,
  \eqn{X^TX}, \eqn{Z^TX}, and \eqn{Z^TZ} are all assumed to be full
  rank. Finally, both \eqn{X} and \eqn{Z} should comprise a column of
  one's, representing the intercept in each structural equation. 

  The formula for the SPS estimator is then obtained as a weigthed
  combination of the OLS and TSLS estimators (using the default
  options), such that 
  \deqn{\hat\beta_{SPS}(\alpha) :=
      \alpha\hat\beta_{OLS} + (1-\alpha)\hat\beta_{TSLS},}
  for every \eqn{\alpha}. The \emph{proportion parameter}, \eqn{\alpha},
  controls the respective contributions of the OLS and TSLS estimators. 
  (Despite our choice of name, however, note that \eqn{\alpha} needs not be bounded
  between 0 and 1.) This parameter is selected in order to minimize the
  trace of the theoretical MSE of the corresponding SPS estimator,
  \deqn{MSE(\hat\beta_{SPS}(\alpha)) 
      = E[(\bar\beta(\alpha)-\beta)(\hat\beta(\alpha)-\beta)^{T}] 
      = Var(\hat\beta(\alpha)) + Bias^{2}(\hat\beta(\alpha)),}
  where \eqn{\beta\in R^{k}} is the true parameter of interest and the MSE is
  a \eqn{k\times k} matrix. It is particularly appealing to combine these
  two estimators, because the asymptotic unbiasedness of the TSLS
  estimator guarantees that the resulting SPS is asymptotically
  unbiased. Thus, the MSE automatically strikes a trade-off between the
  unbiasedness of the TSLS estimator and the efficiency of the OLS
  estimator.   
}
\value{
  \item{list}{A list with one or four arguments, depending on whether
     the user has activated the SE flag, and the ALPHA flag. The first
     element (est) in the list    
     is the SPS estimate of the model in vector format. The second
     element (se) is the vector of standard errors; the third
     element (var) is the sample estimate of the asymptotic
     variance/covariance matrix; the fourth element (alpha) is a real
     number representing the estimate of the contribution of the OLS to
     the combined SPS estimator.}
}
\author{
   Cedric E. Ginestet <cedric.ginestet@kcl.ac.uk>
}
\references{
Judge, G.G. and Mittelhammer, R.C. (2004). A semiparametric basis for combining esti-
mation problems under quadratic loss. Journal of the American Statistical Association,
99(466), 479--487.

Judge, G.G. and Mittelhammer, R.C. (2012a). An information theoretic approach to econo-
metrics. Cambridge University Press.

Judge, G. and Mittelhammer, R. (2012b). A risk superior semiparametric estimator for
over-identified linear models. Advances in Econometrics, 237--255.

Judge, G. and Mittelhammer, R. (2013). A minimum mean squared error semiparametric
combining estimator. Advances in Econometrics, 55--85.

Mittelhammer, R.C. and Judge, G.G. (2005). Combining estimators to improve structural
model estimation and inference under quadratic loss. Journal of econometrics, 128(1),
1--29.
}
\examples{

### Generate a simple example with synthetic data, and no intercept. 
n <- 100; k <- 3; l <- 3;
Ga<- diag(rep(1,l)); be <- rep(1,k);
Z <- matrix(0,n,l); for(j in 1:l) Z[,j] <- rnorm(n); 
X <- matrix(0,n,k); for(j in 1:k) X[,j] <- Z[,j]*Ga[j,j] + rnorm(n); 
y <- X\%*\%be + rnorm(n);

### Compute SPS estimator with SEs and variance/covariance matrix.
print(sps.est(y,X,Z))
print(sps.est(y,X,Z,SE=TRUE));

}
\keyword{ols.est}
\keyword{tsls.est}
