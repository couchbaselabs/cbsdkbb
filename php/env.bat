SET PHPVER=%1
SET PHPTS=%2
SET DEP=%3
SET PHPTAG=%PHPVER%-%PHPTS%-%MSVSVER%-%ARCH%-%DEP%
SET PHPDIR=%~dp0..\php-files\build\%PHPTAG%\
SET PHPSDKDIR=%~dp0..\php-files\sdk\
SET PHPSRCDIR=%~dp0..\php-files\src\%PHPTAG%\
