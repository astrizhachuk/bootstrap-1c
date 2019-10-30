echo off
chcp 65001

set RUNNER_ROOT=%CD%

if "%1"=="" (
    echo "Неизвестный режим запуска"
    exit /b
) else (
    set MODE=%1
)

if "%MODE%"=="start" ( call :start )
exit /b

:start
call ./tools/init.cmd src %*
exit /b