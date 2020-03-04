goto %1

:load
REM Suche der computername.bat und dann einlessen
if exist PCs\%computername%\mc-config.bat goto Update
if not exist PCs\%computername%.bat goto mc-config-pc-ordner

call PCs\%computername%.bat
if %Java%==64 goto Java-ckeck
goto End

:Java-erstellen
if /i %processor_architecture%==64 goto Java-erstellen-64Bit
if /i %processor_architecture%==AMD64 goto Java-erstellen-64Bit
del PCs\%computername%.bat
echo set jar=%jar%>>PCs\%computername%.bat
echo set Java=32>>PCs\%computername%.bat
echo set ram=%ram%>>PCs\%computername%.bat
goto load

:Java-erstellen-64Bit
del PCs\%computername%.bat
echo set jar=%jar%>>PCs\%computername%.bat
echo set Java=64>>PCs\%computername%.bat
echo set ram=%ram%>>PCs\%computername%.bat
goto load

REM Überbrüft RAM
:ram-check
FOR /F "tokens=2 delims='='" %%A in ('wmic memorychip Get capacity /value') Do (Set "pram=%%A")
FOR /F "tokens=1 delims='|'" %%A in ("%pram%") Do (Set "pram=%%A")
set /a kb=%pram:~0,-3%
set /a mb = kb / 1024
set /a gb = mb / 1024
set /a gb = %gb% + %gb%

if %ram% GTR %gb%G goto ram-error
goto End

:ram-error
if %mb%==0 goto ram-vm-error
set ram=1G
del PCs\%computername%.bat
echo set jar=%jar%>>PCs\%computername%.bat
echo set Java=%Java%>>PCs\%computername%.bat
echo set ram=%ram%>>PCs\%computername%.bat
goto End

:mc-config-pc-ordner
echo set jar=Minecraft>>PCs\%computername%.bat
if /i %processor_architecture%==64 goto mc-config-pc-ordner-64Bit
if /i %processor_architecture%==AMD64 goto mc-config-pc-ordner-64Bit
echo set Java=32>>PCs\%computername%.bat
echo set ram=1G>>PCs\%computername%.bat
goto load

:mc-config-pc-ordner-64Bit
echo set Java=64>>PCs\%computername%.bat
echo set ram=1G>>PCs\%computername%.bat
goto load

:ram-vm-error
CLS
del PCs\%computername%.bat
echo Du hast versucht Minecraft Portable in einer Virtuellen Maschine zu starten
echo das ist nicht erwuenscht (RAM Einlessungs Fehler) nur geignet fuer echte PCs
echo.
pause
exit

REM Überbrüft Java
:Java-ckeck
if /i %processor_architecture%==x86 goto Java-64Bit-error
goto End
:Java-64Bit-error
del PCs\%computername%.bat
echo set jar=%jar%>>PCs\%computername%.bat
echo set Java=32>>PCs\%computername%.bat
echo set ram=%ram%>>PCs\%computername%.bat
goto End

:Update
call PCs\%computername%\mc-config.bat
echo set jar=%jar%>>PCs\%computername%.bat
for /F "skip=1" %%A IN (PCs\%computername%\Java.mc) DO SET Java=%%A
echo set Java=%Java%>>PCs\%computername%.bat
for /F "skip=1" %%A IN (PCs\%computername%\ram.mc) DO SET ram=%%A
echo set ram=%ram%>>PCs\%computername%.bat
rmdir /s /q PCs\%computername%
goto load

:End
