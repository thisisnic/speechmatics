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
transcribe("testrecording.mp3")

# Specify output path
transcribe("testrecording.mp3", "output.txt")

# Enhanced quality with speaker diarization
transcribe(
  "interview.mp3",
  config = transcription_config(
    quality = "enhanced",
    diarization = diarize_speaker()
  )
)
```
