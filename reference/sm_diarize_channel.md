# Configure channel diarization

Configure channel diarization

## Usage

``` r
sm_diarize_channel(labels = NULL)
```

## Arguments

- labels:

  Character vector of channel labels (e.g. `c("Agent", "Caller")`).

## Value

A diarization config list.

## Examples

``` r
sm_diarize_channel()
#> $diarization
#> [1] "channel"
#> 

# label channels
sm_diarize_channel(labels = c("Nic", "Jess"))
#> $diarization
#> [1] "channel"
#> 
#> $channel_diarization_labels
#> [1] "Nic"  "Jess"
#> 
```
