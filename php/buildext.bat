SETLOCAL
@ECHO ON

SET BBSDK=%~dp0
SET EXTPATH=%1\
SET EXTNAME=%2
SET ZLIB_VER=1.2.11

IF EXIST %EXTPATH%\* GOTO Start
ECHO Extension path must be a directory
GOTO End

:Start
CALL "%PHPSDKDIR%\bin\phpsdk_setvars.bat"
@ECHO ON

SET INCLUDE=%PHPSRCDIR%zlib-%ZLIB_VER%;%INCLUDE%
SET LIB=%PHPSRCDIR%zlib-%ZLIB_VER%;%LIB%

del %EXTPATH%\build\php_%EXTNAME%.dll

echo CLEAN AND SETUP EXT BUILD FOLDER
rmdir /s /q %PHPSRCDIR%ext-dev\
rmdir /s /q %PHPSRCDIR%ext-dev-build\
rmdir /s /q %PHPSRCDIR%Release\ext-dev\
xcopy /c /q /i /y /s %EXTPATH%* %PHPSRCDIR%ext-dev\%EXTNAME%\

echo SWITCH TO SRC FOLDER
cd %PHPSRCDIR%

echo GENERATE BUILD CONFIG
CALL buildconf.bat --force --add-modules-dir=%PHPSRCDIR%ext-dev\
@ECHO ON

echo CONFIGURE FOR BUILD
IF %PHPTS%==nts SET ZTSARG="--disable-zts" || SET ZTSARG=""
IF %DEP%==igbinary SET IGARG="--enable-igbinary=shared" || SET IGARG=""
CALL configure.bat --disable-all --enable-json --enable-session --enable-one-shot --enable-cli --enable-phar=shared %IGARG% --with-prefix=%PHPSRCDIR%\ext-dev-build\ --with-%EXTNAME%=shared %ZTSARG%
@ECHO ON


echo BUILD AND INSTALL
nmake clean && nmake && nmake install
@ECHO ON

echo COPY BUILT DLL TO EXTENSION FOLDER
IF "%PHPVER:~0,1%"=="5" (
  IF EXIST %PHPSRCDIR%\ext-dev-build\php_%EXTNAME%.dll (
    xcopy /c /q /i /y %PHPSRCDIR%\ext-dev-build\php_%EXTNAME%.dll %EXTPATH%\build\
  ) ELSE IF EXIST %PHPSRCDIR%\ext-dev-build\ext\php_%EXTNAME%.dll (
    xcopy /c /q /i /y %PHPSRCDIR%\ext-dev-build\ext\php_%EXTNAME%.dll %EXTPATH%\build\
  )
) ELSE (
  xcopy /c /q /i /y %PHPSRCDIR%\ext-dev-build\ext\php_%EXTNAME%.dll %EXTPATH%\build\
)

:End
ENDLOCAL
