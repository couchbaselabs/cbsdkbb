SETLOCAL

SET BBROOT=%~dp0
SET PHPVER=%1
SET PHPTS=%2
SET MSVSVER=%3
SET ARCH=%4
SET ZLIB_VER=%5
SET DEP=%6

echo Building PHP %1 %2 %3 %4 %5 %6

SET PHPTAG=%PHPVER%-%PHPTS%-%MSVSVER%-%ARCH%-%DEP%

CALL common\env.bat %MSVSVER% %ARCH%

IF NOT EXIST php-files\src\%PHPTAG%\zlib-%ZLIB_VER%\zlib.h (
  tools\7za x -y -ophp-files\src\%PHPTAG% src\zlib-%ZLIB_VER%.zip
  cd php-files\src\%PHPTAG%\zlib-%ZLIB_VER%
  nmake -f win32\Makefile.msc
  cd ..\..\..\..
)

CALL php-files\sdk\bin\phpsdk_setvars.bat
@ECHO ON

CD php-files\src\%PHPTAG%

CALL buildconf.bat --force

SET PREFIX=%BBROOT%php-files\build\%PHPTAG%\
IF "%PHPTS%"=="nts" SET ZTSARG="--disable-zts" || SET ZTSARG=""
IF "%DEP%"=="igbinary" SET IGARG="--enable-igbinary=shared" || SET IGARG=""
CALL configure.bat --enable-one-shot --disable-all --enable-session --enable-json --enable-cli %IGARG% --enable-phar=shared --with-prefix=%PREFIX% %ZTSARG%

nmake && nmake install

ENDLOCAL
