is_replaying <- function() {
  as.logical(Sys.getenv("VCR_IS_REPLAYING", "FALSE"))
}

api_key <- function(error_call = rlang::caller_env()) {
  key <- Sys.getenv("SPEECHMATICS_API_KEY")
  if (nzchar(key)) {
    return(key)
  }
  if (is_replaying()) {
    return("")
  }
  cli::cli_abort("Can't find env var {.envvar SPEECHMATICS_API_KEY}.", call = error_call)
}

#' Build an authenticated API request
#'
#' Creates an httr2 request to the Speechmatics API with bearer token
#' authentication and automatic retries.
#'
#' @return An httr2 request object.
#' @noRd
req <- function() {
  httr2::request("https://asr.api.speechmatics.com/v2") |>
    httr2::req_auth_bearer_token(api_key()) |>
    httr2::req_retry(max_tries = 3, retry_on_failure = TRUE)
}
