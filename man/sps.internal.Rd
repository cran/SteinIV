\name{sps.internal}
\alias{sps.internal}
\title{Internal function for Semi-parametric Stein-like (SPS) estimator.}
\description{Computes the SPS estimator for a two-stage structural model, as well
     as a sample estimate of the alpha parameter controlling the degree
     of combination between the OLS and TSLS estimators.}
\usage{
  sps.internal(y,X,Z,REF="TSLS",ALPHA=FALSE,n.btj=10)
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
  \item{REF}{Character: Controls the choice of the \emph{reference}
    estimator in the SPS framework. This can accept two values: "TSLS" or "JIVE",
    with the former being the default option. The \emph{alternative}
    estimator is always the OLS estimator.}   
  \item{ALPHA}{Logical: If TRUE, the function returns the value of the
     sample estimate of the parameter controlling the respective
     contribution of the \emph{reference} estimator (by default, this is the TSLS
     estimator), and the one of the \emph{alternative} estimator (by
     default, this is the OLS estimator).}
  \item{n.btj}{Numeric: The number of boostrap iterations performed, when
    computing the SPS estimator, when using the JIVE as reference
    estimator. This option is only relevant, when JIVE has   
    been selected as the reference estimator. These iterations are used
    to compute the various components entering in the calculation of the
    SPS estimator.}  
}
\details{
  See documentaion for the sps.est function. Users should use the
  sps.est function, instead. 
}
\value{
  \item{list}{The first term (est) is a vector of estimates for the
    coefficients of interest, and the second term (alpha) representing
    the estimate of the contribution of the OLS to the combined SPS
    estimator.} 
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
