test_that("transcribe validates inputs", {
  expect_error(transcribe(123), "must be a single string")
  expect_error(transcribe(c("a.mp3", "b.mp3")), "must be a single string")
  expect_error(transcribe("nonexistent.mp3"), "Can't find file")
  audio <- system.file("extdata", "testrecording.mp3", package = "speechmatics")
  expect_error(transcribe(audio, output = 123), "must be a single string")
})

test_that("get_status returns status string", {
  vcr::local_cassette("get-status")
  status <- get_status("75m0l7rsfy")
  expect_identical(status, "done")
})

test_that("get_transcript returns transcript text", {
  vcr::local_cassette("get-transcript")
  transcript <- get_transcript("75m0l7rsfy")
  expect_identical(transcript, "Hi. This is a test recording.")
})

test_that("list_jobs returns a data frame", {
  vcr::local_cassette("list-jobs")
  jobs <- list_jobs()
  expect_s3_class(jobs, "data.frame")
})
