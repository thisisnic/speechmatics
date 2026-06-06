# speechmatics

An R client for the [Speechmatics](https://www.speechmatics.com/) speech-to-text API.

## Installation

```r
# install.packages("pak")
pak::pak("thisisnic/speechmatics")
```

## Setup

Set your API key as an environment variable:

```r
Sys.setenv(SPEECHMATICS_API_KEY = "your-key-here")
```

Or add it to your `.Renviron`:

```
SPEECHMATICS_API_KEY=your-key-here
```

## Usage

```r
library(speechmatics)

# Transcribe an audio file (writes `./testrecording.txt`)
audio <- system.file("extdata", "testrecording.mp3", package = "speechmatics")
sm_transcribe(audio)

# Specify output path
sm_transcribe(audio, "output.txt")

# Enhanced quality with speaker diarization
sm_transcribe(
  audio,
  config = sm_transcription_config(
    quality = "enhanced",
    diarization = sm_diarize_speaker()
  )
)
```
