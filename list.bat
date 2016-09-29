@echo OFF
setlocal EnableDelayedExpansion

set LINES=0
for %%I in (*.mp4) do (
	set /a LINES=LINES+1    
)

set /a LINES=LINES-1

call:PrintFirstNLine > mylist.txt

goto EOF

:PrintFirstNLine
set cur=0
for %%I in (*.mp4) do (      
	echo file '%%I'        	     
	set /a cur=cur+1    
	if "!cur!"=="%LINES%" goto EOF
) 

:EOF 
exit /b