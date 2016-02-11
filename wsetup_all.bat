SETLOCAL

SET ARCH=%1

echo Installing libcouchbase %ARCH%
CALL wsetup_lcb.bat 2.4.9 %ARCH%
CALL wsetup_lcb.bat 2.5.3 %ARCH%

echo Installing Node.js %ARCH%
CALL wsetup_njs.bat njs 0.10.40 %ARCH%
CALL wsetup_njs.bat njs 0.12.7 %ARCH%
CALL wsetup_njs.bat iojs 1.0.4 %ARCH%
CALL wsetup_njs.bat iojs 1.8.4 %ARCH%
CALL wsetup_njs.bat iojs 2.4.0 %ARCH%
CALL wsetup_njs.bat iojs 3.0.0 %ARCH%
CALL wsetup_njs.bat njs 4.0.0 %ARCH%

echo Installing PHP %ARCH%
CALL wsetup_php.bat 5.4 5.4.45 vc9 %ARCH%
CALL wsetup_php.bat 5.5 5.5.31 vc11 %ARCH%
CALL wsetup_php.bat 5.6 5.6.17 vc11 %ARCH%

ENDLOCAL
