#' Submit a transcription job
#'
#' @param audio_path Path to the audio file.
#' @param config Config list from `transcription_config()`.
#' @return The job ID (character string).
#' @noRd
submit <- function(audio_path, config = transcription_config()) {
  resp <- req() |>
    httr2::req_url_path_append("jobs") |>
    httr2::req_body_multipart(
      data_file = curl::form_file(audio_path),
      config = curl::form_data(jsonlite::toJSON(unclass(config), auto_unbox = TRUE))
    ) |>
    httr2::req_perform()

  httr2::resp_body_json(resp)$id
}

#' List all jobs
#'
#' @return A data frame of jobs.
#' @noRd
list_jobs <- function() {
  resp <- req() |>
    httr2::req_url_path_append("jobs") |>
    httr2::req_perform()

  jobs <- httr2::resp_body_json(resp)$jobs
  do.call(rbind, lapply(jobs, function(j) {
    tc <- j$config$transcription_config
    data.frame(
      id = j$id,
      status = j$status,
      created_at = j$created_at,
      data_name = j$data_name,
      duration = j$duration,
      language = tc$language %||% NA_character_,
      operating_point = tc$operating_point %||% NA_character_,
      diarization = tc$diarization %||% NA_character_
    )
  }))
}

#' Get job status
#'
#' @param job_id Job ID string.
#' @return Status string.
#' @noRd
get_status <- function(job_id) {
  resp <- req() |>
    httr2::req_url_path_append("jobs", job_id) |>
    httr2::req_perform()

  httr2::resp_body_json(resp)$job$status
}

#' Get transcript for a completed job as text
#'
#' @param job_id Job ID string.
#' @param format Output format: `"txt"` for plain text (default) or `"srt"` for
#'   subtitles.
#' @return Transcript as a character string.
#' @noRd
get_transcript <- function(job_id, format = c("txt", "srt")) {
  format <- match.arg(format)

  resp <- req() |>
    httr2::req_url_path_append("jobs", job_id, "transcript") |>
    httr2::req_url_query(format = format) |>
    httr2::req_perform()

  httr2::resp_body_string(resp)
}

#' Get transcript for a completed job as structured data
#'
#' @param job_id Job ID string.
#' @return A list containing the parsed JSON transcript with timestamps,
#'   speaker labels, and confidence scores.
#' @noRd
get_transcript_json <- function(job_id) {
  resp <- req() |>
    httr2::req_url_path_append("jobs", job_id, "transcript") |>
    httr2::req_url_query(format = "json-v2") |>
    httr2::req_perform()

  httr2::resp_body_json(resp)
}

#' Delete a job
#'
#' @param job_id Job ID string.
#' @return `TRUE`, invisibly.
#' @noRd
delete_job <- function(job_id) {
  req() |>
    httr2::req_url_path_append("jobs", job_id) |>
    httr2::req_method("DELETE") |>
    httr2::req_perform()

  invisible(TRUE)
}

#' Get usage statistics
#'
#' @return A data frame of usage details by language and operating point.
#' @noRd
usage <- function() {
  resp <- req() |>
    httr2::req_url_path_append("usage") |>
    httr2::req_perform()

  body <- httr2::resp_body_json(resp)
  df <- do.call(rbind, lapply(body$details, as.data.frame))
  df$duration_hrs <- round(df$duration_hrs, 2)
  df
}

#' Transcribe an audio file
#'
#' Submits an audio file to the Speechmatics API, polls until complete,
#' and writes the transcript to a file.
#'
#' @param input Path to the input audio file.
#' @param output Path to the output transcript file. If `NULL` (the default),
#'   the output path is derived from `input` by replacing the file extension
#'   with `.txt`.
#' @param config Config from `transcription_config()`.
#' @param poll_interval Seconds between status checks.
#' @return The output path, invisibly.
#' @export
transcribe <- function(input, output = NULL, config = transcription_config(),
                       poll_interval = 5) {
  if (!is.character(input) || length(input) != 1) {
    cli::cli_abort("{.arg input} must be a single string, not {.obj_type_friendly {input}}.")
  }
  if (!file.exists(input)) {
    cli::cli_abort("Can't find file {.path {input}}.")
  }
  if (!is.null(output) && (!is.character(output) || length(output) != 1)) {
    cli::cli_abort("{.arg output} must be a single string or {.code NULL}, not {.obj_type_friendly {output}}.")
  }

  if (is.null(output)) {
    output <- sub("\\.[^.]+$", ".txt", input)
  }

  cli::cli_progress_step("Submitting {.path {input}}")
  job_id <- submit(input, config)
  cli::cli_alert_info("Job ID: {.val {job_id}}")

  cli::cli_progress_step("Waiting for transcription")
  status <- get_status(job_id)
  while (status == "running") {
    Sys.sleep(poll_interval)
    status <- get_status(job_id)
  }

  if (status != "done") {
    cli::cli_abort("Transcription job failed with status {.val {status}}.")
  }

  cli::cli_progress_step("Downloading transcript")
  transcript <- get_transcript(job_id)
  writeLines(transcript, output)
  cli::cli_alert_success("Saved to {.path {output}}")
  invisible(output)
}
