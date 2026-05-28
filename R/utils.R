base_url <- function() {
  "https://asr.api.speechmatics.com/v2"
}

api_key <- function() {
  key <- Sys.getenv("SPEECHMATICS_API_KEY")
  if (!nzchar(key)) stop("Set the SPEECHMATICS_API_KEY env var.")
  key
}

req <- function() {
  httr2::request(base_url()) |>
    httr2::req_auth_bearer_token(api_key())
}

