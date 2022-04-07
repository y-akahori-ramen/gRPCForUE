# gRPCForUE
gRPCForUE is plugin that to enable gRPC in UnrealEngine.

Example of using this plugin
- [gRPCForUE4ExampleProject](https://github.com/y-akahori-ramen/gRPCForUE4ExampleProject)

## Requirements
- Windows
- [Visual Stduio](https://visualstudio.microsoft.com/)
- [Git](https://git-scm.com/)
- [CMake](https://cmake.org/download/)
- [nasm](https://www.nasm.us/)
- [UnrealEngine](https://www.unrealengine.com/)

## Setup plugin
Build gRPC from source. and copy files to plugin.

```
git clone https://github.com/y-akahori-ramen/gRPCForUE
cd gRPCForUE
set UE_ROOT=Path to your unreal engine root. e.g. C:\Program Files\Epic Games\UE_4.27
set CMAKE_GENERATOR=Set your build system. e.g. Visual Studio 17 2022
set GRPC_BRANCH=gRPC version. e.g. v1.41.1
call ./Setup/setup.bat
```

Example
- [setupExampleVS2022UE427.bat](./Setup/setupExampleVS2022UE427.bat)

## References
- https://qiita.com/mashira/items/bede3ad509f6f79cad19
- https://github.com/vizor-games/InfraworldRuntime
