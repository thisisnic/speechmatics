# Get transcript for a completed job

Get transcript for a completed job

## Usage

``` r
sm_get_transcript(job_id, format = c("txt", "srt", "json-v2"))
```

## Arguments

- job_id:

  Job ID string.

- format:

  Output format: `"txt"` for plain text (default), `"srt"` for
  subtitles, or `"json-v2"` for structured data with timestamps, speaker
  labels, and confidence scores.

## Value

Transcript as a character string (`"txt"` and `"srt"`) or a list
(`"json-v2"`).

## Examples

``` r
if (FALSE) { # \dontrun{
sm_get_transcript("2om9psu1np")
sm_get_transcript("2om9psu1np", format = "srt")
sm_get_transcript("2om9psu1np", format = "json-v2")
} # }
```
