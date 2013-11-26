% File src/library/base/man/load.Rd
     \name{amltest}
     \alias{amltest}
     \title{Adaptive Mixed LASSO Analysis}
     \description{
       Perform adaptive mixed LASSO analysis.  The function is designed for association mapping or genomic prediction in structured populations, though other applications are possible.
       
     }
     \usage{
     amltest(response, marker, kin, numkeep=floor(length(response)*.5), selectvar)
     }
     \arguments{
       \item{response}{A numerical vector of the trait (phenotype) to be analyzed.}
       \item{marker}{A matrix or data frame for the marker (or more generally, genetic effect) information.  The number of rows should equal the number of lines and the number of columns should equal the number of markers.  The values of each element should be between 0 and 1 with minor allele encoded as 1 and majority allele as 0.  If minor allele is encoded as 1 instead for some markers, \code{cleanclust} can be used to re-encode it. The function \code{cleanclust} should also be used to preprocess the marker data to remove marker with a high proportion of missing values or very low minor allele frequency as well as impute missing values with the sample mean.  It is also recommend that \code{cleanclust} be used to filter the markers so that no markers are highly correlated. }
       \item{kin}{The kinship matrix representing relationships between lines.  It should be symmetric and positive definite, and have the number of rows and columns equal to the number of rows of \code{marker}. }
       \item{numkeep}{The number of markers that should be retained after the preliminary screening.  It should be less than the number of lines.  The default value is a half of the number of lines. see \emph{Details}. }
       \item{selectvar}{The number of markers to be included in the model.  Strictly speaking, it is the number of iterations for the fitting procedure.  The number of markers in the output could be slightly less than \code{selectvar}.  See \emph{Details}.}
     }
     \details{
      In adaptive mixed LASSO fitting, \code{amltest} first performs a preliminary screening to retain a set of markers (predictors) numbering at most \code{numkeep}, which should be less than the number of lines.  This step relies on LASSO fitting using \pkg{lars}.  The quantity \code{numkeep} is the maximum steps of iterations in LASSO fit.  Due to the nature of the \pkg{lars} algorithm, the number of markers retained after the screening might be slightly less than \code{numkeep.  }  Then \code{amltest} will perform adaptive mixed LASSO fit by iteratively estimating the fixed effects and random effects up to the number of iterations defined by \code{selectvar}.  Again, the number of markers in the output might be slightly less than \code{selectvar} as determined by the behavior of the \pkg{lars} algorithm.  So if an exact number of markers are required in the model, some trial and error might be needed.
     }
     \value{
     A list containing the following:
     \item{estimate}{A matrix of two columns.  The first column indicates which column in \code{marker} is included in the model fit and the second column is the effect for each marker in the model.}
     \item{AIC}{A vector of AIC values for models using different number of markers.  The first entry is for model with zero markers (only random line effects) and the last entry corresponding to the model with markers specified in \code{estimate}.}
     \item{BIC}{A vector of BIC values for models using different number of markers.  The first entry is for model with zero markers (only random line effects) and the last entry corresponding to the model with markers specified in \code{estimate}.}
     \item{EBIC}{A vector of EBIC values for models using different number of markers.  The first entry is for model with zero markers (only random line effects) and the last entry corresponding to the model with markers specified in \code{estimate}.}
     \item{vars}{The vector for variance components of random effects.  The first entry is the genetic variance \eqn{\sigma^{2}_{g}} and the second entry is the ratio of the error variance over the genetic variance.  Thus the product of these two entries gives the error variance \eqn{\sigma^{2}_{e}}. }
     \item{mcount}{The vector of the number of markers in each step.  This is mainly used in conjunction with AIC, BIC, or EBIC.}
     }
     \seealso{
       \code{\link{cleanclust}}.
     }

     \references{
     
      Wang, D., Eskridge, K.M. and Crossa, J. (2011)  Identifying QTLs and Epistasis in Structured Plant Populations Using Adaptive Mixed LASSO. \emph{Journal of Agricultural, Biological, and Environmental Statistics}, 16:170-184.

      Wang, D., \emph{et al.} (2012) Prediction of genetic values of quantitative traits with epistatic effects in plant breeding populations. \emph{Heredity}, 109: 313-319.
     }

     \examples{
     ## analyze the wheat data with main marker effects.
     data("wheat")
     clmarker<- cleanclust(wheat$marker, nafrac=0.2, mafb=0.1, corbnd=0.5, method="complete")
     resmain <- amltest(wheat$y, clmarker$newmarker, wheat$A, numkeep=80, selectvar=40)
     }
     \keyword{adaptive mixed LASSO}

