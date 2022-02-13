# gRPCForUE4
UE4でgRPCを利用できるようにするためのプラグイン  
SubmoduleとしてUnrealEngineのプロジェクトでプラグイン形式で組み込めることを想定している。    
実例として[gRPCForUE4ExampleProject](https://github.com/y-akahori-ramen/gRPCForUE4ExampleProject)がある。

## サポートしているgRPCVersion
- v1.41.1

## 必要環境
Windowsのみ対応。

さらに以下が使える状態であること。
- [Visual Stduio](https://visualstudio.microsoft.com/)
- [Git](https://git-scm.com/)
- [CMake](https://cmake.org/download/)
- [nasm](https://www.nasm.us/)
- [UnrealEngine](https://www.unrealengine.com/)

## 環境準備

コード取得
```
git clone -b v1.41.1 https://github.com/y-akahori-ramen/gRPCForUE4
```

gRPCプラグインを準備するためにUEのルートディレクトリとCMakeで使用するジェネレーターを環境変数に設定してsetup.batを呼び出す。  
バッチファイル内でgRPCのビルドを行い必要なファイルをプラグイン用のフォルダへコピーする。
```
set UE_ROOT=YOUR_UNREAL_ENGINE_ROOT
set CMAKE_GENERATOR=Visual Studio 17 2022
./Setup/setup.bat
```

UE4.27とVS2022で実行する例として [setupExampleVS2022UE427.bat](./Setup/setupExampleVS2022UE427.bat) がある。

## 参考
- https://qiita.com/mashira/items/bede3ad509f6f79cad19
- https://github.com/vizor-games/InfraworldRuntime