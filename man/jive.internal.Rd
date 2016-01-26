\name{jive.internal}
\alias{jive.internal}
\title{Internal function for the Jackknife Instrumental Variable Estimator (JIVE).}
\description{Compute the JIVE for a multiple regression}
\usage{
  jive.internal(y,X,Z)
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
}
\details{
  See documentaion for the jive.est function. Users should use the
  jive.est function, instead. 
}
\value{
  \item{B}{A vector of estimates for the coefficients of interest.}
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
\keyword{JIVE}
