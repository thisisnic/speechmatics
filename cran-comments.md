## R CMD check results

0 errors | 0 warnings | 1 note

* This is a new release, so there is a NOTE that this is a new submission.

## Notes on a previous win-builder run

An earlier win-builder check reported test failures caused by the 'vcr'
package calling `curl::curl_parse_url()`, which was not exported by the
version of 'curl' installed on that machine (a 'vcr'/'curl' version
mismatch). Those HTTP-replay tests exercise an external API and do not need
to run on CRAN, so they are now guarded with `testthat::skip_on_cran()`.
They continue to run locally and in continuous integration.

The earlier "Possibly misspelled words in DESCRIPTION: diarization" NOTE
referred to a correctly-spelled speech-to-text term; it is now registered
in the package's `.aspell/` dictionary.
