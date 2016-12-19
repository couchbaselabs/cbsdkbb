SETLOCAL

SET BBROOT=%~dp0
SET PHPVER=%1
SET PHPTS=%2
SET MSVSVER=%3
SET ARCH=%4
SET PCSVER=%5

echo Building PHP %1 %2 %3 %4

SET PHPTAG=%PHPVER%-%PHPTS%-%MSVSVER%-%ARCH%

CALL common\env.bat %MSVSVER% %ARCH%

CALL php-files\sdk\bin\phpsdk_setvars.bat
@ECHO ON

CD php-files\src\%PHPTAG%

CALL buildconf.bat --force

SET PREFIX=%BBROOT%php-files\build\%PHPTAG%\
IF "%PHPTS%"=="nts" SET ZTSARG="--disable-zts" || SET ZTSARG=""
CALL configure.bat --enable-one-shot --disable-all --enable-tokenizer --enable-pcs --enable-phar=shared --enable-json --enable-cli --with-prefix=%PREFIX% %ZTSARG%

nmake && nmake install

ENDLOCAL
