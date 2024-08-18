@echo off
setlocal enabledelayedexpansion

REM Made by Sarah (@s.ar2005 in Discord)
REM Thanks to:
REM - Einst
REM - Grub4K
REM - Sintrode
REM - https://stackoverflow.com/questions/31130282/how-to-handle-with-enabledelayedexpansion-in-batch

set "fileToClone=%1"
set "tempDir=%temp%\sarah-dbug"
set "clonedFile=%tempDir%\og.bat"
set "logFile=%~dp0dbug.log"

if "%fileToClone%"=="" (
    echo Welcome to Sarah's dbug tool!
    echo A tool to debug batch files.
    echo Inspired by: bat-dbug ^<bat-dbug is sometimes buggy^>
    echo Usage: dbug.bat filename.bat ^<args 1-8^>
    exit /b 1
)

if not exist "%fileToClone%" (
    echo dbug: File not found: %fileToClone%
    exit /b 1
)

if not exist "%tempDir%" (
    mkdir "%tempDir%"
)


echo dbug: Preparing to debug...
for /f "delims=" %%l in ('type "!fileToClone!" ^| !SystemRoot!\System32\find.exe /c /v ""') do set /a "lines=%%l"
<"!fileToClone!" >"!clonedFile!" (
    for /l %%l in (1 1 !lines!) do (
        set "line="
        set /p "line="
        echo(!line!
        echo(echo dbug: ERRORLEVEL: "^!ERRORLEVEL^!" happened on Line %%l
    )
)

if exist "%clonedFile%" (
    echo dbug: Running...
    call "%clonedFile%" %2 %3 %4 %5 %6 %7 %8 %9 > "%logFile%"
    echo dbug: Debugging session ended with code !ERRORLEVEL!
    echo dbug: Log has been saved to %logFile%
) else (
    echo dbug: Failed to debug.
)

endlocal
