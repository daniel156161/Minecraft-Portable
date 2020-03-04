@echo off
color a
REM Ladet Config oder erstellt Config (aktuelle Versions Variable)

set aktuelleversion=8.0

:start
if not exist PCs\mc-config.bat goto Config-erstellen
call PCs\mc-config.bat
title %starter%

if not exist bin\mc-logic.bat goto logic-error
REM Version Pr�fen
if not %Version%==%aktuelleversion% goto Config-loeschen

REM �berbr�fen
call bin\mc-logic.bat load
call bin\mc-logic.bat ram-check

REM Sucht den Pfad zum .minecraft-Verzeichnis
SET AppData=%CD%\data

REM �berpr�ft ob sich JavaPortable unter \Java installiert ist und nutzt dann dieses
if %Java%==64 goto 64
if %Java%==32 goto 32

:64
if exist %CD%\bin\Java64\bin\javaw.exe SET PATH=%CD%\bin\Java64\bin
goto startminecraft

:32
if exist %CD%\bin\Java\bin\javaw.exe SET PATH=%CD%\bin\Java\bin
goto startminecraft

:startminecraft
REM Startet Minecraft
if %jar%==Minecraft goto Minecraft
start javaw.exe -Xms128M -Xmx%ram% -jar bin\%jar%.jar
exit

:Minecraft
start "" "%CD%\bin\MinecraftLauncher.exe" --workDir "%CD%\data\.minecraft" --lockDir %CD%\data\.minecraft
exit

REM Configs
:Config-erstellen
mkdir PCs
echo set sjar=Minecraft>>PCs\mc-config.bat
:createconfig
echo set Version=%aktuelleversion%>>PCs\mc-config.bat
echo set starter=Minecraft-Portable>>PCs\mc-config.bat
call PCs\mc-config.bat
title %starter%
color a
goto start

:Config-loeschen
del PCs\mc-config.bat
echo set sjar=%sjar%>>PCs\mc-config.bat
goto createconfig

:logic-error
echo Logic datei konnte nicht gefunden werden
echo.
echo Error
goto logic-error
