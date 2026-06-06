# Transcribe an audio file

Submits an audio file to the Speechmatics API, polls until complete, and
writes the transcript to a file.

## Usage

``` r
sm_transcribe(
  input,
  output = NULL,
  config = sm_transcription_config(),
  poll_interval = 5
)
```

## Arguments

- input:

  Path to the input audio file.

- output:

  Path to the output transcript file. If `NULL` (the default), the
  output is written to the working directory with the same name as the
  input file but with a `.txt` extension.

- config:

  Config from
  [`sm_transcription_config()`](https://thisisnic.github.io/speechmatics/reference/sm_transcription_config.md).

- poll_interval:

  Seconds between status checks.

## Value

The output path, invisibly.

## Examples

``` r
if (FALSE) { # \dontrun{
audio <- system.file("extdata", "testrecording.mp3", package = "speechmatics")
sm_transcribe(audio)
sm_transcribe(audio, "output.txt")
sm_transcribe(audio, config = sm_transcription_config(quality = "enhanced"))
} # }
```
