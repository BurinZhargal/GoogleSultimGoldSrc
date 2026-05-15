import 'dart:ffi';
import 'dart:io';
import 'package:ffi/ffi.dart';

// Сигнатура Host_Main из game.cpp:
// int Host_Main(int argc, char **argv, const char *progname, int bChangeGame, void* func);
typedef HostMainNative = Int32 Function(
  Int32 argc, 
  Pointer<Pointer<Char>> argv, 
  Pointer<Char> progName, 
  Int32 bChangeGame, 
  Pointer<Void> changeGameFunc
);
typedef HostMain = int Function(
  int argc, 
  Pointer<Pointer<Char>> argv, 
  Pointer<Char> progName, 
  int bChangeGame, 
  Pointer<Void> changeGameFunc
);

// Сигнатура Host_Shutdown
typedef HostShutdownNative = Void Function();
typedef HostShutdown = void Function();

class GoogleXash3DGoldSrc {
  late DynamicLibrary _engineLib;
  late HostMain _hostMain;
  late HostShutdown _hostShutdown;
  
  Pointer<Pointer<Char>>? _nativeArgv;
  Pointer<Char>? _progName;

  void initEngine() {
    // 1. Загружаем SDL2, как это делает Sys_LoadEngine в game.cpp
    if (Platform.isWindows) {
      DynamicLibrary.open('SDL2.dll');
      _engineLib = DynamicLibrary.open('xash.dll');
    } else {
      _engineLib = DynamicLibrary.open('libxash.so');
    }

    // 2. Вытаскиваем экспорты точек входа ядра
    _hostMain = _engineLib
        .lookup<NativeFunction<HostMainNative>>('Host_Main')
        .asFunction();
        
    _hostShutdown = _engineLib
        .lookup<NativeFunction<HostShutdownNative>>('Host_Shutdown')
        .asFunction();
  }

  int start(List<String> arguments) {
    // В качестве базовой директории используем "valve", как в XASH_GAMEDIR
    _progName = "valve".toNativeUtf8().cast<Char>();

    // 3. Маршалинг аргументов командной строки (Аналог WinMain циклов из game.cpp)
    final int argc = arguments.length + 1;
    _nativeArgv = calloc<Pointer<Char>>(argc + 1);
    
    // Первый аргумент всегда имя исполняемого файла
    _nativeArgv![0] = "googlexash3d".toNativeUtf8().cast<Char>();
    
    for (int i = 0; i < arguments.length; i++) {
      _nativeArgv![i + 1] = arguments[i].toNativeUtf8().cast<Char>();
    }
    _nativeArgv![argc] = nullptr;

    print("GoogleXash3D: Передача управления в Host_Main...");
    
    // 4. Запуск движка. Передаем nullptr вместо Sys_ChangeGame
    final int result = _hostMain(argc, _nativeArgv!, _progName!, 0, nullptr);
    
    return result;
  }

  void stop() {
    print("GoogleXash3D: Остановка графического ядра...");
    _hostShutdown();
    
    // Вычищаем выделенную FFI память в куче mcore
    if (_nativeArgv != null) {
      int i = 0;
      while (_nativeArgv![i] != nullptr) {
        calloc.free(_nativeArgv![i]);
        i++;
      }
      calloc.free(_nativeArgv!);
    }
    if (_progName != null) calloc.free(_progName!);
  }
}
