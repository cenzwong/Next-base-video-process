ffmpeg -i ../VIDEO/250525_100549_675_FH.MP4 -i ../VIDEO/250525_100549_675_RH.MP4 -filter_complex \
"[1:v]scale=iw/4:ih/4[small];[0:v][small]overlay=0:0" \
-c:a copy output_combine.mp4


# 💡 Explanation
# [1:v]scale=iw/3:ih/3[small]
# → Resizes the back video to 1/9 the original size (1/3 width and 1/3 height)
# [0:v][small]overlay=0:H-h
# → Overlays the small video on the main one:
# 0: X position (left edge)
# H-h: Y position (bottom edge)
# -c:a copy
# → Copies the audio stream directly (usually from the front video)
# 🔄 Modify Positions (Optional)
# Bottom-right corner: overlay=W-w:H-h
# Top-left corner: overlay=0:0
# Top-right corner: overlay=W-w:0