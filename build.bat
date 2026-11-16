@echo off
REM simple build script - makes target\blood-donor-system.war

REM always use the JDK installed on this pc (works even if PATH is not set)
set "JAVA_HOME=C:\Program Files\Java\jdk-26.0.1"
set "PATH=%JAVA_HOME%\bin;%PATH%"

if not exist "%JAVA_HOME%\bin\javac.exe" (
    echo Java JDK not found in %JAVA_HOME%
    echo Please install Java 17 or above and fix the path in build.bat
    pause
    exit /b
)

echo Building project...

if exist target\war rmdir /s /q target\war
mkdir target\war\WEB-INF\classes
mkdir target\war\WEB-INF\lib

echo Compiling java files...
javac -d target\war\WEB-INF\classes -cp "lib\tomcat-embed-core-11.0.24.jar" src\main\java\com\bdms\*.java

if %ERRORLEVEL% NEQ 0 (
    echo Compilation failed
    pause
    exit /b
)

copy /Y lib\mysql-connector-j-9.7.0.jar target\war\WEB-INF\lib\ >nul
xcopy /E /I /Y src\main\webapp target\war >nul

cd target\war
jar -cf ..\blood-donor-system.war *
cd ..\..

echo Done. WAR file is in target\blood-donor-system.war
pause
