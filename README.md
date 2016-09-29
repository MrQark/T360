# T360
Video streaming for T360 platform using ffmpeg.

Files stream.bat and concat.bat should be launched on startup.
You should check and update all paths in the batch files.

 - C:\Users\confl\Desktop\ffmpeg\bin\ - location of ffmpeg.exe
 - C:\Users\confl\Desktop\T360\list.bat - location of list.bat
 - C:\Users\confl\Desktop\T360\streams\ - location of concatenated streams
 - C:\Users\confl\Desktop\T360\segments\ - path to segments folder


## stream.bat 
Batch file for launching ffmpeg streaming.

1. cd C:\Users\confl\Desktop\ffmpeg\bin\
 - go to ffmpeg folder;

1. mkdir C:\Users\confl\Desktop\T360\segments\%date:/=%
 - create folder for storing video segments
 
2. del /Q /S segments\
 - delete all previous recorded segments

3. ffmpeg
 - you can download ffmpeg for windows here: https://ffmpeg.zeranoe.com/builds/;

3. -y 
 - to overwrite file if exists

4. -rtbufsize 500M
 - realtime buffer size 500 MB;

5. -f dshow
 - choose DirectShow for input devices;

6. -i video="THETA UVC Blender":audio="@device_cm_{33D9A762-90C8-11D0-BD43-00A0C911CE86}\wave_{CF6D8BB5-5E46-4D77-BCE5-4D8B3B53054F}"
 - input video from THETA UVC Blender (live streaming driver for RICOH THETA S with conversion to equirectangular format (https://theta360.com/en/support/download/)). Input audio from RICOH THETA S, to see device id (@device_cm_) use this command: ffmpeg -list_devices true -f dshow -i dummy;

7. -c:v libx264
 - x264 for video encoding;

8. -vf "scale=iw*.25:ih*.25, fps=15"
 - video filter: 1/4 scaling from initial resolution, fps=15 - constant framerate to avoid "Past duration too large" warnings;

9. -preset ultrafast
 - preset for fast video encoding;

10. -tune zerolatency (optional)
 - decrease latency to ~2 sec. Significantly decreases quality of compression for low bitrates or slow internet. Not used for now;

11. -c:a aac -b:a 32k
 - audio codec AAC, bitrate 32k;

12. -f mpegts
 - file format: MPEG Transport;

13. udp://7.206.92.181:1234
 - UDP stream to server;

14. -c copy
 - copy stream;

15. -f segment -segment_time 15
 - write video in 15 seconds segments;
 
15. -strftime 1 -use_localtime 1
 - use local date and time in filename;

16. C:\Users\confl\Desktop\T360\segments\%date:/=%\%%Hh%%Mm%%Ss.mp4
 - write segments to today's date folder, filename is current time (ex. 19h27m13s)

## list.bat
Creates mylist.txt for today's date folder that contains the list of all segments for concatenation, except last one. Last clip for concatenation does not exist at the moment.

## concat.bat
This script call list.bat and uses mylist.txt for concatenation. It is infinite loop.
The name of output file is today's date (ex. 2015-09-29). All segments that were recorded in one day are concatenated in one file.
