```bat
@echo off
title Blood Donor Management System

echo ========================================
echo   BLOOD DONOR MANAGEMENT SYSTEM
echo ========================================
echo.

echo Checking MySQL service...
sc query MySQL80 | findstr /I "RUNNING" >nul

if errorlevel 1 (
    echo Starting MySQL...
    net start MySQL80
)

echo.
echo Starting Apache Tomcat...

cd /d "C:\apache-tomcat-11.0.24\bin"
call startup.bat

echo.
echo Waiting for Tomcat to start...
timeout /t 8 /nobreak >nul

echo Opening Blood Donor Management System...
start "" "http://localhost:8080/blood-donor-system/"

echo.
echo Application launch command completed.
pause
```