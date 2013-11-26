% File src/library/base/man/load.Rd
     \name{epigen}
     \alias{epigen}
     \title{Generate Epistatic Effect Matrix}
     \description{
       This function select specified number of markers using \code{amltest} and then forming a matrix including both main marker effects and two-way epistatic effects.
       
     }
     \usage{
     epigen(response, marker, kin, numkeep=floor(length(response)*.5), selectvar, 
     corbnd=0.5, mafb=0.04, method="complete")
     }
     \arguments{
        \item{response}{A numerical vector of the trait (phenotype) to be analyzed. It is passed to \code{amltest}.}
       \item{marker}{A matrix or data frame for the markers from which the main effects will be selected.  The number of rows should equal the number of lines and the number of columns should equal the number of markers.  The values of each element should be between 0 and 1 with minor allele encoded as 1 and majority allele as 0.  If minor allele is encoded as 1 instead for some markers, \code{cleanclust} can be used to re-encode it. The function \code{cleanclust} should also be used to preprocess the marker data to remove marker with a high proportion of missing values or very low minor allele frequency as well as impute missing values with the sample mean.  It is also recommend that \code{cleanclust} be used to filter the markers so that no markers are highly correlated. It is passed to \code{amltest}.}
       \item{kin}{The kinship matrix representing relationships between lines.  It should be symmetric and positive definite, and have the number of rows and columns equal to the number of rows of \code{marker}. It is passed to \code{amltest}. }
       \item{numkeep}{The number of main marker effects that should be retained after the preliminary screening in \code{amltest}.  It should be less than the number of lines.  The default value is a half of the number of lines. }
       \item{selectvar}{The number of main marker effects to be included in the model.  Strictly speaking, it is the number of iterations for the fitting procedure of \code{amltest}.  The number of main marker effects that are retained could be slightly less than \code{selectvar}.  See the documentation for \code{amltest}.}
       \item{mafb}{The minimum mean value of an effect. Effects with lower mean values (too many zeros) are removed.  For a main marker effect, this is just the minimum value for minor allele frequency.  The default is 0.04 and is passed to \code{cleanclust}.}
       \item{corbnd}{The bound used for cutting the dendrogram after the hierarchical clustering, the default is 0.5.  See the documentation for \code{cleanclust}.}
       \item{method}{The method of clustering passed to \code{hclust}.  The values could be one of "complete", "average" or "single".  The default is "complete". See the documentation for \code{cleanclust}. }
     }
     \details{
      Since considering all two-way epistatic effects are not computationally feasible in most cases, \code{amltest} is called first to select a subset of markers with the most significant main effects.  Then two-way epistatic effects are formed from these selected markers by taking the product of the two columns corresponding to each pair of markers.  Subsequently, the \code{cleanclust} function is called to remove effects with very low mean values and also filter the effects such that no two effects are highly correlated.  The resulted genetic effect matrix include both main effects and epistatic effects.  It can then be used as input for \code{amltest} in the same manner as a marker matrix. 
     }
     \value{
     A list containing the following:
     \item{effects}{A matrix of both selected main marker effects and two-way epistatic effects.}
     \item{marker1}{A vector of names corresponding to the first marker in two-way epistatic effects given in \code{effects}, or the marker name for a main effect.}
     \item{marker2}{A vector of names corresponding to the second marker in two-way epistatic effects given in \code{effects}, or the marker name for a main effect.}
     }
     \seealso{
       \code{\link{amltest}}, \code{\link{cleanclust}}.
     }

     \references{
 

      Wang, D., Eskridge, K.M. and Crossa, J. (2011)  Identifying QTLs and Epistasis in Structured Plant Populations Using Adaptive Mixed LASSO. \emph{Journal of Agricultural, Biological, and Environmental Statistics}, 16:170-184.

      Wang, D., \emph{et al.} (2012) Prediction of genetic values of quantitative traits with epistatic effects in plant breeding populations. \emph{Heredity}, 109: 313-319.
     }

     \examples{
     ## process the markers in the wheat data set.
     data("wheat")
     clmarker<- cleanclust(wheat$marker, nafrac=0.2, mafb=0.1, corbnd=0.5, method="complete")
     intermat <- epigen(wheat$y, clmarker$newmarker, wheat$A, numkeep=100, selectvar=30, 
                        corbnd=0.5, mafb=0.04)
     }
     \keyword{adaptive mixed LASSO}

