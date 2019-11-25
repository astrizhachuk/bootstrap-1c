echo off
chcp 65001

setlocal
set SRC=./src
for %%a in (".") do set FEATURE=%%~na
set RUNNER_STAGE="--dev"
set RUNNER_ROOT=%CD%
set RUNNER_V8VERSION=8.3.10
set GITSYNC_V8VERSION=%RUNNER_V8VERSION%
set GITSYNC_STORAGE_PATH=./build/storage
set GITSYNC_WORKDIR=%SRC%

if "%1"=="" (
    echo "Unknown mode"
    exit /b
) else (
    call git config --local core.quotepath false
    call git checkout -b "feature/%FEATURE%"
    set MODE=%1
)

if "%MODE%"=="src" (
    call :src
    call :createrepo
    )
if "%MODE%"=="storage" (
    if "%2"=="" (
        set RUNNER_STORAGE-VER=
    ) else (
        set RUNNER_STORAGE-VER=%2
    )
    call :storage
    call :createrepo
)
if "%MODE%"=="export" (
   if "%2"=="" (
        set GITSYNC_STORAGE_USER=Администратор
        set GITSYNC_STORAGE_PASSWORD=
    ) else (
        set GITSYNC_STORAGE_USER=%2
        set GITSYNC_STORAGE_PASSWORD=%3
    )
    call :export
)

echo "Done: %MODE%""
exit /b

:src
call runner init-dev --settings .\tools\runner.json --src %SRC% %RUNNER_STAGE%
exit /b

:storage
call runner init-dev --settings .\tools\runner.json --storage %RUNNER_STAGE%
exit /b

:createrepo
call runner createrepo --settings .\tools\runner.json
call gitsync set-version 0 %SRC%
exit /b

:export
call gitsync s -R
exit /b