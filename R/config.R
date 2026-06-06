#' Configure speaker diarization
#'
#' @param sensitivity Numeric 0-1 (default `0.5`). Higher values detect more
#'   speakers.
#' @param prefer_current Logical. Reduces false switches between
#'   similar-sounding speakers.
#' @return A diarization config list.
#' @examples
#' sm_diarize_speaker()
#' sm_diarize_speaker(sensitivity = 0.8, prefer_current = TRUE)
#' @export
sm_diarize_speaker <- function(sensitivity = 0.5, prefer_current = FALSE) {
  list(
    diarization = "speaker",
    speaker_diarization_config = list(
      speaker_sensitivity = sensitivity,
      prefer_current_speaker = prefer_current
    )
  )
}

#' Configure channel diarization
#'
#' @param labels Character vector of channel labels (e.g. `c("Agent", "Caller")`).
#' @return A diarization config list.
#' @examples
#' sm_diarize_channel()
#'
#' # label channels
#' sm_diarize_channel(labels = c("Nic", "Jess"))
#' @export
sm_diarize_channel <- function(labels = NULL) {
  cfg <- list(diarization = "channel")
  if (!is.null(labels)) {
    cfg$channel_diarization_labels <- labels
  }
  cfg
}

#' Build transcription config
#'
#' @param language Language code (default `"en"`).
#' @param quality `"standard"` or `"enhanced"`.
#' @param diarization A diarization object from `sm_diarize_speaker()` or
#'   `sm_diarize_channel()`, or `NULL` for no diarization.
#' @return A config list suitable for passing to [sm_transcribe()].
#' @examples
#' sm_transcription_config()
#' sm_transcription_config(language = "fr", quality = "enhanced")
#' sm_transcription_config(diarization = sm_diarize_speaker())
#' @export
sm_transcription_config <- function(language = "en",
                      quality = c("standard", "enhanced"),
                      diarization = NULL) {
  quality <- match.arg(quality)

  tc <- list(language = language, operating_point = quality)

  if (!is.null(diarization)) {
    tc <- c(tc, diarization)
  }

  list(type = "transcription", transcription_config = tc)
}
