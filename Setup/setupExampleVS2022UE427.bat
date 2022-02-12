@echo off
@REM Example of creating a plugin for gRPC with VS2022 for UE4.27. UE_ROOT and CMAKE_GENERATOR are change  according to the environment.

pushd %~dp0
setlocal
set UE_ROOT=C:\Program Files\Epic Games\UE_4.27
set CMAKE_GENERATOR=Visual Studio 17 2022

.\setup.bat

endlocal
popd