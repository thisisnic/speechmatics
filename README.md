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

# Transcribe the bundled sample file
audio <- system.file("extdata", "testrecording.mp3", package = "speechmatics")
transcribe(audio, "output.txt")

# With custom config
transcribe(
  audio,
  "output.txt",
  config = transcription_config(
    language = "en",
    quality = "enhanced"
  )
)
```
