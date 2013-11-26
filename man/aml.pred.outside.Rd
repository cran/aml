% File src/library/base/man/load.Rd
     \name{aml.pred.outside}
     \alias{aml.pred.outside}
     \title{Prediction With Adaptive Mixed LASSO}
     \description{
       This function is used to predict the genetic values for lines with marker information after fitting adaptive mixed LASSO on a training set using \code{amltest}.
       
     }
     \usage{
     aml.pred.outside(marker, response, kin, which.pred, numkeep, selectvar)
     }
     \arguments{
        
       \item{marker}{A matrix or data frame for the markers (or genetic effects).  It should include both lines with observed phenotypic information (those in the training set) and those lines for which the genetic values will be predicted.} 
       \item{response}{A numerical vector of trait (phenotype) values, corresponding to the lines in \code{marker}.  For lines for which prediction will be made, the trait values can simply be set to NA.  But for lines to be used in the training set, the trait value cannot be missing.}
       \item{kin}{The kinship matrix representing relationships between lines.  It should correspond to the rows in \code{marker} and represent the relationships between lines in the training set as well as those to be predicted.}
       \item{which.pred}{A vector of integers specifying  for which lines (which rows in \code{marker}) the prediction should be made.  Lines not in \code{which.pred} will be used as the training set.}
       \item{numkeep}{This parameter is passed to \code{amltest}.  It should be less than the number of lines in the training set.}
       \item{selectvar}{This parameter is passed to \code{amltest}.  It should be less than \code{numkeep}.}
       
     }
     \details{
      This function uses both marker effects and kinship to predict genetic values.  Thus the kinship matrix should include both lines in the training set and the lines on which predictions are to be made.  An adaptive mixed LASSO model is fitted for the training set including lines not in \code{which.pred}.  The regression coefficients provided by \code{amltest} are then used for prediction.  Besides performing prediction for lines with genetic marker genotypes but no phenotypic values, this function is especially convenient for performing cross-validation.
     }
     \value{
     A list of the following:
     \item{predict.vl}{The vector of predicted genetic values for lines specified in \code{which.pred}.}
     \item{response.vl}{The vector of observed phenotypic values for lines specified in \code{which.pred}.  This is useful for cross-validation when comparing predicted and observed values.  Otherwide it might be a vector of NAs.}
     }
     \seealso{
       \code{\link{amltest}}, \code{\link{aml.estimate}}.
     }

     \references{
 

      Wang, D., Eskridge, K.M. and Crossa, J. (2011)  Identifying QTLs and Epistasis in Structured Plant Populations Using Adaptive Mixed LASSO. \emph{Journal of Agricultural, Biological, and Environmental Statistics}, 16:170-184.

      Wang, D., \emph{et al.} (2012) Prediction of genetic values of quantitative traits with epistatic effects in plant breeding populations. \emph{Heredity}, 109: 313-319.
     }

     \examples{
     ## Predict the phenotype values of ten lines using the rest of the population in the wheat data
     data("wheat")
     clmarker<- cleanclust(wheat$marker, nafrac=0.2, mafb=0.1, corbnd=0.5, method="complete")
     intermat <- epigen(wheat$y, clmarker$newmarker, wheat$A, numkeep=100, selectvar=30, 
                        corbnd=0.5, mafb=0.04)
     which10<- sample(1:282, 10)
     pred10<- aml.pred.outside(intermat$effects, wheat$y, wheat$A, which10, 80, 40)
     
     }
     \keyword{adaptive mixed LASSO}

