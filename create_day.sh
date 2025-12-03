#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<EOF
Usage: $0 YEAR DAY

Creates directories YEAR/DAY (no-op if they already exist) and four files inside:
  {DAY}-1.ipynb
  {DAY}-2.ipynb
  input.txt
  test_input.txt

Example:
  $0 2025 1
EOF
  exit 2
}

if [ "$#" -lt 2 ]; then
  usage
fi

year="$1"
day="$2"

# sanitize trailing slashes just in case
year=${year%/}
day=${day%/}

dir="$year/$day"
mkdir -p "$dir"

files=(
  "$dir/${day}-1.ipynb"
  "$dir/${day}-2.ipynb"
  "$dir/input.txt"
  "$dir/test_input.txt"
)

for f in "${files[@]}"; do
  # create file if it doesn't exist; if it exists, leave it unchanged
  if [ ! -e "$f" ]; then
    : > "$f"
  fi
done

echo "Ensured directory: $dir"
echo "Files created/existed:"
for f in "${files[@]}"; do
  echo " - $f"
done

exit 0
