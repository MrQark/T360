cd C:\Users\confl\Desktop\ffmpeg\bin\
mkdir C:\Users\confl\Desktop\T360\segments\%date:/=%

:loop
ffmpeg -y -rtbufsize 500M -f dshow -i video="THETA UVC Blender":audio="@device_cm_{33D9A762-90C8-11D0-BD43-00A0C911CE86}\wave_{CF6D8BB5-5E46-4D77-BCE5-4D8B3B53054F}" -c:v libx264 -vf "scale=iw*.25:ih*.25, fps=15" -preset ultrafast -c:a aac -b:a 32k -f mpegts udp://7.206.92.181:1234 -c copy -c:v libx264 -vf "fps=15" -preset ultrafast -c:a aac -b:a 128k -f segment -segment_time 30 -strftime 1 -use_localtime 1 C:\Users\confl\Desktop\T360\segments\%date:/=%\%%Hh%%Mm%%Ss.mp4
timeout /t 10
goto loop