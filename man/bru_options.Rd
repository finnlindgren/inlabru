% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/environment.R
\name{bru_options}
\alias{bru_options}
\alias{as.bru_options}
\alias{bru_options_default}
\alias{bru_options_check}
\alias{bru_options_get}
\alias{bru_options_set}
\alias{bru_options_reset}
\title{Create or update an options objects}
\usage{
bru_options(...)

as.bru_options(x = NULL)

bru_options_default()

bru_options_check(options, ignore_null = TRUE)

bru_options_get(name = NULL, include_default = TRUE)

bru_options_set(..., .reset = FALSE)

bru_options_reset()
}
\arguments{
\item{...}{A collection of named options, optionally including one or more
\code{\link{bru_options}} objects. Options specified later override the previous options.}

\item{x}{An object to be converted to an \code{bru_options} object.}

\item{options}{An \code{bru_options} object to be checked}

\item{ignore_null}{Ignore missing or NULL options.}

\item{name}{Either \code{NULL}, or single option name string, or character vector
or list with option names,
Default: NULL}

\item{include_default}{logical; If \code{TRUE}, the default options are included
together with the global override options. Default: \code{TRUE}}

\item{.reset}{For \code{bru_options_set}, logical indicating if the global override
options list should be emptied before setting the new option(s).}
}
\value{
\code{bru_options()} returns an \code{bru_options} object.

For \code{as.bru_options()}, \code{NULL} or no input returns an empty
\code{bru_options} object, a \code{list} is converted via \code{bru_options(...)},
and \code{bru_options} input is passed through. Other types of input generates
an error.

\code{bru_options_default()} returns an \code{bru_options} object containing
default options.

\code{bru_options_check()} returns a \code{logical}; \code{TRUE} if the object
contains valid options for use by other functions

\code{bru_options_get} returns either an \code{\link{bru_options}} object, for
\code{name == NULL}, the contents of single option, if \code{name} is a options name
string, or a named list of option contents, if \code{name} is a list of option
name strings.

\code{bru_options_set()} returns a copy of the global override options,
invisibly (as \code{bru_options_get(include_default = FALSE)}).
}
\description{
Create a new options object, or merge information from several
objects.

The \verb{_get}, \verb{_set}, and \verb{_reset} functions operate on a global
package options override object. In many cases, setting options in
specific calls to \code{\link[=bru]{bru()}} is recommended instead.
}
\details{
\code{bru_options_check} checks for valid contents of an \code{bru_options}
object

\code{bru_options_check()} produces warnings for invalid options.

\code{bru_options_set()} is used to set global package options.

\code{bru_options_reset()} clears the global option overrides.
}
\section{Valid options}{

For \code{bru_options} and \code{bru_options_set}, recognised options are:
\describe{
\item{bru_verbose}{logical or numeric; if \code{TRUE}, log messages of \code{verbosity}
\eqn{\leq 1} are printed by \code{\link[=bru_log_message]{bru_log_message()}}. If numeric, log messages
of
verbosity \eqn{\leq} are printed. For line search details, set \code{bru_verbose=2} or \code{3}.
Default: 0}
\item{bru_verbose_stored}{logical or numeric; if \code{TRUE}, log messages of
\code{verbosity} \eqn{\leq 1} are stored by \code{\link[=bru_log_message]{bru_log_message()}}. If numeric,
log messages of verbosity \eqn{\leq} are stored. Default: 1}
\item{bru_run}{If TRUE, run inference. Otherwise only return configuration needed
to run inference.}
\item{bru_max_iter}{maximum number of inla iterations}
\item{bru_initial}{An \code{inla} object returned from previous calls of
\code{INLA::inla}, \link{bru} or \link{lgcp}, or a list of named vectors of starting
values for the latent variables. This will be used as a
starting point for further improvement of the approximate posterior.}
\item{bru_int_args}{List of arguments passed all the way to the
integration method \code{ipoints} and \code{int.polygon} for 'cp' family models;
\describe{
\item{method}{"stable" or "direct". For "stable" (default) integration points
are aggregated to mesh vertices.}
\item{nsub1}{Number of integration points per knot interval in 1D. Default 30.}
\item{nsub2}{Number of integration points along a triangle edge for 2D. Default 9.}
\item{nsub}{Deprecated parameter that overrides \code{nsub1} and \code{nsub2} if set. Default \code{NULL}.}
}
}
\item{bru_method}{List of arguments controlling the iterative inlabru method:
\describe{
\item{taylor}{Either 'legacy' (for the pre-2.1.15 method) or 'pandemic'
(default, from version 2.1.15).}
\item{search}{Either 'all' (default), to use all available line search
methods, or one or more of
'finite' (reduce step size until predictor is finite),
'contract' (decrease step size until trust hypersphere reached)
'expand' (increase step size until no improvement),
'optimise' (fast approximate error norm minimisation).
To disable line search, set to an empty vector. Line search is not
available for \code{taylor="legacy"}.}
\item{factor}{Numeric, \eqn{> 1} determining the line search step scaling
multiplier. Default \eqn{(1 + \sqrt{5})/2}{(1+sqrt(5))/2}.}
}
}
\item{\code{inla()} options}{
All options not starting with \code{bru_} are passed on to \code{inla()}, sometimes
after altering according to the needs of the inlabru method.
Warning:
Due to how inlabru currently constructs the \code{inla()} call, the \code{mean},
\code{prec}, \code{mean.intercept}, and \code{prec.intercept} settings in
\code{control.fixed} will have no
effect. Until a more elegant alternative has been implemented, use explicit
\code{mean.linear} and \code{prec.linear} specifications in each
\code{model="linear"} component instead.
}
}
}

\examples{
\dontrun{
if (interactive()) {
  # Combine global and user options:
  options1 <- bru_options(bru_options_get(), bru_verbose = TRUE)
  # Create a proto-options object in two equivalent ways:
  options2 <- as.bru_options(bru_verbose = TRUE)
  options2 <- as.bru_options(list(bru_verbose = TRUE))
  # Combine options objects:
  options3 <- bru_options(options1, options2)
}
}
\dontrun{
if (interactive()) {
  # EXAMPLE1
}
}
\dontrun{
if (interactive()) {
  bru_options_check(bru_options(bru_max_iter = "text"))
}
}
\dontrun{
if (interactive()) {
  # EXAMPLE1
}
}
\dontrun{
if (interactive()) {
  bru_options_set(
    bru_verbose = TRUE,
    verbose = TRUE
  )
}
}
}
\seealso{
\code{\link[=bru_options]{bru_options()}}, \code{\link[=bru_options_default]{bru_options_default()}}, \code{\link[=bru_options_get]{bru_options_get()}}
}
