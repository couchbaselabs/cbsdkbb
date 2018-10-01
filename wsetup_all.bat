SETLOCAL

SET ARCH=%1

echo Installing libcouchbase %ARCH%
IF "%LCBVER%"=="" (
    SET LCBVER=2.9.5
)

CALL wsetup_lcb.bat %LCBVER% %ARCH%

echo Installing Node.js %ARCH%
CALL wsetup_njs.bat njs 6.14.3 %ARCH%
CALL wsetup_njs.bat njs 7.10.1 %ARCH%
CALL wsetup_njs.bat njs 8.11.3 %ARCH%
CALL wsetup_njs.bat njs 9.11.2 %ARCH%
CALL wsetup_njs.bat njs 10.11.0 %ARCH%

echo Installing PHP %ARCH%
CALL wsetup_php.bat 5.6 5.6.38 vc11 %ARCH%
CALL wsetup_php.bat 7.0 7.0.32 vc14 %ARCH%
CALL wsetup_php.bat 7.1 7.1.22 vc14 %ARCH%

ENDLOCAL
