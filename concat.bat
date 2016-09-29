@echo OFF

timeout /t 20
cd C:\Users\confl\Desktop\T360\segments\%date:/=%\

:loop
	
	call C:\Users\confl\Desktop\T360\list.bat

	C:\Users\confl\Desktop\ffmpeg\bin\ffmpeg -y -f concat -i mylist.txt -c copy C:\Users\confl\Desktop\T360\Streams\%date:/=%.mp4 -c copy -ss E:\%date:/=%.mp4

	timeout /t 20

goto loop