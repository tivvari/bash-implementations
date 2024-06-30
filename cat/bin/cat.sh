#!/usr/bin/env bash

infile=

if (($# == 0)); then
  # Default to reading stdin
  set -- -
fi

for file in "$@"; do
  if [[ "$file" = "-" ]] || [[ -z "$file" ]]; then
    infile=/dev/stdin
  else
    infile="$file"
  fi

  while IFS= read -r line; do
    printf '%s\n' "$line"
  done <"$infile"
done