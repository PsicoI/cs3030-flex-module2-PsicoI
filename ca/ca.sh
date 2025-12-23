#!/usr/bin/env bash

# Author: Cody Turek
# Date: 2025-June-13
# Module 2: Challenege Activity: FILE-FILTER3000

# opt_a=${low_bound}${high_bound}${file_ext} DEPRECATED
usage_desc="Usage: $0 -l lower number -u higher number -e file extension"
help()
{
  echo "The $0 script can help you filters, sort, and reorganize files."
  echo "It can be used to filter files based on a range of numbers in their names and a specific file extension."
  echo
  echo "Usage:"
  echo "  $0 -l lower number in range -u higher number in range -e file extension"
  
  echo
  echo "Options:"
  echo "  -l LOWER     Specify the lower bound (numbers at the start of the filename) for filtering."
  echo "  -u UPPER    Specify the higher bound (numbers close to the extension) for filtering."
  echo "  -e EXT       Specify the file extension to filter (e.g., txt, jpg)."
  echo
  echo "OPTIONAL PARAMETERS:"
  echo "  -m, --move   Move files instead of copying them to the log directory."

  echo
  echo "Example:"
  echo "  $0 -l 10 -u 20 -e txt"
  echo "    Lists files like file10.txt, file15.txt, file20.txt"
}

# Checks if no options are provided
if [ $# -eq 0 ]; then
    echo "No options provided."
    echo "Use -h or --help for usage information."
    exit 1
fi

# Parse command line options
while getopts "l:u:e:" opt; do
  case $opt in
    l|-l)
      low_bound="$OPTARG"
      ;;
    u|-u)
      high_bound="$OPTARG"
      ;;
    e|-e)
      file_ext="$OPTARG"
      ;;
    \?|?|help|--help|-h)
      help
      echo $usage_desc
      exit 1
      ;;
      m|-m|-mv|--move)
        move_files=true
        ;;
  esac
done

if [ -z "$low_bound" ] || [ -z "$high_bound" ] || [ -z "$file_ext" ]; then
  help
  exit 1
fi

# Check if all required options are provided
if [ -z "$low_bound" ] || [ -z "$high_bound" ] || [ -z "$file_ext" ]; then
  echo "Error: All options -l, -u, and -e are required."
  echo $usage_desc
  exit 1
fi

# Example usage: filter files in the current directory
for file in *."$file_ext"; do
  # Extract number from filename (assuming format: nameNUMBER.extension)
  num=$(echo "$file" | grep -o -E '[0-9]+')
  if [ -n "$num" ] && [ "$num" -ge "$low_bound" ] && [ "$num" -le "$high_bound" ]; then # Check if the number is within the specified range
    echo "$file"
  fi
done





# This function checks if the log folder exists 
# and creates it if it does not.
checking_log_folder() { 
    year=$(date +%Y)
    month=$(date +%m)
    day=$(date +%d)
    logdir="log/$year/$month/$day"
    echo "Checking $logdir structure"
    if [ ! -d "$logdir" ]; then
        echo "Missing folder. Creating one"
        mkdir -p "$logdir"
    fi
}



# This function filters files based on the provided range bounds and extension.
filter_files() {
    echo "Filtering files range [$low_bound-$high_bound] for extension $file_ext"
    year=$(date +%Y) # Get current year
    month=$(date +%m) # Get current month
    day=$(date +%d) # Get current day
    logdir="log/$year/$month/$day" # Create log directory based on date
    no_pattern -s nullglob # Tells shell to not throw error if no patterns found
    for file in ./data/data_*.$file_ext; do
        # Extract the number part using parameter expansion and pattern matching
        filename=$(basename "$file")
        num="${filename#data_}"
        num="${num%%.*}"
        # Check if num is an integer and within the range
        if [[ "$num" =~ ^[0-9]+$ ]] && [ "$num" -ge "$low_bound" ] && [ "$num" -le "$high_bound" ]; then
            if [ "$move_files" = true ]; then # Check if move_files is set to true
          mv "$file" "$logdir/"
          echo "Moved $filename to $logdir/"
            else
          cp "$file" "$logdir/"
          echo "Copied $filename to $logdir/"
            fi
        fiz
    done
    no_pattern -u nullglob
}

# Main script execution
checking_log_folder
filter_files

echo "Done"


exit 0 # clean exit
# Exit with status 0 to indicate success
