SET BBROOT=%~dp0..\
SET MSVSVER=%1
SET ARCH=%2

FOR /F "tokens=*" %%a IN ('git rev-parse HEAD') DO SET BBREV=%%a
echo Build bot at revision %BBREV%.

ECHO Identifying architecture
IF "%PROGRAMFILES(X86)%"=="" (SET MACHINE_ARCH=x86) ELSE (SET MACHINE_ARCH=x64)
SET PROGFILE=%PROGRAMFILES(X86)%
IF "%MACHINE_ARCH%"=="x86" SET PROGFILE=%PROGRAMFILES%

SET MSVSARCH=x86
IF "%ARCH%"=="x64" SET MSVSARCH=x86_amd64

ECHO MACHINE_ARCH: %MACHINE_ARCH%
ECHO ARCH: %ARCH%
ECHO PROGFILE: %PROGFILE%

IF "%MSVSVER%"=="vc9" GOTO vc9
IF "%MSVSVER%"=="vc10" GOTO vc10
IF "%MSVSVER%"=="vc11" GOTO vc11
IF "%MSVSVER%"=="vc14" GOTO vc14
GOTO vcBad

:vc9
  ECHO Using Visual Studio 2008
  rem SETLOCAL EnableDelayedExpansion
  SET MSVSYEAR=2008
  CALL "C:\Program Files\Microsoft SDKs\Windows\v7.0\Bin\SetEnv.cmd" /xp /%ARCH% /release
  @ECHO ON
  REM Fix bug in 2008 SetEnv
  SET PATH=C:\Windows\system32;%PATH%
  GOTO End

:vc10
  ECHO Using Visual Studio 2010
  SET MSVSYEAR=2010
  CALL "C:\Program Files\Microsoft SDKs\Windows\v7.1\Bin\SetEnv.cmd" /win7 /%ARCH% /release
  @ECHO ON
  GOTO End

:vc11
  ECHO Using Visual Studio 2012
  SET MSVSYEAR=2012
  CALL "%PROGFILE%\Microsoft Visual Studio 11.0\VC\vcvarsall.bat" %MSVSARCH%
  @ECHO ON
  GOTO End

:vc14
  ECHO Using Visual Studio 2015
  SET MSVSYEAR=2015
  CALL "%PROGFILE%\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" %MSVSARCH%
  @ECHO ON
  GOTO End

:vcBad
ECHO Invalid msvsver specified...
GOTO End

:End
COLOR 07
TITLE CB SDK Build Bot Env - %MSVSVER% - %ARCH%
echo %PATH%
echo exiting
EXIT /B 0
