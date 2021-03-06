% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/glmnetLRC.R
\name{glmnetLRC}
\alias{coef.glmnetLRC}
\alias{extract.glmnetLRC}
\alias{glmnetLRC}
\alias{missingpreds.glmnetLRC}
\alias{plot.glmnetLRC}
\alias{predict.glmnetLRC}
\alias{print.glmnetLRC}
\title{Construct a lasso or elastic-net logistic regression classifier (LRC) with an arbitrary loss function}
\usage{
glmnetLRC(truthLabels, predictors, lossMat = "0-1", lossWeight = rep(1,
  NROW(predictors)), alphaVec = seq(0, 1, by = 0.2), tauVec = seq(0.1, 0.9,
  by = 0.05), cvFolds = 5, cvReps = 100, stratify = FALSE,
  masterSeed = 1, nJobs = 1, estimateLoss = FALSE, verbose = FALSE, ...)

\method{print}{glmnetLRC}(x, verbose = TRUE, ...)

\method{plot}{glmnetLRC}(x, ...)

\method{coef}{glmnetLRC}(object, tol = 1e-10, ...)

\method{predict}{glmnetLRC}(object, newdata, truthCol = NULL,
  keepCols = NULL, ...)

\method{missingpreds}{glmnetLRC}(object, newdata, ...)

\method{extract}{glmnetLRC}(object, ...)
}
\arguments{
\item{truthLabels}{A factor with two levels containing the true labels for each
observation. If it is more desirable to correctly predict one of the two classes over the other,
the second level of this factor should be the class you are most interested in
predicting correctly.}

\item{predictors}{A matrix whose columns are the explanatory regression variables.  Note:
factors are not currently supported.  To include a factor variable with \emph{n} levels, it must be represented
as \emph{n-1} dummy variables in the matrix.}

\item{lossMat}{Either the character string \code{"0-1"}, indicating 0-1 loss, or a loss
matrix of class \code{lossMat}, produced by \code{\link{lossMatrix}}, that specifies
the penalties for classification errors.}

\item{lossWeight}{A vector of non-negative weights used to calculate the expected loss. The default value is 1 for
each observation.}

\item{alphaVec}{A sequence in [0, 1] designating possible values for the elastic-net mixing parameter,
\eqn{\alpha}. A value of \eqn{\alpha = 1} is the lasso penalty, \eqn{\alpha = 0} is the ridge penalty.
Refer to \code{\link{glmnet}} for further information.}

\item{tauVec}{A sequence of \eqn{\tau} threshold values in (0, 1) for the
logistic regression classifier. For a new observation, if the predicted probability
that the observation belongs to the second level
of \code{truthLabels} exceeds tau, the observation is classified as belonging
to the second level.}

\item{cvFolds}{The number of cross validation folds.
\code{cvFolds = length(truthLabels)} gives leave-one-out (L.O.O.) cross validation,
in which case \code{cvReps} is set to \code{1} and \code{stratify} is set to \code{FALSE}.}

\item{cvReps}{The number of cross validation replicates, i.e., the number
of times to repeat the cross validation
by randomly repartitioning the data into folds and estimating the tuning parameters.
For L.O.O. cross validation, this argument is set to \code{1} as there can only be one
possible partition of the data.}

\item{stratify}{A logical indicating whether stratified sampling should be used
to ensure that observations from
both levels of \code{truthLabels} are proportionally present in the cross validation
folds. In other words, stratification attempts to ensure there are sufficient observations
of each level of \code{truthLabels} in each training set to fit the model.
Stratification may be required for small or imbalanced data sets.  Note that stratification
is not performed for L.O.O (when \code{cvFolds = length(truthLabels)}).}

\item{masterSeed}{The random seed used to generate unique (and repeatable) seeds for
each cross validation replicate.}

\item{nJobs}{The number of cores on the local host
to use in parallelizing the training.  Parallelization
takes place at the \code{cvReps} level, i.e., if \code{cvReps = 1}, parallelizing would
do no good, whereas if \code{cvReps = 2}, each cross validation replicate would be run
separately in its own thread if \code{nJobs = 2}.
Parallelization is executed using \href{http://pnnl.github.io/docs-Smisc/rd.html#parlapplyw}{parLapplyW()}
from the \href{http://pnnl.github.io/docs-Smisc}{Smisc} package.}

\item{estimateLoss}{A logical, set to \code{TRUE} to calculate the average loss estimated via
cross validation using the optimized parameters \eqn{(\alpha, \lambda, \tau)} to fit the elastic
net model for each cross validation fold. This can be computationally expensive,
as it requires another cross validation pass through the same partitions of the data, but using only
the optimal parameters to estimate the loss for each cross validation replicate.}

\item{verbose}{For \code{glmetLRC}, a logical to turn on (or off) messages regarding
the progress of the training algorithm.  For the \code{print} method, if set to \code{FALSE}, it
will suppress printing information about the \code{glmnetLRC} object and only invisibly return
the results.}

\item{x}{For the \code{print} and \code{plot} methods:  an object of class \code{glmnetLRC} (returned
by \code{glmnetLRC()}), which contains the optimally-trained elastic-net logistic regression classifier.}

\item{object}{For the \code{coef}, \code{predict}, and \code{extract} methods:
an object of class \code{glmnetLRC} (returned by \code{glmnetLRC()})
which contains the optimally-trained elastic-net logistic regression classifier.}

\item{tol}{A small positive number, such that coefficients with an absolute value smaller than
\code{tol} are not returned.}

\item{newdata}{A dataframe or matrix containing the new set of observations to
be predicted, as well as an optional column of true labels.
\code{newdata} should contain all of the column names that were used
to fit the elastic-net logistic regression classifier.}

\item{truthCol}{The column number or column name in \code{newdata} that contains the
true labels, which should be a factor (and this implies \code{newdata} should be a dataframe if \code{truthCol} is provided).
Optional.}

\item{keepCols}{A numeric vector of column numbers (or a character vector of
column names) in \code{newdata} that will be 'kept' and returned with the predictions. Optional.}

\item{\dots}{For \code{glmnetLRC()}, these are additional arguments to \code{\link{glmnet}} in the \code{glmnet} package.
Certain arguments of \code{\link{glmnet}} are reserved by the \code{glmnetLRC} package and an error message will make that
clear if they are used.  In particular, arguments that control the behavior of \eqn{\alpha} and \eqn{\lambda} are reserved.
For the \code{plot} method, the "\dots" are additional arguments to the default S3 method \code{\link{pairs}}.  And for
the \code{print}, \code{coef}, \code{predict}, \code{missingpreds}, and \code{extract} methods, the "\dots" are ignored.}
}
\value{
An object of class \code{glmnetLRC}, which
inherits from classes \code{lognet} and \code{glmnet}.  It contains the
object returned by \code{\link{glmnet}} that has been fit to all the data using
the optimal parameters \eqn{(\alpha, \lambda, \tau)}.
It also contains the following additional elements:
\describe{
\item{lossMat}{The loss matrix used as the criteria for selecting optimal tuning parameters}
\item{parms}{A data fame that contains the tuning parameter estimates for \eqn{(\alpha, \lambda, \tau)} that minimize
the expected loss for each cross validation replicate.  Used by the \code{plot} method.}
\item{optimalParms}{A named vector that contains the final estimates of \eqn{(\alpha, \lambda, \tau)}, calculated as the
element-wise median of \code{parms}}
\item{lossEstimates}{If \code{estimateLoss = TRUE}, this element is a data frame with the expected loss
for each cross validation replicate}
}
}
\description{
This function extends the \code{\link{glmnet}} and \code{\link{cv.glmnet}}
functions from the \href{http://cran.r-project.org/package=glmnet}{glmnet}
package. It uses cross validation to identify optimal elastic-net parameters and a
threshold parameter for binary classification, where optimality is defined
by minimizing an arbitrary, user-specified discrete loss function.
}
\details{
For a given partition of the training data, cross validation is
performed to estimate the optimal values of
\eqn{\alpha} (the mixing parameter of the ridge and lasso penalties) and \eqn{\lambda}
(the regularization parameter), as well as the optimal threshold, \eqn{\tau},
which is used to dichotomize the probability predictions of the elastic-net
logistic regression model into binary outcomes.
(Specifically, if the probability an observation
belongs to the second level of \code{truthLabels} exceeds \eqn{\tau}, it is
classified as belonging to that second level).  In this case, optimality is defined
as the set of parameters that minimize the risk, or expected loss, where the
loss function created using \code{\link{lossMatrix}}.  The expected loss is calculated such
that each observation in the data receives equal weight

\code{glmnetLRC()} searches for the optimal values of \eqn{\alpha} and \eqn{\tau} by
fitting the elastic-net model at the points of the two-dimensional grid defined by
\code{alphaVec} and \code{tauVec}.  For each value of \eqn{\alpha}, the vector of
\eqn{\lambda} values is selected automatically by \code{\link{glmnet}} according to its default
arguments. The expected loss is calculated for each \eqn{(\alpha,\lambda,\tau)} triple, and the
triple giving rise to the lowest risk designates the optimal model for a given
cross validation partition, or cross validation replicate, of the data.

This process is repeated \code{cvReps} times, where each time a different random
partition of the data is created using its own seed, resulting in another
'optimal' estimate of \eqn{(\alpha,\lambda,\tau)}.  The final estimate of
\eqn{(\alpha,\lambda,\tau)} is given by the respective medians of those estimates.
The final elastic-net logistic regression classfier is given by fitting the regression
coefficients to all the training data using the optimal \eqn{(\alpha,\lambda,\tau)}.

The methodology is discussed in detail in the online
\href{http://pnnl.github.io/docs-glmnetLRC/index.html#mathematical-details}{package documentation}.
}
\section{Methods (by generic)}{
\itemize{
\item \code{print}: Displays the overall optimized values of
\eqn{(\alpha, \lambda, \tau)}, with the corresponding degrees of freedom and
deviance for the model fit to all the data using the optimzed parameters.  If \code{estimateLoss = TRUE}
when \code{glmnetLRC()} was called, the mean and standard deviation of the expected loss are also shown.
In addition, all of this same information is returned invisibly as a matrix. Display of the information
can be suppressed by setting \code{verbose = FALSE} in the call to \code{print}.

\item \code{plot}: Produces a pairs plot of the tuning parameters
\eqn{(\alpha, \lambda, \tau)} and their univariate histograms that
were identified as optimal for each of of the cross validation replicates.
This can provide a sense of the stability of the estimates of the tuning
parameters.

\item \code{coef}: Calls the \code{predict} method in \code{glmnet}
on the fitted glmnet object and returns a named vector of the non-zero elastic-net logistic
regression coefficients using the optimal values of \eqn{\alpha} and \eqn{\lambda}.

\item \code{predict}: Predict (or classify) new data from an \code{glmnetLRC} object.
Returns an object of class \code{LRCpred} (which inherits
from \code{data.frame}) that contains the predicted probabilities (\code{Prob}) and class (\code{predictClass})
for each observation.  The \code{Prob} column corresponds to the predicted probability that an observation belongs
to the second level of \code{truthLabels}. The columns indicated by \code{truthCol} and \code{keepCols} are included
if they were requested.  The \code{LRCpred} class has two methods:  \code{\link{summary.LRCpred}} and \code{\link{plot.LRCpred}}.

\item \code{missingpreds}: Identify the set of predictors in a \code{glmnetLRC} object that are not
present in \code{newdata}. Returns a character vector of the missing predictor names. If no predictors are missing,
it returns \code{character(0)}.

\item \code{extract}: Extracts the \code{glmnet} object that was fit using the optimal parameter estimates of
\eqn{(\alpha, \lambda)}.  Returns an object of class \code{"lognet" "glmnet"} that can be passed to various
methods available in the \code{glmnet} package.
}}
\examples{
# Load the VOrbitrap Shewanella QC data from Amidan et al.
data(traindata)

# Here we select the predictor variables
predictors <- as.matrix(traindata[,9:96])

# The logistic regression model requires a binary response
# variable. We will create a factor variable from the
# Curated Quality measurements. Note how we put "poor" as the
# second level in the factor.  This is because the principal
# objective of the classifer is to detect "poor" datasets
response <- factor(traindata$Curated_Quality,
                   levels = c("good", "poor"),
                   labels = c("good", "poor"))

# Specify the loss matrix. The "poor" class is the target of interest.
# The penalty for misclassifying a "poor" item as "good" results in a
# loss of 5.
lM <- lossMatrix(c("good","good","poor","poor"),
                 c("good","poor","good","poor"),
                 c(     0,     1,     5,     0))

# Display the loss matrix
lM

# Train the elastic-net classifier (we don't run it here because it takes a long time)
\dontrun{
glmnetLRC_fit <- glmnetLRC(response, predictors, lossMat = lM, estimateLoss = TRUE,
                           nJobs = parallel::detectCores())
}

# We'll load the precalculated model fit instead
data(glmnetLRC_fit)

# Show the optimal parameter values
print(glmnetLRC_fit)

# Show the coefficients of the optimal model
coef(glmnetLRC_fit)

# Show the plot of all the optimal parameter values for each cross validation replicate
plot(glmnetLRC_fit)

# Extract the 'glmnet' object from the glmnetLRC fit
glmnetObject <- extract(glmnetLRC_fit)

# See how the glmnet methods operate on the object
plot(glmnetObject)

# Look at the coefficients for the optimal lambda
coef(glmnetObject, s = glmnetLRC_fit$optimalParms["lambda"] )

# Load the new observations
data(testdata)

# Use the trained model to make predictions about
# new observations for the response variable.
new <- predict(glmnetLRC_fit, testdata, truthCol = "Curated_Quality", keepCols = 1:2)
head(new)

# Now summarize the performance of the model
summary(new)

# And plot the probability predictions of the model
plot(new, scale = 0.5, legendArgs = list(x = "topright"))

# If predictions are made without an indication of the ground truth,
# the summary is necessarily simpler:
summary(predict(glmnetLRC_fit, testdata))
}
\author{
Landon Sego, Alex Venzin
}
\references{
Amidan BG, Orton DJ, LaMarche BL, Monroe ME, Moore RJ,
Venzin AM, Smith RD, Sego LH, Tardiff MF, Payne SH. 2014.
Signatures for Mass Spectrometry Data Quality.
Journal of Proteome Research. 13(4), 2215-2222.
\url{http://pubs.acs.org/doi/abs/10.1021/pr401143e}

Friedman J, Hastie T, Tibshirani R. 2010. Regularization Paths for Generalized
Linear Models via Coordinate Descent. Journal of Statistical Software.
33(1), 1-22.
}
\seealso{
\code{\link{summary.LRCpred}}, a summary method for objects of class
\code{LRCpred}, produced by the \code{predict} method.
}

