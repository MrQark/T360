@echo OFF
setlocal EnableDelayedExpansion

set d = "aa"
timeout /t 40

:loop
	
	for /F "tokens=1*" %%a in ('fsutil fsinfo drives') do (
	   for %%c in (%%b) do (
	      for /F "tokens=3" %%d in ('fsutil fsinfo drivetype %%c') do (
	         if %%d equ Removable (
				cd C:\Users\confl\Desktop\T360
				call list.bat
				cd C:\Users\confl\Desktop\T360\segments\%date:/=%\
				C:\Users\confl\Desktop\ffmpeg\bin\ffmpeg -y -f concat -i mylist.txt -c copy C:\Users\confl\Desktop\T360\streams\%date:/=%.mp4 -c copy %%c%date:/=%.mp4
	         )
	      )
	   )
	)



	timeout /t 40

goto loop