SETLOCAL

SET PHPMINVER=%1
SET PHPVER=%2
SET MSVSVER=%3
SET ARCH=%4
SET PCSVER=1.3.1
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
  tools\wget --no-check-certificate -nc "https://phar.phpunit.de/phpunit.phar" -O src\php-phpunit.phar
  tools\wget --no-check-certificate -nc "https://phar.phpunit.de/phpunit-old.phar" -O src\php-phpunit-old.phar
  tools\wget --no-check-certificate -nc "http://phpdoc.org/phpDocumentor.phar" -O src\php-phpdoc.phar
  tools\wget --no-check-certificate -nc "https://pecl.php.net/get/pcs-%PCSVER%.tgz" -O src\pcs-%PCSVER%.tgz

  echo Installing PHP %1 %2 %3 %4

  echo Installing SDK
  IF NOT EXIST php-files\sdk (
    tools\7za x -y -ophp-files\sdk\ src\php-sdk.zip
  )

  echo Installing NTS
  IF NOT EXIST php-files\src\%PHPVER%-nts-%MSVSVER%-%ARCH% (
    IF NOT EXIST tmp\php-src-%PHPVER%.tar (
      tools\7za x -y -otmp\ src\php-src-%PHPVER%.tar.bz2
    )
    tools\7za x -y -otmp\ tmp\php-src-%PHPVER%.tar
    move /Y tmp\php-%PHPVER% php-files\src\%PHPVER%-nts-%MSVSVER%-%ARCH%
  )
  echo Extracting PCS extension sources
  IF NOT EXIST php-files\src\%PHPVER%-nts-%MSVSVER%-%ARCH%\ext\pcs (
    IF NOT EXIST tmp\pcs-%PCSVER%.tar (
      tools\7za x -y -otmp\ src\pcs-%PCSVER%.tgz
    )
    tools\7za x -y -ophp-files\src\%PHPVER%-nts-%MSVSVER%-%ARCH%\ext\ tmp\pcs-%PCSVER%.tar
    move /Y php-files\src\%PHPVER%-nts-%MSVSVER%-%ARCH%\ext\pcs-%PCSVER% php-files\src\%PHPVER%-nts-%MSVSVER%-%ARCH%\ext\pcs
    %PATCH% -i %BBROOT%\php\patches\pcs-win-install-headers.patch -d %BBROOT%\php-files\src\%PHPVER%-nts-%MSVSVER%-%ARCH%\ext\pcs
  )
  echo Building NTS
  IF NOT EXIST php-files\build\%PHPVER%-nts-%MSVSVER%-%ARCH% (
    CALL wsetup_php_build.bat %PHPVER% nts %MSVSVER% %ARCH% %PCSVER%
  )
  echo Adding NTS Helpers
  IF NOT EXIST php-files\build\%PHPVER%-nts-%MSVSVER%-%ARCH%\phpunit.phar (
    IF "%PHPVER:~0,3%"=="5.4" (
      copy src\php-phpunit-old.phar php-files\build\%PHPVER%-nts-%MSVSVER%-%ARCH%\phpunit.phar
    ) ELSE (
      IF "%PHPVER:~0,3%"=="5.5" (
        copy src\php-phpunit-old.phar php-files\build\%PHPVER%-nts-%MSVSVER%-%ARCH%\phpunit.phar
      ) ELSE (
        copy src\php-phpunit.phar php-files\build\%PHPVER%-nts-%MSVSVER%-%ARCH%\phpunit.phar
      )
    )
  )
  IF NOT EXIST php-files\build\%PHPVER%-nts-%MSVSVER%-%ARCH%\phpdoc.phar (
    copy src\php-phpdoc.phar php-files\build\%PHPVER%-nts-%MSVSVER%-%ARCH%\phpdoc.phar
  )

  echo Installing ZTS
  IF NOT EXIST php-files\src\%PHPVER%-zts-%MSVSVER%-%ARCH% (
    IF NOT EXIST tmp\php-src-%PHPVER%.tar (
      tools\7za x -y -otmp\ src\php-src-%PHPVER%.tar.bz2
    )
    tools\7za x -y -otmp\ tmp\php-src-%PHPVER%.tar
    move /Y tmp\php-%PHPVER% php-files\src\%PHPVER%-zts-%MSVSVER%-%ARCH%
  )
  echo Extracting PCS extension sources
  IF NOT EXIST php-files\src\%PHPVER%-zts-%MSVSVER%-%ARCH%\ext\pcs (
    IF NOT EXIST tmp\pcs-%PCSVER%.tar (
      tools\7za x -y -otmp\ src\pcs-%PCSVER%.tgz
    )
    tools\7za x -y -ophp-files\src\%PHPVER%-zts-%MSVSVER%-%ARCH%\ext\ tmp\pcs-%PCSVER%.tar
    move /Y php-files\src\%PHPVER%-zts-%MSVSVER%-%ARCH%\ext\pcs-%PCSVER% php-files\src\%PHPVER%-zts-%MSVSVER%-%ARCH%\ext\pcs
    %PATCH% -i %BBROOT%\php\patches\pcs-win-install-headers.patch -d %BBROOT%\php-files\src\%PHPVER%-zts-%MSVSVER%-%ARCH%\ext\pcs
  )
  echo Building ZTS
  IF NOT EXIST php-files\build\%PHPVER%-zts-%MSVSVER%-%ARCH% (
    CALL wsetup_php_build.bat %PHPVER% zts %MSVSVER% %ARCH% %PCSVER%
  )
  echo Adding ZTS Helpers
  IF NOT EXIST php-files\build\%PHPVER%-zts-%MSVSVER%-%ARCH%\phpunit.phar (
    IF "%PHPVER:~0,3%"=="5.4" (
      copy src\php-phpunit-old.phar php-files\build\%PHPVER%-zts-%MSVSVER%-%ARCH%\phpunit.phar
    ) ELSE (
      IF "%PHPVER:~0,3%"=="5.5" (
        copy src\php-phpunit-old.phar php-files\build\%PHPVER%-zts-%MSVSVER%-%ARCH%\phpunit.phar
      ) ELSE (
        copy src\php-phpunit.phar php-files\build\%PHPVER%-zts-%MSVSVER%-%ARCH%\phpunit.phar
      )
    )
  )
  IF NOT EXIST php-files\build\%PHPVER%-zts-%MSVSVER%-%ARCH%\phpdoc.phar (
    copy src\php-phpdoc.phar php-files\build\%PHPVER%-zts-%MSVSVER%-%ARCH%\phpdoc.phar
  )

)

ENDLOCAL
