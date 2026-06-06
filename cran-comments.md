## R CMD check results

0 errors | 0 warnings | 1 note

* This is a new release.

* checking CRAN incoming feasibility ... NOTE
  Possibly misspelled words in DESCRIPTION:
    diarization (8:25)

  "diarization" is the correct, standard term in speech-to-text for
  identifying and labelling individual speakers in an audio recording.
  It is spelled correctly and is included in inst/WORDLIST.

## Notes on test failures in a previous win-builder run

A previous win-builder check reported test failures caused by the 'vcr'
package calling `curl::curl_parse_url()`, which was not exported by the
version of 'curl' installed on that machine. These are HTTP-replay tests
that exercise an external API and do not need to run on CRAN, so they are
now guarded with `testthat::skip_on_cran()`. They continue to run locally
and in continuous integration.
