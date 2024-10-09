@echo off
setlocal enabledelayedexpansion

rem Get the current directory of the USB
set usbDrive=%~d0

rem Fetch the product key (Windows)
for /f "tokens=2 delims==" %%i in ('wmic path softwarelicensingservice get OA3xOriginalProductKey /value') do set "productKey=%%i"

rem Fetch the Windows version (Edition)
for /f "tokens=2 delims==" %%i in ('wmic os get Caption /value') do set "windowsVersion=%%i"

rem Fetch the Windows version number
for /f "tokens=3 delims=[]. " %%i in ('ver') do set "windowsVersionNumber=%%i"

rem Combine the version and edition
set "fullVersion=%windowsVersion% %windowsVersionNumber%"

rem Get the timestamp
for /f "tokens=1-5 delims=/:. " %%a in ("%date% %time%") do set timestamp=%%a-%%b-%%c_%%d%%e

rem Get the computer name and username
set "computerName=%COMPUTERNAME%"
set "userName=%USERNAME%"

rem Fetch the IPv4 address
for /f "tokens=2 delims=:" %%i in ('ipconfig ^| findstr /R /C:"IPv4 Address"') do set "ipv4Address=%%i"
set "ipv4Address=%ipv4Address:~1%"

rem Append the information to a text file on the USB
(
    echo Timestamp: %timestamp%
    echo Product Key: %productKey%
    echo Windows Version: %fullVersion%
    echo Computer Name: %computerName%
    echo User Name: %userName%
    echo IPv4 Address: %ipv4Address%
    echo -------------------------------------
) >> %usbDrive%\ProductKey.txt
