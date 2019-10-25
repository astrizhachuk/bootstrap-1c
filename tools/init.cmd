echo off
chcp 65001

setlocal
set RUNNER_STAGE="--dev"
set RUNNER_FEATURE=%~dp0
set RUNNER_FEATURE=%RUNNER_FEATURE:~0,-7%
for /D %%a in ("%RUNNER_FEATURE:~0%.txt") do set RUNNER_FEATURE=%%~na

if "%1"=="" (
    echo "Укажите режим запуска: src или storage"
    exit /b
) else (
    set MODE=%1
)

if "%MODE%"=="src" ( call :src )
if "%MODE%"=="storage" (
    if "%2"=="" (
        set RUNNER_STORAGE-VER=
    ) else (
        set RUNNER_STORAGE-VER=%2
    )
    call :storage
)

call runner createrepo --settings .\tools\runner.json
git checkout -b "feature/%RUNNER_FEATURE%"

exit /b

:src
call runner init-dev --settings .\tools\runner.json --src .\src %RUNNER_STAGE%
exit /b

:storage
call runner init-dev --settings .\tools\runner.json --storage %RUNNER_STAGE%
exit /b