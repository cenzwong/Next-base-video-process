import glob
import datetime
import os

# --- User Settings ---

# Main Nextbase SD card path
nextbase_path = "/Volumes/NEXTBASE/DCIM"

# Use today's date if None, or set manually e.g., '250729'
DATE_PREFIX = "250729"

# Optional time filter in HHMMSS (24hr) format
TIME_START = "110000"   # e.g., '170000'
TIME_END   = "150000"   # e.g., '180000'

# --- Logic ---

# Use today's date if not provided
if DATE_PREFIX is None:
    DATE_PREFIX = datetime.datetime.now().strftime("%y%m%d")

# Find *_FH.MP4 files in VIDEO and PROTECTED folders
video_paths = glob.glob(f"{nextbase_path}/VIDEO/{DATE_PREFIX}_*_FH.MP4")
video_paths += glob.glob(f"{nextbase_path}/PROTECTED/{DATE_PREFIX}_*_FH.MP4")

# Extract HHMMSS from filename (e.g., 250729_170950_787_FH.MP4 → 170950)
def extract_time_str(path):
    filename = os.path.basename(path)
    try:
        return filename.split("_")[1]  # second segment is time
    except IndexError:
        return "000000"

# Optional time filtering
if TIME_START or TIME_END:
    def in_time_range(path):
        t = extract_time_str(path)
        return (TIME_START or "000000") <= t <= (TIME_END or "235959")
    video_paths = list(filter(in_time_range, video_paths))

# Sort paths by extracted HHMMSS
video_paths.sort(key=extract_time_str)

# Write to filelist.txt
if video_paths:
    with open("filelist.txt", "w") as f:
        for path in video_paths:
            f.write(f"file '{path}'\n")
    print(f"✅ {len(video_paths)} video(s) written to filelist.txt")
else:
    print("❌ No matching videos found.")
