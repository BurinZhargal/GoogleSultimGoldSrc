import 'dart:ffi';
import 'package:ffi/ffi.dart';

// Флаги для загрузки изображений (#define PIC_...)
abstract class PicFlags {
  static const int nearest       = 1 << 0; // Отключение фильтрации текстур (Nearest)
  static const int keepSource    = 1 << 1;
  static const int noFlipTga     = 1 << 2;
  static const int expandSource  = 1 << 3; // Разворачивание в RGBA
}

// Глобальные переменные UI структуры ui_globalvars_t
class UiGlobalVars extends Struct {
  @Float() external double time;
  @Float() external double frametime;

  @Int32() external int scrWidth;
  @Int32() external int scrHeight;

  @Int32() external int maxClients;
  @Int32() external int developer;
  @Int32() external int demoPlayback;
  @Int32() external int demoRecording;

  @Array(64) external Array<Char> demoName;
  @Array(64) external Array<Char> mapTitle;
}

// Таблица функций UI Engine -> Dart
class UiEngineFuncs extends Struct {
  // --- IMAGE HANDLERS (Перенаправляются во Flutter) ---
  external Pointer<NativeFunction<Int32 Function(Pointer<Char>, Pointer<Uint8>, Int32, Int32)>> pfnPIC_Load;
  external Pointer<NativeFunction<Void Function(Pointer<Char>)>> pfnPIC_Free;
  external Pointer<NativeFunction<Int32 Function(Int32)>> pfnPIC_Width;
  external Pointer<NativeFunction<Int32 Function(Int32)>> pfnPIC_Height;
  external Pointer<Void> pfnPIC_Draw;

  // --- CVAR & COMMAND HANDLERS ---
  external Pointer<Void> pfnRegisterVariable; // cvar_t*
  external Pointer<NativeFunction<Float Function(Pointer<Char>)>> pfnGetCvarFloat;
  external Pointer<NativeFunction<Pointer<Char> Function(Pointer<Char>)>> pfnGetCvarString;
  external Pointer<NativeFunction<Void Function(Pointer<Char>, Pointer<Char>)>> pfnCvarSetString;
  external Pointer<NativeFunction<Void Function(Pointer<Char>, Float)>> pfnCvarSetValue;
  external Pointer<NativeFunction<Int32 Function(Pointer<Char>, Pointer<Void>)>> pfnAddCommand;
  external Pointer<NativeFunction<Void Function(Int32, Pointer<Char>)>> pfnClientCmd;

  // --- SOUND & AUDIO TRACKS ---
  external Pointer<NativeFunction<Void Function(Pointer<Char>)>> pfnPlayLocalSound;
  external Pointer<NativeFunction<Void Function(Pointer<Char>, Pointer<Char>)>> pfnPlayBackgroundTrack;

  // --- FILE SYSTEM (Замыкается на mcore) ---
  external Pointer<NativeFunction<Int32 Function(Pointer<Char>, Int32)>> pfnFileExists;
  external Pointer<NativeFunction<Void Function(Pointer<Char>)>> pfnGetGameDir;
  external Pointer<NativeFunction<Pointer<Uint8> Function(Pointer<Char>, Pointer<Int32>)>> COM_LoadFile;
  external Pointer<NativeFunction<Void Function(Pointer<Void>)>> COM_FreeFile;
  external Pointer<NativeFunction<Int32 Function(Pointer<Char>, Pointer<Void>, Int32)>> COM_SaveFile;
  external Pointer<NativeFunction<Int32 Function(Pointer<Char>)>> COM_RemoveFile;

  // --- MAPS & GAME STATES ---
  external Pointer<NativeFunction<Int32 Function(Int32)>> pfnCreateMapsList;
  external Pointer<NativeFunction<Int32 Function()>> pfnClientInGame;
  external Pointer<NativeFunction<Void Function(Pointer<Char>)>> pfnHostEndGame;

  // --- CUSTOM ENGINE MEMORY MANAGER (Сюда инжектируется mcore) ---
  external Pointer<NativeFunction<Pointer<Void> Function(Size, Pointer<Char>, Int32)>> pfnMemAlloc;
  external Pointer<NativeFunction<Void Function(Pointer<Void>, Pointer<Char>, Int32)>> pfnMemFree;
}
