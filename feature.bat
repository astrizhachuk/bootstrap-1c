echo off
chcp 65001

setlocal
set USER=%DEV1C-USER%
set PASSWORD=%DEV1C-PASSWORD%

set SRC=./src
for %%a in (".") do set FEATURE=%%~na
set RUNNER_ROOT=%CD%
set RUNNER_V8VERSION=8.3.10
set GITSYNC_V8VERSION=%RUNNER_V8VERSION%
set GITSYNC_STORAGE_PATH=./build/storage
set GITSYNC_WORKDIR=%SRC%

if "%1"=="" (
    echo "Unknown mode"
    exit /b
) else (
    call git config --local core.autocrlf true
    call git config --local core.quotepath false
    call git checkout -b "feature/%FEATURE%"
    set MODE=%1
)
if "%MODE%"=="start" (
    call :src
    call :createrepo
    )
if "%MODE%"=="from" (
    if "%2"=="" (
        set RUNNER_STORAGE-VER=
    ) else (
        set RUNNER_STORAGE-VER=%2
    )
    call :storage
    call :createrepo
)
if "%MODE%"=="export" (
    set GITSYNC_STORAGE_USER=Администратор
    set GITSYNC_STORAGE_PASSWORD=Администратор
    call :export
)
if "%MODE%"=="push" (
    call git push --set-upstream origin "feature/%FEATURE%"
)

echo "feature done"
exit /b

:src
call runner init-dev --settings .\tools\runner.json --src %SRC%
call :initDB
exit /b

:storage
call runner init-dev --settings .\tools\runner.json --storage
call :initDB
exit /b

:createrepo
call runner createrepo --db-user "Администратор" --settings .\tools\runner.json
call gitsync set-version 0 %SRC%
if not "%USER%"=="" (
    if "%PASSWORD%"=="" (
        call runner createrepouser --storage-user %USER% --settings .\tools\runner.json
    ) else (
        call runner createrepouser --storage-user %USER% --storage-pwd %PASSWORD% --settings .\tools\runner.json
    )
)
exit /b

:initDB
call oscript .\tools\onescript\Compile.os .\tools\epf\
call runner run --settings .\tools\runner.json --execute .\tools\epf\InitDB.epf --command "file=.\tools\users.json"
exit /b

:export
call tools\DecompileFeatures
call gitsync s -R
exit /b