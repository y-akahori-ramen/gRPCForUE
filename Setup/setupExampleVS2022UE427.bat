@echo off
@REM UE4.27向けにVS2022でgRPC用プラグインを作成する例。UE_ROOT,CMAKE_GENERATORは環境に合わせて書き換える。

pushd %~dp0
setlocal
set UE_ROOT=C:\Program Files\Epic Games\UE_4.27
set CMAKE_GENERATOR=Visual Studio 17 2022

.\setup.bat

endlocal
popd