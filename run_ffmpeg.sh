#!/bin/bash

# Check if filelist.txt exists and is not empty
if [ ! -s filelist.txt ]; then
  echo "❌ filelist.txt not found or empty."
  exit 1
fi

# Get today's date in YYMMDD
today=$(date +"%y%m%d")
output="merged_${today}_1.mp4"

# Run ffmpeg
# 1. Concat videos to video 
# 2. Encode the mp4 to make it less bulky (takes comsuming)

ffmpeg -f concat -safe 0 -i filelist.txt -c copy "$output"
ffmpeg -i input.mp4 -c:v libx264 -preset slow -b:v 5M -c:a aac -b:a 128k -movflags +faststart output.mp4

# Two command in one
# ffmpeg -f concat -safe 0 -i filelist.txt \
#   -c:v libx264 -preset slow -b:v 5M \
#   -c:a aac -b:a 128k \
#   -movflags +faststart merged_compressed.mp4


echo "✅ Merge completed: $output"
