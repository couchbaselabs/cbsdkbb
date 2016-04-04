SETLOCAL

SET LCBVER=%1
SET ARCH=%2


echo Downloading LCB %1 %2...

if "%ARCH%"=="x86" (
  tools\wget --no-check-certificate -nc "http://packages.couchbase.com/clients/c/libcouchbase-%LCBVER%_x86_vc9.zip" -O src\lcb-%LCBVER%-vc9-x86.zip
  tools\wget --no-check-certificate -nc "http://packages.couchbase.com/clients/c/libcouchbase-%LCBVER%_x86_vc10.zip" -O src\lcb-%LCBVER%-vc10-x86.zip
  tools\wget --no-check-certificate -nc "http://packages.couchbase.com/clients/c/libcouchbase-%LCBVER%_x86_vc11.zip" -O src\lcb-%LCBVER%-vc11-x86.zip
)
if "%ARCH%"=="x64" (
  tools\wget --no-check-certificate -nc "http://packages.couchbase.com/clients/c/libcouchbase-%LCBVER%_amd64_vc9.zip" -O src\lcb-%LCBVER%-vc9-x64.zip
  tools\wget --no-check-certificate -nc "http://packages.couchbase.com/clients/c/libcouchbase-%LCBVER%_amd64_vc10.zip" -O src\lcb-%LCBVER%-vc10-x64.zip
  tools\wget --no-check-certificate -nc "http://packages.couchbase.com/clients/c/libcouchbase-%LCBVER%_amd64_vc11.zip" -O src\lcb-%LCBVER%-vc11-x64.zip
)


echo Installing LCB %1 %2...

if "%ARCH%"=="x86" (
  if not exist lcb-files\%LCBVER%-vc9-x86 (
    tools\7za x -y -otmp\ src\lcb-%LCBVER%-vc9-x86.zip
    move /Y tmp\libcouchbase-%LCBVER%_x86_vc9 lcb-files\%LCBVER%-vc9-x86
  )
  if not exist lcb-files\%LCBVER%-vc10-x86 (
    tools\7za x -y -otmp\ src\lcb-%LCBVER%-vc10-x86.zip
    move /Y tmp\libcouchbase-%LCBVER%_x86_vc10 lcb-files\%LCBVER%-vc10-x86
  )
  if not exist lcb-files\%LCBVER%-vc11-x86 (
    tools\7za x -y -otmp\ src\lcb-%LCBVER%-vc11-x86.zip
    move /Y tmp\libcouchbase-%LCBVER%_x86_vc11 lcb-files\%LCBVER%-vc11-x86
  )
  if not exist lcb-files\%LCBVER%-vc14-x86 (
    tools\7za x -y -otmp\ src\lcb-%LCBVER%-vc11-x86.zip
    move /Y tmp\libcouchbase-%LCBVER%_x86_vc11 lcb-files\%LCBVER%-vc14-x86
  )
)
if "%ARCH%"=="x64" (
  if not exist lcb-files\%LCBVER%-vc9-x64 (
    tools\7za x -y -otmp\ src\lcb-%LCBVER%-vc9-x64.zip
    move /Y tmp\libcouchbase-%LCBVER%_amd64_vc9 lcb-files\%LCBVER%-vc9-x64
  )
  if not exist lcb-files\%LCBVER%-vc10-x64 (
    tools\7za x -y -otmp\ src\lcb-%LCBVER%-vc10-x64.zip
    move /Y tmp\libcouchbase-%LCBVER%_amd64_vc10 lcb-files\%LCBVER%-vc10-x64
  )
  if not exist lcb-files\%LCBVER%-vc11-x64 (
    tools\7za x -y -otmp\ src\lcb-%LCBVER%-vc11-x64.zip
    move /Y tmp\libcouchbase-%LCBVER%_amd64_vc11 lcb-files\%LCBVER%-vc11-x64
  )
  if not exist lcb-files\%LCBVER%-vc14-x64 (
    tools\7za x -y -otmp\ src\lcb-%LCBVER%-vc11-x64.zip
    move /Y tmp\libcouchbase-%LCBVER%_amd64_vc11 lcb-files\%LCBVER%-vc14-x64
  )
)

ENDLOCAL
