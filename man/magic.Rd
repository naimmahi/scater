% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/AllGenerics.R, R/magic.R
\docType{methods}
\name{magic}
\alias{magic}
\alias{magic}
\alias{.magic_default}
\alias{magic,SCESet-method}
\alias{magic,SCESet-method}
\title{Markov Affinity-based Graph Imputation of Cells}
\usage{
magic(object, ...)

\S4method{magic}{SCESet}(object, exprs_values, power, rescale, logged_data, ...)

\S4method{magic}{SCESet}(object, exprs_values = "exprs", power = 6,
  rescale = NULL, logged_data = TRUE, ...)
}
\arguments{
\item{object}{an \code{SCESet} object.}

\item{...}{further arguments passed to \code{\link[destiny]{DiffusionMap}}.
Key parameters are \code{k} (number of nearest neighbours to consider),
\code{n_eigs} (number of eigenvectors/values to return), \code{sigma}
(diffusion scale parameter of the Gaussian kernel, either "global" or the
default, "local") and \code{n_local} (if \code{sigma == "local"}, the
\code{n_local}th nearest neighbour determines the local sigma). For details,
see the documentation for \code{\link[destiny]{DiffusionMap}}.}

\item{power}{integer(1), the Markov transition matrix will be taken to this
power before multiplying the original expression values to obtain imputed
values.}

\item{rescale}{numeric(1), optional (default is NULL for no rescaling)
rescaling parameter. If provided, must be a numeric scale in [0, 1] providing
the quantile of expression values to use as the ratio between original and
imputed expression values by which to scale imputed expression values.}

\item{logged_data}{is the input data on a log scale? If so, no rescaling will
be done, and the \code{rescale} argument will be ignored.}

\item{exprs_values}{character string indicating which values should be used
as the expression values for this plot. Valid arguments are \code{"tpm"}
(default; transcripts per million), \code{"norm_tpm"} (normalised TPM
values), \code{"fpkm"} (FPKM values), \code{"norm_fpkm"} (normalised FPKM
values), \code{"counts"} (counts for each feature), \code{"norm_counts"},
\code{"cpm"} (counts-per-million), \code{"norm_cpm"} (normalised
counts-per-million), \code{"exprs"} (whatever is in the \code{'exprs'} slot
of the \code{SCESet} object; default), \code{"norm_exprs"} (normalised
expression values) or \code{"stand_exprs"} (standardised expression values)
or any other slots that have been added to the \code{"assayData"} slot by
the user.}
}
\value{
A feature by cell matrix of "magic" imputed expression values.
}
\description{
A diffusion-based imputation method for reducing technical noise due to
dropout from inefficient mRNA capture. An R implementation of the MAGIC
method from van Dijk et al (2017).
}
\details{
This implementation of MAGIC differs slightly from the original Python
implementation published by van Dijk et al (2017). This function uses the
\code{\link[destiny]{DiffusionMap}} method from the \link[destiny]{destiny}
package to compute the cell-cell Markov transition matrix. This differs in
subtle ways from the Python implementation of the method from van Dijk et al,
so results from this function will differ slightly numerically from results
obtained from the MAGIC python package (\url{https://github.com/pkathail/magic}).
}
\examples{
data("sc_example_counts")
data("sc_example_cell_info")
pd <- new("AnnotatedDataFrame", data = sc_example_cell_info)
example_sceset <- newSCESet(countData = sc_example_counts, phenoData = pd)
example_sceset <- example_sceset[rowSums(counts(example_sceset)) > 0.5, ]
mgc <- magic(example_sceset, power = 6, k = 30, n_eigs = 20, n_local = 10)

}
\references{
van Dijk D, Nainys J, Sharma R, Kathail P, Carr AJ, Moon KR, et al.
MAGIC: A diffusion-based imputation method reveals gene-gene interactions in
single-cell RNA-sequencing data. bioRxiv. 2017. p. 111591.
 doi:10.1101/111591
}
\author{
Davis McCarthy
}
