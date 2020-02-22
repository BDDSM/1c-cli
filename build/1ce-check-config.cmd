@if "%system_debug%"=="true" echo on
@if NOT "%system_debug%"=="true" echo off

SETLOCAL
chcp 65001 >nul
set ROOT_DIR=%~dp0\..\

IF NOT DEFINED _1CE_TargetDBConnection (
  set _1CE_TargetDBConnection="File='.db'"
)

pushd %ROOT_DIR%

set _1CE_Log=%CD%\checkconfig.log

call .\3dparty\1cv8-log DESIGNER /WA- /DisableStartupDialogs /IBConnectionString %_1CE_TargetDBConnection% /CheckConfig -IncorrectReferences -ThinClient -WebClient -Server -ExtendedModulesCheck -CheckUseSyncronousCalls -CheckUseModality -AllExtensions
set _1CE_ERRORLEVEL=%ERRORLEVEL%

popd

call .\build\tools\cat-error-log "%_1CE_Log%" ".\build\config\exclude-check-config" Default

exit /b %_1CE_ERRORLEVEL%
