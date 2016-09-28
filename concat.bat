@echo OFF

timeout /t 20
cd C:\Users\confl\Desktop\ffmpeg\bin\segments

:loop
	
	call list.bat

	..\ffmpeg -y -f concat -i mylist.txt -c copy ..\output.mp4 

	timeout /t 20

goto loop
