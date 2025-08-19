# merge_csvs.R
# Purpose: Merge all CSVs from a folder into one data frame and write a single CSV.
# Platform: cross-platform (macOS/Windows). Edit the input_dir and output_file paths below.

suppressPackageStartupMessages({
  library(readr)
  library(dplyr)
})

# ---- User inputs (edit these two paths) ----
# macOS example:
# input_dir   <- "~/Documents/CSV"  # folder containing .csv files
# output_file <- "~/Desktop/Outputs/merged_output.csv"
#
# Windows example:
# input_dir   <- "C:/Users/Desktop"
# output_file <- "C:/Users/Desktop/Outputs/merged_output.csv"

input_dir   <- path.expand("~/Documents/CSV")
output_file <- path.expand("~/Desktop/Outputs/merged_output.csv")

# ---- Safety checks ----
if (!dir.exists(input_dir)) {
  stop(sprintf("Input directory does not exist: %s", input_dir))
}
outdir <- dirname(output_file)
if (!dir.exists(outdir)) {
  dir.create(outdir, recursive = TRUE, showWarnings = FALSE)
}

# ---- List and read CSVs as character ----
file_list <- list.files(path = input_dir, pattern = "\\.(csv|CSV)$", full.names = TRUE)

if (length(file_list) == 0) {
  stop(sprintf("No .csv files found in: %s", input_dir))
}

read_csv_as_char <- function(file) {
  df <- read_csv(file, col_types = cols(.default = "c"), show_col_types = FALSE)
  df$source_file <- basename(file)
  df
}

merged_df <- lapply(file_list, read_csv_as_char) |> bind_rows()

# ---- Inspect ----
glimpse(merged_df)
print(merged_df, n = min(50, nrow(merged_df)))

# ---- Write output ----
write_csv(merged_df, output_file)
message(sprintf("Wrote merged CSV to: %s", output_file))
