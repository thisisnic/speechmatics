# Getting Started with speechmatics

## Authentication

The package uses the Speechmatics API, which requires an API key. Sign
up at <https://www.speechmatics.com/> to get one, then set it as an
environment variable:

``` r

Sys.setenv(SPEECHMATICS_API_KEY = "your-key-here")
```

For persistent use, add it to your `.Renviron` file:

    SPEECHMATICS_API_KEY=your-key-here

## Basic transcription

[`sm_transcribe()`](https://thisisnic.github.io/speechmatics/reference/sm_transcribe.md)
submits an audio file, waits for the result, and writes the transcript
to a text file in your working directory:

``` r

library(speechmatics)

audio <- system.file("extdata", "testrecording.mp3", package = "speechmatics")
sm_transcribe(audio)
#> ✔ Submitting 'testrecording.mp3'
#> ℹ Job ID: "2om9psu1np"
#> ✔ Waiting for transcription [5.8s]
#> ✔ Saved to testrecording.txt
```

You can also specify the output path:

``` r

sm_transcribe(audio, "my_transcript.txt")
#> ✔ Submitting 'testrecording.mp3'
#> ℹ Job ID: "2om9psu1np"
#> ✔ Waiting for transcription [5.8s]
#> ✔ Saved to my_transcript.txt
```

## Configuration

Use
[`sm_transcription_config()`](https://thisisnic.github.io/speechmatics/reference/sm_transcription_config.md)
to control language, quality, and diarization:

``` r

# French, enhanced quality
sm_transcribe(
  audio,
  config = sm_transcription_config(language = "fr", quality = "enhanced")
)
#> ✔ Submitting 'testrecording.mp3'
#> ℹ Job ID: "2om9psu1np"
#> ✔ Waiting for transcription [6.1s]
#> ✔ Saved to testrecording.txt
```

### Speaker diarization

Speaker diarization identifies who said what from a single audio
channel:

``` r

sm_transcribe(
  audio,
  config = sm_transcription_config(diarization = sm_diarize_speaker())
)
#> ✔ Submitting 'testrecording.mp3'
#> ℹ Job ID: "3kn7xr2abc"
#> ✔ Waiting for transcription [7.2s]
#> ✔ Saved to testrecording.txt
```

### Channel diarization

Channel diarization separates speakers that are already on different
audio channels:

``` r

sm_transcribe(
  audio,
  config = sm_transcription_config(
    diarization = sm_diarize_channel(labels = c("Agent", "Caller"))
  )
)
#> ✔ Submitting 'testrecording.mp3'
#> ℹ Job ID: "5pq2mt4def"
#> ✔ Waiting for transcription [6.5s]
#> ✔ Saved to testrecording.txt
```

## Managing jobs

You can work with jobs directly using the lower-level functions:

``` r

# list all jobs
jobs <- sm_list_jobs()
jobs
#>           id status               created_at             data_name duration
#> 1 2om9psu1np   done 2026-06-06T08:12:19.089Z     testrecording.mp3        3
#> 2 w06jp9mjvm   done 2026-06-04T10:19:28.351Z               idea-morning-walk.mp3     2037
#> 3 xco00nzvpq   done 2026-06-01T11:33:28.303Z conf-talk.mp3     1501
#>   language operating_point diarization
#> 1       en        standard        <NA>
#> 2       en        enhanced     speaker
#> 3       en        enhanced     speaker

# get a transcript in different formats
sm_get_transcript("2om9psu1np")
#> [1] "Hi. This is a test recording."

sm_get_transcript("2om9psu1np", format = "srt")
#> [1] "1\n00:00:00,000 --> 00:00:02,000\nHi. This is a test recording.\n"

sm_get_transcript("2om9psu1np", format = "json-v2")
#> $format
#> [1] "2.9"
#>
#> $job
#> $job$created_at
#> [1] "2026-06-06T08:12:19.089Z"
#>
#> $job$data_name
#> [1] "testrecording.mp3"
#>
#> $results
#> $results[[1]]
#> $results[[1]]$alternatives
#> $results[[1]]$alternatives[[1]]
#> $results[[1]]$alternatives[[1]]$confidence
#> [1] 1
#>
#> $results[[1]]$alternatives[[1]]$content
#> [1] "Hi"
#>
#> ...

# delete a job
sm_delete_job("2om9psu1np")
```
