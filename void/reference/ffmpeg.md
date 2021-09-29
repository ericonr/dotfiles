# FFmpeg

## Resize video

Base command: `ffmpeg -i <input> <output>`

Intermediary options:

- `-vcodec libx265|libx264`
- `-crf <value>` reasonable range for h265 is 24 to 30, 34 still looks like something
- `-b <number>k` bitrate (per second)
- `-fs <number>` file size limit
- `-vf "scale=trunc(iw/4)*2:trunc(ih/4)*2"` filter to scale by half
- `-vf scale=1280:720` filter to scale to 720p
