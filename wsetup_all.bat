SETLOCAL

SET ARCH=%1

echo Installing libcouchbase %ARCH%
IF "%LCBVER%"=="" (
    SET LCBVER=2.7.4
)

CALL wsetup_lcb.bat %LCBVER% %ARCH%

echo Installing Node.js %ARCH%
CALL wsetup_njs.bat njs 0.10.48 %ARCH%
CALL wsetup_njs.bat njs 0.12.17 %ARCH%
CALL wsetup_njs.bat njs 4.6.1 %ARCH%
CALL wsetup_njs.bat njs 5.12.0 %ARCH%
CALL wsetup_njs.bat njs 6.9.4 %ARCH%
CALL wsetup_njs.bat njs 7.4.0 %ARCH%

echo Installing PHP %ARCH%
CALL wsetup_php.bat 5.4 5.4.45 vc9 %ARCH%
CALL wsetup_php.bat 5.5 5.5.38 vc11 %ARCH%
CALL wsetup_php.bat 5.6 5.6.30 vc11 %ARCH%
CALL wsetup_php.bat 7.0 7.0.18 vc14 %ARCH%
CALL wsetup_php.bat 7.1 7.1.4  vc14 %ARCH%

ENDLOCAL
