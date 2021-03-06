% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/OOBCurvePars.R
\name{OOBCurvePars}
\alias{OOBCurvePars}
\title{OOBCurvePars}
\usage{
OOBCurvePars(lrn, task, pars = c("mtry"), nr.grid = 10, par.vals = NULL,
  measures = list(auc))
}
\arguments{
\item{lrn}{The learner created with \code{\link[mlr]{makeLearner}}. Currently only \code{\link[ranger]{ranger}} is supported. 
num.trees has to be set sufficiently high to produce smooth curves.}

\item{task}{Learning task created by the function \code{\link[mlr]{makeClassifTask}} or \code{\link[mlr]{makeRegrTask}} of \href{https://github.com/mlr-org/mlr}{mlr}.}

\item{pars}{One of the hyperparameter "mtry", "sample.fraction" or "min.node.size".}

\item{nr.grid}{Number of points on hyperparameter space that should be evaluated (distributed equally)}

\item{par.vals}{Optional vector of hyperparameter points that should be evaluated. If set, nr.grid is not used anymore. Default is NULL.}

\item{measures}{List of performance measure(s) of mlr to evaluate. Default is mmce for classification and mse for regression.
See the \href{https://mlr-org.github.io/mlr/articles/measures.html}{mlr tutorial} for a list of available measures 
for the corresponding task.}
}
\value{
Returns a list with parameter values and a list of performances.
}
\description{
With the help of this function the out of bag curves for parameters like mtry, sample.fraction and 
min.node.size of random forests can be created for any measure that is available in the mlr package.
}
\examples{
\dontrun{
library(mlr)
task = sonar.task

lrn = makeLearner("classif.ranger", predict.type = "prob", num.trees = 1000)
results = OOBCurvePars(lrn, task, measures = list(auc))
plot(results$par.vals, results$performances$auc, type = "l", xlab = "mtry", ylab = "auc")

lrn = makeLearner("classif.ranger", predict.type = "prob", num.trees = 1000, replace = FALSE)
results = OOBCurvePars(lrn, task, pars = "sample.fraction", measures = list(mmce))
plot(results$par.vals, results$performances$mmce, type = "l", xlab = "sample.fract.", ylab = "mmce")

results = OOBCurvePars(lrn, task, pars = "min.node.size", measures = list(mmce))
plot(results$par.vals, results$performances$mmce, type = "l", xlab = "min.node.size", ylab = "mmce")}
}
\seealso{
\code{\link{OOBCurve}} for out-of-bag curves dependent on the number of trees.
}
