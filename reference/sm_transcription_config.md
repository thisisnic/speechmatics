# Build transcription config

Build transcription config

## Usage

``` r
sm_transcription_config(
  language = "en",
  quality = c("standard", "enhanced"),
  diarization = NULL
)
```

## Arguments

- language:

  Language code (default `"en"`).

- quality:

  `"standard"` or `"enhanced"`.

- diarization:

  A diarization object from
  [`sm_diarize_speaker()`](https://thisisnic.github.io/speechmatics/reference/sm_diarize_speaker.md)
  or
  [`sm_diarize_channel()`](https://thisisnic.github.io/speechmatics/reference/sm_diarize_channel.md),
  or `NULL` for no diarization.

## Value

A config list suitable for passing to
[`sm_transcribe()`](https://thisisnic.github.io/speechmatics/reference/sm_transcribe.md).

## Examples

``` r
sm_transcription_config()
#> $type
#> [1] "transcription"
#> 
#> $transcription_config
#> $transcription_config$language
#> [1] "en"
#> 
#> $transcription_config$operating_point
#> [1] "standard"
#> 
#> 
sm_transcription_config(language = "fr", quality = "enhanced")
#> $type
#> [1] "transcription"
#> 
#> $transcription_config
#> $transcription_config$language
#> [1] "fr"
#> 
#> $transcription_config$operating_point
#> [1] "enhanced"
#> 
#> 
sm_transcription_config(diarization = sm_diarize_speaker())
#> $type
#> [1] "transcription"
#> 
#> $transcription_config
#> $transcription_config$language
#> [1] "en"
#> 
#> $transcription_config$operating_point
#> [1] "standard"
#> 
#> $transcription_config$diarization
#> [1] "speaker"
#> 
#> $transcription_config$speaker_diarization_config
#> $transcription_config$speaker_diarization_config$speaker_sensitivity
#> [1] 0.5
#> 
#> $transcription_config$speaker_diarization_config$prefer_current_speaker
#> [1] FALSE
#> 
#> 
#> 
```
