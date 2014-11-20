\name{chicago}
\alias{chicago}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Labor market and demographic data for employed Hispanic workers in metropolitan Chicago
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
Data from a 2013 sample of employed Hispanic workers in metropolitan Chicago. It is a subset of the 2013 Current Population Survey (CPS) Outgoing Rotation Groups (ORG) data set provided by the Center for Economic and Policy Research in Washington, DC (CEPR, 2014).
}
\usage{
data("chicago")
}
%- maybe also 'usage' for other objects documented here.
\format{
A data frame containing 712 observations on 9 variables. The 9 variables contain labor market and demographic information on a sample of employed Hispanic workers in the Chicago metropolitan area.
  \tabular{lll}{
  [, 1] \tab age \tab the worker's age, expressed in years \cr
  [, 2] \tab female \tab an indicator for female gender \cr
  [, 3] \tab foreign.born \tab an indicator for foreign-born status \cr
  [, 4] \tab LTHS \tab an indicator for having completed less than a high school (LTHS) education \cr
  [, 5] \tab high.school \tab an indicator for having completed a high school education \cr
  [, 6] \tab some.college \tab an indicator for having completed some college education \cr
  [, 7] \tab college \tab an indicator for having completed a college education \cr
  [, 8] \tab advanced.degree \tab an indicator for having completed an advanced degree \cr
  [, 9] \tab ln.real.wage \tab the natural logarithm of the worker's real wage (in 2013 U.S. dollars) \cr
  }
}

 
\source{
Center for Economic and Policy Research (CEPR). 2014. CPS ORG Uniform Extracts, Version 1.9 . Washington, DC.
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\examples{
data("chicago")
summary(chicago)

% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
}
\keyword{ datasets }


