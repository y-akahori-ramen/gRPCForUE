@echo off
pushd %~dp0


if "%UE_ROOT%" == "" (
    echo "Plese set UE_ROOT. e.g set UE_ROOT=C:\Program Files\Epic Games\UE_4.27"
    exit /b 1
)

if "%CMAKE_GENERATOR%" == "" (
    echo "Plese set CMAKE_GENERATOR. e.g set CMAKE_GENERATOR=Visual Studio 17 2022"
    exit /b 1
)

setlocal
set UE_THIRD_PARTY_DIR=%UE_ROOT%\Engine\Source\ThirdParty
set GRPC_ROOT=%~dp0\grpcsrc
set CMAKE_BUILD_DIR=%~dp0\grpcsrc\grpc\.build
set GRPC_BRANCH=v1.41.1
set UE_ROOT=C:\Program Files\Epic Games\UE_4.27
set THIRD_PARY_BUILD_DIR=%CMAKE_BUILD_DIR%\third_party
set GRPC_PLUGIN_SRC_DIR=%~dp0\..\Source\gRPCForUE4\gRPC
set GRPC_PLUGIN_INCLUDE_DIR=%GRPC_PLUGIN_SRC_DIR%\Includes
set GRPC_PLUGIN_LIBRARIES_DIR=%GRPC_PLUGIN_SRC_DIR%\Libraries

echo "--- clean"
rmdir %GRPC_ROOT% /s /q

echo "--- clone gRPC"
mkdir %GRPC_ROOT%
cd %GRPC_ROOT%
git clone -b %GRPC_BRANCH% https://github.com/grpc/grpc

cd grpc
git submodule update --init

echo "--- build gRPC"
md %CMAKE_BUILD_DIR%
cd %CMAKE_BUILD_DIR%
cmake .. -G "%CMAKE_GENERATOR%" ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DCMAKE_CONFIGURATION_TYPES=Release ^
    -Dprotobuf_BUILD_TESTS=OFF ^
    -DgRPC_ZLIB_PROVIDER=package ^
    -DZLIB_INCLUDE_DIR="%UE_THIRD_PARTY_DIR%\zlib\v1.2.8\include\Win64\VS2015" ^
    -DZLIB_LIBRARY_DEBUG="%UE_THIRD_PARTY_DIR%\zlib\v1.2.8\lib\Win64\VS2015\Debug\zlibstatic.lib" ^
    -DZLIB_LIBRARY_RELEASE="%UE_THIRD_PARTY_DIR%\zlib\v1.2.8\lib\Win64\VS2015\Release\zlibstatic.lib" ^
    -DgRPC_SSL_PROVIDER=package ^
    -DLIB_EAY_LIBRARY_DEBUG="%UE_THIRD_PARTY_DIR%\OpenSSL\1.1.1k\Lib\Win64\VS2015\Debug\libcrypto.lib" ^
    -DLIB_EAY_LIBRARY_RELEASE="%UE_THIRD_PARTY_DIR%\OpenSSL\1.1.1k\Lib\Win64\VS2015\Release\libcrypto.lib" ^
    -DLIB_EAY_DEBUG="%UE_THIRD_PARTY_DIR%\OpenSSL\1.1.1k\Lib\Win64\VS2015\Debug\libcrypto.lib" ^
    -DLIB_EAY_RELEASE="%UE_THIRD_PARTY_DIR%\OpenSSL\1.1.1k\Lib\Win64\VS2015\Release\libcrypto.lib" ^
    -DOPENSSL_INCLUDE_DIR="%UE_THIRD_PARTY_DIR%\OpenSSL\1.1.1k\include\Win64\VS2015" ^
    -DSSL_EAY_DEBUG="%UE_THIRD_PARTY_DIR%\OpenSSL\1.1.1k\Lib\Win64\VS2015\Debug\libssl.lib" ^
    -DSSL_EAY_LIBRARY_DEBUG="%UE_THIRD_PARTY_DIR%\OpenSSL\1.1.1k\Lib\Win64\VS2015\Debug\libssl.lib" ^
    -DSSL_EAY_LIBRARY_RELEASE="%UE_THIRD_PARTY_DIR%\OpenSSL\1.1.1k\Lib\Win64\VS2015\Release\libssl.lib" ^
    -DSSL_EAY_RELEASE="%UE_THIRD_PARTY_DIR%\OpenSSL\1.1.1k\Lib\Win64\VS2015\Release\libssl.lib"
cmake --build . --config Release

echo "--- copy grpc files to unreal plugin"

robocopy "%GRPC_ROOT%\grpc\\include" "%GRPC_PLUGIN_INCLUDE_DIR%\include" /S
robocopy "%GRPC_ROOT%\grpc\third_party\protobuf\src" "%GRPC_PLUGIN_INCLUDE_DIR%\third_party\protobuf\src" *.h *.inc /S
robocopy "%GRPC_ROOT%\grpc\third_party\googletest\googlemock\include" "%GRPC_PLUGIN_INCLUDE_DIR%\include" /S
robocopy "%GRPC_ROOT%\grpc\third_party\abseil-cpp\absl" "%GRPC_PLUGIN_INCLUDE_DIR%\third_party\absl" *.h *.inc /S
robocopy "%CMAKE_BUILD_DIR%\Release" "%GRPC_PLUGIN_LIBRARIES_DIR%" *.lib /S
robocopy "%THIRD_PARY_BUILD_DIR%" "%GRPC_PLUGIN_LIBRARIES_DIR%" *.lib  /S

endlocal
popd
