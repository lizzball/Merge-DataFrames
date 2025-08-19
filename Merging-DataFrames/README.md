# Merging DataFrames

Simple R script to merge all CSVs in a folder and save one combined file.

## Usage
1. Edit the two paths at the top of `merge_csvs.R` (`input_dir`, `output_file`).  
   - macOS example: `~/Documents/CSV` → `~/Desktop/Outputs/merged_output.csv`  
   - Windows example: `C:/Users/Desktop` → `C:/Users/ElizabethBell/Desktop/Outputs/merged_output.csv`
2. Run in R:
   ```r
   source("merge_csvs.R")
   ```

The script reads all `.csv` files in `input_dir`, adds `source_file`, and writes a single CSV.
