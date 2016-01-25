\name{oaxaca}
\alias{oaxaca}
\alias{summary.oaxaca}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Blinder-Oaxaca Decomposition
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
\code{oaxaca} performs a Blinder-Oaxaca decomposition for linear regression models (Blinder, 1973; Oaxaca, 1973). This statistical method decomposes the difference in the means of outcome variables across two groups into a part that is due to cross-group differences in explanatory variables and a part that is due to differences in group-specific coefficients. Economists have used Blinder-Oaxaca decompositions extensively to study labor market discrimination. In principle, however, the method is appropriate for the exploration of cross-group differences in any outcome variable. \cr \cr
The \code{oaxaca} function allows users to estimate both a threefold and a twofold variant of the decomposition, as described and implemented by Jann (2008). It supports a variety of reference coefficient weights, as well as pooled model estimation. It can also adjust coefficients on indicator variables to be invariant to the choice of the omitted reference category. Bootstrapped standard errors are calculated (e.g., Efron, 1979). The function returns an object of class \code{"oaxaca"} that can be visualized using the \code{\link{plot.oaxaca}} method.
}
\usage{
oaxaca(formula, data, weights = NULL, R = 100, reg.fun = lm, ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{formula}{a formula that specifies the model that the function will run. Typically, the formula is of the following form:\cr \cr  \code{y ~ x1 + x2 + x3 + ... | z}\cr \cr where \code{y} is the dependent variable, \code{x1 + x2 + x3 + ...} are explanatory variables and \code{z} is an indicator variable that is \code{TRUE} (or equal to 1) when an observation belongs to Group B, and \code{FALSE} (or equal to 0) when it belongs to Group A.\cr \cr The formula can also take on an alternative form:\cr \cr \code{y ~ x1 + x2 + x3 + ... | z | d1 + d2 + d3 + ...}\cr \cr Here, \code{d1 + d2 + d3 + ...} are indicator ("dummy") variables that will be adjusted so that the decomposition results do not change depending on the user's choice of the reference category (Gardeazabal and Ugidos, 2004).}
  \item{data}{a data frame containing the data to be used in the Blinder-Oaxaca decomposition.}
  \item{weights}{a vector of numeric values between 0 and 1. These values specify the weight given to Group A relative to Group B in determining the reference set of coefficients (Oaxaca and Ransom, 1994). By default, the following weights are included in each estimation:
    \itemize{
      \item \code{0}: Group A coefficients used as reference.
      \item \code{1}: Group B coefficients used as reference.
      \item \code{0.5}: Equally weighted average (each 0.5) of Group A and B coefficients used as reference, as in Reimers (1983).
      \item an average of Group A and B coefficients weighted by the number of observations in Group A and B, following Cotton (1988).
      \item \code{-1}: Coefficients from a pooled regression (that does not include the group indicator variable) used as reference, as suggested by Neumark (1988).
      \item \code{-2}: Coefficients from a pooled regression (that includes the group indicator) used as reference. See Jann (2008).
    }
  }
  \item{R}{number of bootstrapping replicates for the calculation of standard errors. No bootstrapping is performed when the value of \code{R} is set to \code{NULL}.}
  \item{reg.fun}{a function that estimates the desired regression model. The function must accept arguments \code{formula} and \code{data}, and be treated by functions \code{model.frame} and \code{model.matrix}, in the same way that the standard functions \code{lm} and \code{glm} do. Additional arguments can be passed on via the \code{\dots} argument. By default, an Ordinary Least Squares (OLS) regression is performed via the \code{lm} function.}
  \item{\dots}{additional arguments that will be passed on to the regression function specified by \code{reg.fun}.}
%%     ~~Describe \code{\dots} here~~
}

  
\value{
\code{oaxaca} returns an object of class \code{"oaxaca"}. The corresponding \code{summary} function (i.e., \code{summary.oaxaca}) returns the same object.

An object of class \code{"oaxaca"} is a list containing the following components:
\item{beta}{a list that contains information about the regression coefficients used in estimating the decomposition. If dummy variables \code{d1 + d2 + d3 + ...} are specified in the \code{formula} argument, this list contains coefficients that have been adjusted to make estimation results invariant to the choice of the omitted baseline category (Gardeazabal and Ugidos, 2004). The \code{beta} list contains the following components:
  \itemize{
    \item \code{beta.A}: coefficients from a regression on observations in Group A
    \item \code{beta.B}: coefficients from a regression on observations in Group B
    \item \code{beta.diff}: equal to \code{beta.A} - \code{beta.B}
    \item \code{beta.B}: a matrix that contains the reference coefficients for each of the estimated twofold decompositions
  }
}
\item{call}{the matched call.}
\item{n}{a list that contains information about the number of observations used in the analysis. It contains the following components:
  \itemize{
    \item \code{n.A}: the number of observations in Group A
    \item \code{n.B}: the number of observations in Group B
    \item \code{n.pooled}: the number of observations in the pooled model that includes both Group A and Group B
  }
}
\item{R}{a numeric vector that contains the number of bootstrapping replicates.}
\item{reg}{a list that contains estimated regression objects:
  \itemize{
    \item \code{reg.A}: a regression on observations in Group A
    \item \code{reg.B}: a regression on observations in Group B
    \item \code{reg.pooled.1}: a pooled regression that does not include the group indicator variable (Neumark, 1988)
    \item \code{reg.pooled.2}: a pooled regression that does includes the group indicator variable (Jann, 2008)
  }
}
\item{threefold}{a list that contains the result of the threefold Blinder-Oaxaca decomposition. It decomposes the difference in mean outcomes into three parts:
  \itemize{
    \item \code{endowments}: the contribution of differences in explanatory variables across groups.
    \item \code{coefficients}: part that is due to group differences in the coefficients (or "effect size"). Includes differences in the model intercept.
    \item \code{interaction}: part that accounts for the fact that cross-group differences in explanatory variables and coefficients occur at the same time.
  }
  The list \code{threefold} contains two sub-components: \code{overall} and \code{variables}. The former is a numeric vector that stores results - coefficients (\code{coef}) and standard errors (\code{se}) - for the overall decomposition of the difference in outcomes into the three parts described above. The latter is a numeric matrix that contains the results of a variable-by-variable threefold Blinder-Oaxaca decomposition.
  }
\item{twofold}{a list that contains the result of the twofold Blinder-Oaxaca decomposition. It decomposes the difference in mean outcomes into two parts:
  \itemize{
    \item \code{explained}: the portion that is explained by cross-group differences in the explanatory variables.
    \item \code{unexplained}: the remaining part that is not explained by differences in the explanatory variables. Often attributed to discrimination, but may also result from the influence of unobserved variables.
  }
  The \code{unexplained} part can be further decomposed into two sub-parts, \code{unexplained A} and \code{unexplained B}, that represent discrimination in favor of Group A and against Group B, respectively. See Jann (2008) for details on these sub-parts' interpretation.
  
  The list \code{twofold} contains two sub-components: \code{overall} and \code{variables}. The former is a numeric matrix that stores results - coefficients (\code{coef}) and standard errors (\code{se}) - for the overall decomposition of the difference in outcomes into the two parts described above. The latter is a list of numeric matrices that contains the results of a variable-by-variable twofold Blinder-Oaxaca decomposition. In all matrices, the \code{weight} column indicates the weight given to Group A relative to Group B in determining the reference coefficients.
  }
\item{x}{a list that contains:
  \itemize{
    \item \code{x.mean.A}: the mean values of explanatory variables for Group A
    \item \code{x.mean.B}: the mean values of explanatory variables for Group B
    \item \code{x.mean.diff}: equal to \code{x.mean.A} - \code{x.mean.B}
  }
}  
\item{y}{a list that contains the mean values of the dependent variable (i.e., the outcome variable). It contains the following components:
  \itemize{
    \item \code{y.A}: the mean outcome value for observations in Group A
    \item \code{y.B}: the mean outcome value for observations in Group B
    \item \code{y.diff}: the difference between the mean outcomes values in Groups A and B. Equal to \code{y.A} - \code{y.B}.
  }
} 
}

\references{
Blinder, Alan S. (1973). Wage Discrimination: Reduced Form and Structural Estimates. \emph{Journal of Human Resources}, 8(4), 436-455.

Cotton, Jeremiah. (1988). On the Decomposition of Wage Differentials. \emph{Review of Economics and Statistics}, 70(2), 236-243.

Efron, Bradley. (1979). Bootstrap Methods: Another Look at the Jackknife. \emph{Annals of Statistics}, 7(1), 1-26.

Gardeazabal, Javier and Arantza Ugidos. (2004). More on Identification in Detailed Wage Decompositions. \emph{Review of Economics and Statistics}, 86(4), 1034-1036.

Jann, Ben. (2008). The Blinder-Oaxaca Decomposition for Linear Regression Models. \emph{Stata Journal}, 8(4), 453-479.

Neumark, David. (1988). Employers' Discriminatory Behavior and the Estimation of Wage Discrimination. \emph{Journal of Human Resources}, 23(3), 279-295.

Oaxaca, Ronald L. (1973). Male-Female Wage Differentials in Urban Labor Markets. \emph{International Economic Review}, 14(3), 693-709.

Oaxaca, Ronald L. and Michael R. Ransom. (1994). On Discrimination and the Decomposition of Wage Differentials. \emph{Journal of Econometrics}, 61(1), 5-21.

Reimers, Cordelia W. (1983). Labor Market Discrimination Against Hispanic and Black Men. \emph{Review of Economics and Statistics}, 65(4), 570-579.
}
\author{
%%  ~~who you are~~
Marek Hlavac   < hlavac at fas.harvard.edu > \cr
Harvard University, Political Economy and Government \cr
}
\section{Please cite as:}{
Hlavac, Marek (2016). oaxaca: Blinder-Oaxaca Decomposition in R.\cr
R package version 0.1.3. http://CRAN.R-project.org/package=oaxaca 
}
\seealso{
\code{\link{plot.oaxaca}}
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\examples{
# set random seed
set.seed(03104)

# load data set of Hispanic workers in Chicago
data("chicago")

# perform Blinder-Oaxaca Decomposition:
# explain differences in log real wages across native and foreign-born groups
oaxaca.results.1 <- oaxaca(ln.real.wage ~ age + female + LTHS + some.college + 
                                          college + advanced.degree | foreign.born, 
                           data = chicago, R = 30)

# print the results
print(oaxaca.results.1)

# Next:
# - adjust gender and education dummy variable coefficients to make results
#   invariant to the choice of omitted baseline (reference category)
# - include additional weights for the twofold decomposition that give
#   weights of 0.2 and 0.4 to Group A relative to Group B in the choice
#   of reference coefficients

oaxaca.results.2 <- oaxaca(ln.real.wage ~ age + female + LTHS + some.college + 
                                          college + advanced.degree | foreign.born |
                                          LTHS + some.college + college + advanced.degree,
                           data = chicago, weights = c(0.2, 0.4), R = 30)

# plot the results
plot(oaxaca.results.2)

% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
}
\keyword{ decomposition }
\keyword{ regression }
\keyword{ linear }

