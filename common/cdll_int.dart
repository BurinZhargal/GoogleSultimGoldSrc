import 'dart:ffi';
import 'package:ffi/ffi.dart';

// Непрозрачные типы движка для безопасных указателей
class CvarS extends Opaque {}
class ClEntityS extends Opaque {}
class ModelS extends Opaque {}
class EdictS extends Opaque {}
class PntraceS extends Opaque {}
class ScreenfadeS extends Opaque {}
class TriangleapiS extends Opaque {}
class EfxApiS extends Opaque {}
class EventApiS extends Opaque {}
class DemoApiS extends Opaque {}
class NetApiS extends Opaque {}
class IVoiceTweakS extends Opaque {}

// Базовая геометрия из wrect.h
class WRect extends Struct {
  @Int32() external int left;
  @Int32() external int top;
  @Int32() external int right;
  @Int32() external int bottom;
}

// Структура экрана
class ScreenInfo extends Struct {
  @Int32() external int iSize;
  @Int32() external int iWidth;
  @Int32() external int iHeight;
  @Int32() external int iFlags;
  @Int32() external int iCharHeight;
  @Array(256) external Array<Int16> charWidths;
}

// Таблица вызовов Engine -> Dart
class ClEngineFuncs extends Struct {
  // --- SPRITE HANDLERS ---
  external Pointer<NativeFunction<Int32 Function(Pointer<Char>)>> pfnSPR_Load;
  external Pointer<NativeFunction<Int32 Function(Int32)>> pfnSPR_Frames;
  external Pointer<NativeFunction<Int32 Function(Int32, Int32)>> pfnSPR_Height;
  external Pointer<NativeFunction<Int32 Function(Int32, Int32)>> pfnSPR_Width;
  external Pointer<NativeFunction<Void Function(Int32, Int32, Int32, Int32)>> pfnSPR_Set;
  external Pointer<NativeFunction<Void Function(Int32, Int32, Int32, Pointer<WRect>)>> pfnSPR_Draw;
  external Pointer<NativeFunction<Void Function(Int32, Int32, Int32, Pointer<WRect>)>> pfnSPR_DrawHoles;
  external Pointer<NativeFunction<Void Function(Int32, Int32, Int32, Pointer<WRect>)>> pfnSPR_DrawAdditive;
  external Pointer<NativeFunction<Void Function(Int32, Int32, Int32, Int32)>> pfnSPR_EnableScissor;
  external Pointer<NativeFunction<Void Function()>> pfnSPR_DisableScissor;
  external Pointer<Void> pfnSPR_GetList;

  // --- SCREEN & CONSOLE ---
  external Pointer<NativeFunction<Void Function(Int32, Int32, Int32, Int32, Int32, Int32, Int32, Int32)>> pfnFillRGBA;
  external Pointer<NativeFunction<Int32 Function(Pointer<ScreenInfo>)>> pfnGetScreenInfo;
  external Pointer<NativeFunction<Void Function(Pointer<Char>)>> pfnConsolePrint;
  
  // --- CVARS & CMDS ---
  external Pointer<NativeFunction<Pointer<CvarS> Function(Pointer<Char>, Pointer<Char>, Int32)>> pfnRegisterVariable;
  external Pointer<NativeFunction<Float Function(Pointer<Char>)>> pfnGetCvarFloat;
  external Pointer<NativeFunction<Pointer<Char> Function(Pointer<Char>)>> pfnGetCvarString;
  external Pointer<NativeFunction<Int32 Function(Pointer<Char>, Pointer<Void>)>> pfnAddCommand;
  external Pointer<NativeFunction<Int32 Function(Pointer<Char>)>> pfnServerCmd;
  external Pointer<NativeFunction<Int32 Function(Pointer<Char>)>> pfnClientCmd;

  // --- SOUNDS ---
  external Pointer<NativeFunction<Void Function(Pointer<Char>, Float)>> pfnPlaySoundByName;
  external Pointer<NativeFunction<Void Function(Int32, Float)>> pfnPlaySoundByIndex;

  // --- MODEL & VISIBLE ENTITIES ---
  external Pointer<NativeFunction<Pointer<ModelS> Function(Pointer<Char>, Pointer<Int32>)>> CL_LoadModel;
  external Pointer<NativeFunction<Int32 Function(Int32, Pointer<ClEntityS>)>> CL_CreateVisibleEntity;
  
  // --- MEMORY SYSTEM TO HOOK MCORE ---
  external Pointer<NativeFunction<Pointer<Uint8> Function(Pointer<Char>, Int32, Pointer<Int32>)>> COM_LoadFile;
  external Pointer<NativeFunction<Void Function(Pointer<Void>)>> COM_FreeFile;

  // --- API SUB-TABLES ---
  external Pointer<TriangleapiS> pTriAPI;
  external Pointer<EfxApiS> pEfxAPI;
  external Pointer<EventApiS> pEventAPI;
  external Pointer<DemoApiS> pDemoAPI;
  external Pointer<NetApiS> pNetAPI;
  external Pointer<IVoiceTweakS> pVoiceTweak;
}
