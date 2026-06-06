## Custom aspell dictionaries used by R CMD check's spell check.
## "diarization" is a correctly-spelled speech-to-text term; see
## .aspell/speechmatics.rds.
Rd_files <- vignettes <- R_files <- description <-
  list(encoding = "UTF-8", dictionaries = c("en_stats", "speechmatics"))
