#!/usr/bin/env bash

# timestampt flags
ts=`date +%Y-%m-%d`
year=`date +%Y`
month=`date +%m`
day=`date +%d`

help()
{
  echo "The $0 script can help you sort files and reorganize them according to filters you desire\n"
  echo "-D organizes files by the full date ordered YYYY-MM-DD"
  echo "-y <year> is used to specify the year of the files you want to sort"
  echo "-e is used to specify the extension of the files you want to sort"
   
  echo
  echo "Options:"
  echo "  -l LOWER     Specify the lower bound (numbers at the start of the filename) for filtering."
  echo "  -h HIGHER    Specify the higher bound (numbers close to the extension) for filtering."
  echo "  -e EXT       Specify the file extension to filter (e.g., txt, jpg)."

  echo
  echo "This script filters files in the current directory whose names contain a number"
  echo "within the specified range and have the given file extension."


  echo
  echo "Example:"
  echo "  $0 -l 10 -h 20 -e txt"
  echo "    Lists files like file10.txt, file15.txt, file20.txt"
}

while getopts "l:h:e:" opt; do
  case $opt in
    l)
      low_bound="$OPTARG"
      ;;
    h)
      high_bound="$OPTARG"
      ;;
    e)
      file_ext="$OPTARG"
      ;;
    \?)
      echo "Usage: $0 -l lower_number -h higher_number -e file_extension"
      exit 1
      ;;
  esac
done

# Check required options
if [ -z "$low_bound" ] || [ -z "$high_bound" ] || [ -z "$file_ext" ]; then
  echo "Error: All options -l, -h, and -e are required."
  echo "Usage: $0 -l lower_number -h higher_number -e file_extension"
  exit 1
fi

# Example usage: filter files in the current directory
for file in *."$file_ext"; do
  # Extract number from filename (assuming format: nameNUMBER.extension)
  num=$(echo "$file" | grep -o -E '[0-9]+')
  if [ -n "$num" ] && [ "$num" -ge "$low_bound" ] && [ "$num" -le "$high_bound" ]; then
    echo "$file"
  fi
done

if [ -z "$opt_a" ]; then
  echo "Error: Option -a is required."
  exit 1
fi

check_log_folder()
{
  # check log folder
}



echo "Done"


exit 0
