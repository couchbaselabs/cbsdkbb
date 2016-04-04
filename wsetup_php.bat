SETLOCAL

SET PHPMINVER=%1
SET PHPVER=%2
SET MSVSVER=%3
SET ARCH=%4


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
  echo Building NTS
  IF NOT EXIST php-files\build\%PHPVER%-nts-%MSVSVER%-%ARCH% (
    CALL wsetup_php_build.bat %PHPVER% nts %MSVSVER% %ARCH%
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
  echo Building ZTS
  IF NOT EXIST php-files\build\%PHPVER%-zts-%MSVSVER%-%ARCH% (
    CALL wsetup_php_build.bat %PHPVER% zts %MSVSVER% %ARCH%
  )
  echo Adding ZTS Helpers
  IF NOT EXIST php-files\build\%PHPVER%-zts-%MSVSVER%-%ARCH%\phpunit.phar (
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
  IF NOT EXIST php-files\build\%PHPVER%-zts-%MSVSVER%-%ARCH%\phpdoc.phar (
    copy src\php-phpdoc.phar php-files\build\%PHPVER%-zts-%MSVSVER%-%ARCH%\phpdoc.phar
  )

)

ENDLOCAL
