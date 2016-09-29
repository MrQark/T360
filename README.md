# T360
Video streaming for T360 platform using ffmpeg.

## Stream.bat 
Batch file for launching ffmpeg streaming.
1. cd C:\Users\confl\Desktop\ffmpeg\bin\
go to ffmpeg folder;

2. del /Q /S segments\
delete all previous recorded segments

3. C:\Users\confl\Desktop\ffmpeg\bin\ffmpeg
location of ffmpeg. command should be launched from this folder. you can download ffmpeg for windows here: https://ffmpeg.zeranoe.com/builds/;

3. -y - to overwrite file if exists
-rtbufsize 500M - realtime buffer size 500 MB;

-f dshow - choose DirectShow for input devices;

-i video="THETA UVC Blender":audio="@device_cm_{33D9A762-90C8-11D0-BD43-00A0C911CE86}\wave_{CF6D8BB5-5E46-4D77-BCE5-4D8B3B53054F}" - input video from THETA UVC Blender - live streaming driver for RICOH THETA S with conversion to equirectangular format (https://theta360.com/en/support/download/). Input audio from RICOH THETA S, to see device id (@device_cm_) use this command: ffmpeg -list_devices true -f dshow -i dummy;

-c:v libx264 - x264 for video encoding;

-vf "scale=iw*.25:ih*.25, fps=15" - video filter: 1/4 scaling from initial resolution, fps=15 - constant framerate to avoid "Past duration too large" warnings;

-preset ultrafast - preset for fast video encoding;

-tune zerolatency (optional) - decrease latency to ~2 sec. Significantly decreases quality of compression for low bitrates or slow internet. Not used for now;

-c:a aac -b:a 32k - audio codec AAC, bitrate 32k;

-f mpegts - file format: MPEG Transport;

udp://7.206.92.181:1234 - UDP stream to server;

-c copy - copy stream;

-f segment -segment_time 60 - Write video in 60 seconds segments'

E:\stream%%03d.mp4 - Write video to flash drive, %03d - enumeration format, %% - percent sign in batch files.
