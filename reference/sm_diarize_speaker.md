# Configure speaker diarization

Configure speaker diarization

## Usage

``` r
sm_diarize_speaker(sensitivity = 0.5, prefer_current = FALSE)
```

## Arguments

- sensitivity:

  Numeric 0-1 (default `0.5`). Higher values detect more speakers.

- prefer_current:

  Logical. Reduces false switches between similar-sounding speakers.

## Value

A diarization config list.

## Examples

``` r
sm_diarize_speaker()
#> $diarization
#> [1] "speaker"
#> 
#> $speaker_diarization_config
#> $speaker_diarization_config$speaker_sensitivity
#> [1] 0.5
#> 
#> $speaker_diarization_config$prefer_current_speaker
#> [1] FALSE
#> 
#> 
sm_diarize_speaker(sensitivity = 0.8, prefer_current = TRUE)
#> $diarization
#> [1] "speaker"
#> 
#> $speaker_diarization_config
#> $speaker_diarization_config$speaker_sensitivity
#> [1] 0.8
#> 
#> $speaker_diarization_config$prefer_current_speaker
#> [1] TRUE
#> 
#> 
```
