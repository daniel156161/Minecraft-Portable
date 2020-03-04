@echo off
mode con lines=20 cols=120
color a
title %starter% Einstellungen
if not exist PCs\mc-config.bat goto Minecraft-Portable
call PCs\mc-config.bat

REM Version Prüfen
set aktuelleversion=6.0

if not %Version%==%aktuelleversion% goto Minecraft-Portable
goto start

:Minecraft-Portable
call Minecraft-Portable.bat
goto start

:launcher
cls
echo [0] Zuruch ins menu
echo.
echo [1] Minecraft Launcher
echo [2] Technic Launcher
echo [3] Cracket Launcher
echo.
set /p launcher=Bitte Zahl eingeben: 
if %launcher%==0 goto start
if %launcher%==1 goto minecraft
if %launcher%==2 goto technic
if %launcher%==3 goto cracket
goto start

:technic
del PCs\%computername%.bat
echo set jar=TechnicLauncher>>PCs\%computername%.bat
echo set Java=%Java%>>PCs\%computername%.bat
echo set ram=%ram%>>PCs\%computername%.bat
goto start

:cracket
del PCs\%computername%.bat
echo set jar=Cracket_Launcher>>PCs\%computername%.bat
echo set Java=%Java%>>PCs\%computername%.bat
echo set ram=%ram%>>PCs\%computername%.bat
goto start

:menu32
echo [1] = RAM einstellen
echo [2] = Update Suchen
echo [3] = Launcher
echo.
set /p ei=Bitte zahl eingeben: 
if %ei%==1 goto RAM
if %ei%==2 goto Update
if %ei%==3 goto launcher
echo Falsche Eingabe, der Befehl: %ei% gibt es nicht.
echo Bitte nochmal Versuchen
ping localhost -n 10>nul
goto start

:Java
CLS
echo Java Einstellen
echo.
echo [0] Zurueck ins Menu
echo.
echo [1] 32Bit
echo [2] 64Bit
echo.
set /p java=Bitte Zahl eingeben: 
if %java%==0 goto start
if %java%==1 goto Java32Bit
if %java%==2 goto Java64Bit
echo Falsche Eingabe, der Befehl: %java% gibt es nicht.
echo Bitte nochmal Versuchen
ping localhost -n 10>nul
goto start

:RAM
CLS
echo RAM Einstellen
echo.
echo.
echo [0] Zurueck ins Menu
echo.
echo 1GB Standart
echo.
echo M = MB
echo G = GB
echo.
set /p ram=Bitte Groesse eingeben: 
if %ram%==0 goto start
FOR /F "tokens=2 delims='='" %%A in ('wmic memorychip Get capacity /value') Do (Set "pram=%%A")
FOR /F "tokens=1 delims='|'" %%A in ("%pram%") Do (Set "pram=%%A")
set /a kb=%pram:~0,-3%
set /a mb = kb / 1024
set /a gb = mb / 1024
set /a gb = %gb% + %gb% - 1
if %ram% GTR %gb%G goto ram-error

del PCs\%computername%.bat
echo set jar=%jar%>>PCs\%computername%.bat
echo set Java=%Java%>>PCs\%computername%.bat
echo set ram=%ram%>>PCs\%computername%.bat
goto start

:Update
start https://www.dropbox.com/sh/lhl2rlzj1fdkli2/AABHIf2r28jWq8gpQIHUEcJqa?dl=0
goto start

:Java32Bit
del PCs\%computername%.bat
echo set jar=%jar%>>PCs\%computername%.bat
echo set Java=32>>PCs\%computername%.bat
echo set ram=%ram%>>PCs\%computername%.bat
goto start

:Java64Bit
del PCs\%computername%.bat
echo set jar=%jar%>>PCs\%computername%.bat
echo set Java=64>>PCs\%computername%.bat
echo set ram=%ram%>>PCs\%computername%.bat
goto start

:ram-error
cls
echo Der Verfuegbare Arbeitsspeicher betregt : %gb%GB
echo Du hast so viel RAM Eingegeben: %ram%B
pause
goto RAM

:minecraft
del PCs\%computername%.bat
echo set jar=Minecraft>>PCs\%computername%.bat
echo set Java=%Java%>>PCs\%computername%.bat
echo set ram=%ram%>>PCs\%computername%.bat
goto start

:start
if not exist PCs\%computername%.bat goto Minecraft-Portable
CLS
call PCs\%computername%.bat
title %starter% Einstellungen [Version: %Version%] [RAM: %ram%B] [Java: %java% Bit] [PC: %computername%] [Launcher: %jar%]
if /i %processor_architecture%==x86 goto menu32_beta
echo [1] = Java Einstellen
echo [2] = RAM einstellen
echo [3] = Update Suchen
echo [4] = Launcher
echo.
set /p ei=Bitte zahl eingeben: 
if %ei%==1 goto Java
if %ei%==2 goto RAM
if %ei%==3 goto Update
if %ei%==4 goto launcher
if %ei%==5 goto clear
echo Falsche Eingabe, der Befehl: %ei% gibt es nicht.
echo Bitte nochmal Versuchen
ping localhost -n 10>nul
goto start

:Update
start https://www.dropbox.com/sh/lhl2rlzj1fdkli2/AABHIf2r28jWq8gpQIHUEcJqa?dl=0
goto start

:clear
rmdir /s /q .minecraft
rmdir /s /q PCs
exit