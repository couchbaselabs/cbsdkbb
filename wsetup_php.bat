SETLOCAL

SET PHPMINVER=%1
SET PHPVER=%2
SET MSVSVER=%3
SET ARCH=%4
SET IGBINARY_VER=2.0.1
SET ZLIB_VER_F=1211
SET ZLIB_VER=1.2.11
SET PATCH="c:\progra~1\git\usr\bin\patch.exe"


SET BUILDENABLED=1
if "%PHPMINVER%"=="5.4" (
  if "%ARCH%"=="x64" (
    SET BUILDENABLED=0
  )
)
if "%BUILDENABLED%"=="0" (
  echo Skipping PHP %1 %2 %3 %4
)

if "%BUILDENABLED%"=="1" (

  echo Downloading PHP %1 %2 %3 %4

  tools\wget --no-check-certificate -nc "http://php.net/get/php-%PHPVER%.tar.bz2/from/this/mirror" -O src\php-src-%PHPVER%.tar.bz2
  tools\wget --no-check-certificate -nc "http://windows.php.net/downloads/php-sdk/php-sdk-binary-tools-20110915.zip" -O src\php-sdk.zip
  tools\wget --no-check-certificate -nc "https://phar.phpunit.de/phpunit-5.7.phar" -O src\php-phpunit.phar

  tools\wget --no-check-certificate -nc "http://phpdoc.org/phpDocumentor.phar" -O src\php-phpdoc.phar
  tools\wget --no-check-certificate -nc "https://pecl.php.net/get/igbinary-%IGBINARY_VER%.tgz" -O src\igbinary-%IGBINARY_VER%.tgz
  tools\wget --no-check-certificate -nc "http://zlib.net/zlib%ZLIB_VER_F%.zip" -O src\zlib-%ZLIB_VER%.zip

  echo Installing PHP %1 %2 %3 %4

  echo Installing SDK
  IF NOT EXIST php-files\sdk (
    tools\7za x -y -ophp-files\sdk\ src\php-sdk.zip
  )

REM ---------------------------------------------------
  echo Installing NTS with IGBINARY
  SET PHPTAG=%PHPVER%-nts-%MSVSVER%-%ARCH%-igbinary
  IF NOT EXIST php-files\src\!PHPTAG! (
    IF NOT EXIST tmp\php-src-%PHPVER%.tar (
      tools\7za x -y -otmp\ src\php-src-%PHPVER%.tar.bz2
    )
    tools\7za x -y -otmp\ tmp\php-src-%PHPVER%.tar
    move /Y tmp\php-%PHPVER% php-files\src\!PHPTAG!
  )
  echo Extracting IGBINARY extension sources
  IF NOT EXIST php-files\src\!PHPTAG!\ext\igbinary (
    IF NOT EXIST tmp\igbinary-%IGBINARY_VER%.tar (
      tools\7za x -y -otmp\ src\igbinary-%IGBINARY_VER%.tgz
    )
    tools\7za x -y -ophp-files\src\!PHPTAG!\ext\ tmp\igbinary-%IGBINARY_VER%.tar
    move /Y php-files\src\!PHPTAG!\ext\igbinary-%IGBINARY_VER% php-files\src\!PHPTAG!\ext\igbinary
  )
  echo Building NTS with IGBINARY
  IF NOT EXIST php-files\build\!PHPTAG! (
    CALL wsetup_php_build.bat %PHPVER% nts %MSVSVER% %ARCH% %ZLIB_VER% igbinary
  )
  echo Adding NTS Helpers with IGBINARY
  IF NOT EXIST php-files\build\!PHPTAG!\phpunit.phar (
    copy src\php-phpunit.phar php-files\build\!PHPTAG!\phpunit.phar
  )
  IF NOT EXIST php-files\build\!PHPTAG!\phpdoc.phar (
    copy src\php-phpdoc.phar php-files\build\!PHPTAG!\phpdoc.phar
  )

REM ---------------------------------------------------
  echo Installing NTS without IGBINARY
  SET PHPTAG=%PHPVER%-nts-%MSVSVER%-%ARCH%-default
  IF NOT EXIST php-files\src\!PHPTAG! (
    IF NOT EXIST tmp\php-src-%PHPVER%.tar (
      tools\7za x -y -otmp\ src\php-src-%PHPVER%.tar.bz2
    )
    tools\7za x -y -otmp\ tmp\php-src-%PHPVER%.tar
    move /Y tmp\php-%PHPVER% php-files\src\!PHPTAG!
  )
  echo Building NTS without IGBINARY
  IF NOT EXIST php-files\build\!PHPTAG! (
    CALL wsetup_php_build.bat %PHPVER% nts %MSVSVER% %ARCH% %ZLIB_VER% default
  )
  echo Adding NTS Helpers without IGBINARY
  IF NOT EXIST php-files\build\!PHPTAG!\phpunit.phar (
    copy src\php-phpunit.phar php-files\build\!PHPTAG!\phpunit.phar
  )
  IF NOT EXIST php-files\build\!PHPTAG!\phpdoc.phar (
    copy src\php-phpdoc.phar php-files\build\!PHPTAG!\phpdoc.phar
  )

REM ---------------------------------------------------
  echo Installing ZTS with IGBINARY
  SET PHPTAG=%PHPVER%-zts-%MSVSVER%-%ARCH%-igbinary
  IF NOT EXIST php-files\src\!PHPTAG! (
    IF NOT EXIST tmp\php-src-%PHPVER%.tar (
      tools\7za x -y -otmp\ src\php-src-%PHPVER%.tar.bz2
    )
    tools\7za x -y -otmp\ tmp\php-src-%PHPVER%.tar
    move /Y tmp\php-%PHPVER% php-files\src\!PHPTAG!
  )
  echo Extracting IGBINARY extension sources
  IF NOT EXIST php-files\src\!PHPTAG!\ext\igbinary (
    IF NOT EXIST tmp\igbinary-%IGBINARY_VER%.tar (
      tools\7za x -y -otmp\ src\igbinary-%IGBINARY_VER%.tgz
    )
    tools\7za x -y -ophp-files\src\!PHPTAG!\ext\ tmp\igbinary-%IGBINARY_VER%.tar
    move /Y php-files\src\!PHPTAG!\ext\igbinary-%IGBINARY_VER% php-files\src\!PHPTAG!\ext\igbinary
  )
  echo Building ZTS with IGBINARY
  IF NOT EXIST php-files\build\!PHPTAG! (
    CALL wsetup_php_build.bat %PHPVER% zts %MSVSVER% %ARCH% %ZLIB_VER% igbinary
  )
  echo Adding ZTS Helpers with IGBINARY
  IF NOT EXIST php-files\build\!PHPTAG!\phpunit.phar (
    copy src\php-phpunit.phar php-files\build\!PHPTAG!\phpunit.phar
  )
  IF NOT EXIST php-files\build\!PHPTAG!\phpdoc.phar (
    copy src\php-phpdoc.phar php-files\build\!PHPTAG!\phpdoc.phar
  )

REM ---------------------------------------------------
  echo Installing ZTS without IGBINARY
  SET PHPTAG=%PHPVER%-zts-%MSVSVER%-%ARCH%-default
  IF NOT EXIST php-files\src\!PHPTAG! (
    IF NOT EXIST tmp\php-src-%PHPVER%.tar (
      tools\7za x -y -otmp\ src\php-src-%PHPVER%.tar.bz2
    )
    tools\7za x -y -otmp\ tmp\php-src-%PHPVER%.tar
    move /Y tmp\php-%PHPVER% php-files\src\!PHPTAG!
  )
  echo Building ZTS without IGBINARY
  IF NOT EXIST php-files\build\!PHPTAG! (
    CALL wsetup_php_build.bat %PHPVER% zts %MSVSVER% %ARCH% %ZLIB_VER% default
  )
  echo Adding ZTS Helpers without IGBINARY
  IF NOT EXIST php-files\build\!PHPTAG!\phpunit.phar (
    copy src\php-phpunit.phar php-files\build\!PHPTAG!\phpunit.phar
  )
  IF NOT EXIST php-files\build\!PHPTAG!\phpdoc.phar (
    copy src\php-phpdoc.phar php-files\build\!PHPTAG!\phpdoc.phar
  )
)

ENDLOCAL
