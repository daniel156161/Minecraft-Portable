@echo off
color a
REM Ladet Config oder erstellt Config (aktuelle Versions Variable)

set aktuelleversion=6.0

:start
if not exist PCs\mc-config.bat goto Config-erstellen
call PCs\mc-config.bat
title %starter%

if not exist Java\mc-logic.bat goto logic-error
REM Version Pr�fen
if not %Version%==%aktuelleversion% goto Config-loeschen

REM �berbr�fen
call Java\mc-logic.bat load
call Java\mc-logic.bat ram-check

REM Sucht den Pfad zum .minecraft-Verzeichnis
SET AppData=%CD%

REM �berpr�ft ob sich JavaPortable unter \Java installiert ist und nutzt dann dieses
if exist %CD%\Java\%Java%\bin\javaw.exe SET PATH=%CD%\Java\%Java%\bin

REM Startet Minecraft
start javaw.exe -Xms128M -Xmx%ram% -jar Launcher\%jar%.jar
exit

REM Configs
:Config-erstellen
mkdir PCs
echo set Version=%aktuelleversion%>>PCs\mc-config.bat
echo set starter=Minecraft-Portable>>PCs\mc-config.bat
call PCs\mc-config.bat
title %starter%
color a
goto start

:Config-loeschen
del PCs\mc-config.bat
echo set Version=%aktuelleversion%>>PCs\mc-config.bat
echo set starter=Minecraft-Portable>>PCs\mc-config.bat
call PCs\mc-config.bat
title %starter%
color a
goto start

:logic-error
echo Logic datei konnte nicht gefunden werden
echo.
echo Error
goto logic-error