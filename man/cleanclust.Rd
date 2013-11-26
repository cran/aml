% File src/library/base/man/load.Rd
     \name{cleanclust}
     \alias{cleanclust}
     \title{Clean, Impute, and Filter Markers}
     \description{
       Prepare marker data for use for \code{amltest}.  This function can be used to remove markers with a high proportion of missing values, impute   missing values with sample average, remove markers with very little variation, and if necessary, re-encode the minor allele as 1 and the majority allele as 0.
       
     }
     \usage{
     cleanclust(marker, nafrac=0.2, mafb=0.1, corbnd=0.5, method="complete")
     }
     \arguments{
       \item{marker}{A matrix or data frame for the marker information.  The number of rows should equal the number of lines and the number of columns should equal the number of markers.  The values of each element should be between 0 and 1 preferably with minor allele encoded as 1 and majority allele as 0.  If minor allele is encoded as 1 instead for a marker, \code{cleanclust} change its value to 1 minus the original column. Each column has to have a unique name to identify the marker.}
       \item{nafrac}{The maximum proportion of missing values for a marker.  Markers with higher proportion of missing values will be removed.  The default is 0.2.}
       \item{mafb}{The minimum minor allele frequency, markers with lower minor allele frequency will be removed.  The default is 0.1.}
       \item{corbnd}{The bound used for cutting the dendrogram after the hierarchical clustering, the default is 0.5.  See \emph{Details}.}
       \item{method}{The method of clustering passed to \code{hclust}.  The values could be one of "complete", "average" or "single".  The default is "complete".}
     }
     \details{
      This is a simplified version of the Hclust method described in the paper
\emph{Characterization of Multilocus Linkage Disequilibrium} by Rinald,\emph{et al.} (2005), tailored for use with \code{amltest} and other functions in this package. 
The R code for the original Hclust package can be find at \url{http://www.epic.Pitt.ed/Accompaniment/hclust/hclust.ht},
which provides more functionality.

The function \code{cleanclust} provides two main utilities.  The first is to clean and impute  the marker data, including removing markers with a high proportion of missing values or very low minor allele frequency as well as impute the remaining missing values by the sample mean regarding each marker.  The second is to remove some markers when necessary so that no markers will be highly correlated.  Like other LASSO type method, the performance of adaptive mixed LASSO can be improved when predictors are not highly correlated.  This process follows that of Rinald \emph{et al.} (2005).  The correlation between each pair of markers are calculated and \eqn{r=1-cor^2} is used as the distance between markers to perform hierarchical clustering with \code{hclust}.  The resulted dendrogram is cut to form clusters according to the bound on \eqn{cor^2}, \code{corbnd}.  Specifically, higher \code{corbnd} values will result in less clusters being formed and less markers in the output.  One marker is retained for each cluster in \code{newmarker}.   
     }
     \value{
     A list containing the following:
     \item{newmarker}{The new marker matrix after removing markers with a high proportion of missing values or low minor allele frequency, with missing values replaced with sample means, and possibly removing some markers to avoid multiple highly correlated markers.}
     \item{flip}{A vector of marker names for which the minor allele and major allele has been flipped.  Other functions in this package require the minor allele to be encoded as 1 and major allele as 0.  If the opposite is the case for a marker, the value will be flipped and the marker name will be given in this vector.}
     \item{tagged}{A vector of integers indicating which columns (markers) from the original marker matrix is retained in \code{newmarker}.}
     }
     \seealso{
       \code{\link{amltest}}.
     }

     \references{
     Rinaldo, A., Bacanu, S.-A., Devlin, B., Sonpar, V., Wasserman, L. and Roeder, K. (2005), Characterization of multilocus linkage disequilibrium. \emph{Genetic Epidemiology}, 28: 193-206.

      Wang, D., Eskridge, K.M. and Crossa, J. (2011)  Identifying QTLs and Epistasis in Structured Plant Populations Using Adaptive Mixed LASSO. \emph{Journal of Agricultural, Biological, and Environmental Statistics}, 16:170-184.

      Wang, D., \emph{et al.} (2012) Prediction of genetic values of quantitative traits with epistatic effects in plant breeding populations. \emph{Heredity}, 109: 313-319.
     }

     \examples{
     ## process the markers in the wheat data set.
     data("wheat")
     clmarker<- cleanclust(wheat$marker, nafrac=0.2, mafb=0.1, corbnd=0.5, method="complete")

     
     }
     \keyword{adaptive mixed LASSO}

