import 'dart:ffi';

// Константы и версии API
const int SV_PHYSICS_INTERFACE_VERSION = 6;

// Состояния сервера (#define SERVER_...)
abstract class ServerState {
  static const int dead    = 0;
  static const int loading = 1;
  static const int active  = 2;
}

// Вспомогательные типы (заглушки для тяжелых C-структур)
class LinkS extends Opaque {}
class EdictS extends Opaque {}
class TriangleApiS extends Opaque {}
class MSurfaceS extends Opaque {}
class TraceT extends Opaque {}
class SaveRestoreData extends Opaque {}
class DecalListS extends Opaque {}
class PlayerMoveS extends Opaque {}
class ModelS extends Opaque {}
class PhysentS extends Opaque {}
class PmtraceS extends Opaque {}

// Структура areanode_t (AABB дерево для коллизий)
class AreaNode extends Struct {
  @Int32()
  external int axis; // -1 = лист дерева (leaf node)
  @Float()
  external double dist;
  
  @Array(2)
  external Array<Pointer<AreaNode>> children;
  
  external LinkS triggerEdicts;
  external LinkS solidEdicts;
  external LinkS portalEdicts;
}

// Таблица вызовов Server Physics API
class ServerPhysicsApi extends Struct {
  external Pointer<NativeFunction<Void Function(Pointer<EdictS>, Int32)>> pfnLinkEdict;
  external Pointer<NativeFunction<Double Function()>> pfnGetServerTime;
  external Pointer<NativeFunction<Double Function()>> pfnGetFrameTime;
  external Pointer<NativeFunction<Pointer<Void> Function(Int32)>> pfnGetModel;
  external Pointer<AreaNode> pfnGetHeadnode;
  external Pointer<NativeFunction<Int32 Function()>> pfnServerState;
  external Pointer<Void> pfnHost_Error;
  
  external Pointer<TriangleApiS> pTriAPI;
  
  // Отладочный вывод геометрии коллизий
  external Pointer<NativeFunction<Int32 Function(Int32, Int32, Pointer<Char>)>> pfnDrawConsoleString;
  external Pointer<NativeFunction<Void Function(Float, Float, Float)>> pfnDrawSetTextColor;
  
  // Работа с поверхностями и Fog/Текстурами
  external Pointer<Void> pfnUpdateFogSettings;
  external Pointer<NativeFunction<Pointer<MSurfaceS> Function(Pointer<EdictS>, Pointer<Float>, Pointer<Float>)>> pfnTraceSurface;
  external Pointer<NativeFunction<Pointer<Uint8> Function(Uint32)>> pfnGetTextureData;
  
  // Аллокатор памяти (замыкается на mcore)
  external Pointer<NativeFunction<Pointer<Void> Function(Size, Pointer<Char>, Int32)>> pfnMemAlloc;
  external Pointer<NativeFunction<Void Function(Pointer<Void>, Pointer<Char>, Int32)>> pfnMemFree;
  
  // --- ТРАССИРОВКА ЛУЧЕЙ (Дергается из Dart) ---
  external Pointer<NativeFunction<TraceT Function(Pointer<Float>, Pointer<Float>, Pointer<Float>, Pointer<Float>, Int32, Pointer<EdictS>)>> pfnTrace;
  external Pointer<NativeFunction<TraceT Function(Pointer<Float>, Pointer<Float>, Pointer<Float>, Pointer<Float>, Int32, Pointer<EdictS>)>> pfnTraceNoEnts;
  
  // Менеджмент LUMP-ов BSP-карты (для вытаскивания геометрии беты HL2)
  external Pointer<NativeFunction<Int32 Function(Pointer<Char>, Int32, Pointer<Int32>)>> pfnCheckLump;
  external Pointer<NativeFunction<Int32 Function(Pointer<Char>, Int32, Pointer<Pointer<Void>>, Pointer<Int32>)>> pfnReadLump;
  external Pointer<NativeFunction<Int32 Function(Pointer<Char>, Int32, Pointer<Void>, Int32)>> pfnSaveLump;
}

// Таблица кастомных коллбеков физики Physics Interface (Заполняется в Dart)
class PhysicsInterface extends Struct {
  @Int32()
  external int version;

  // Точки внедрения Dart-логики вместо C++
  external Pointer<NativeFunction<Int32 Function(Pointer<EdictS>, Pointer<Char>)>> SV_CreateEntity;
  external Pointer<NativeFunction<Int32 Function(Pointer<EdictS>)>> SV_PhysicsEntity; // Хитрый кастомный тик физики
  external Pointer<NativeFunction<Int32 Function(Pointer<Char>, Pointer<Char>)>> SV_LoadEntities;
  external Pointer<Void> SV_UpdatePlayerBaseVelocity;
  external Pointer<NativeFunction<Int32 Function()>> SV_AllowSaveGame;
  
  external Pointer<NativeFunction<Int32 Function(Pointer<EdictS>, Pointer<EdictS>)>> SV_TriggerTouch;
  external Pointer<Void> DrawDebugTriangles;
  external Pointer<Void> ClipMoveToEntity;
  external Pointer<NativeFunction<Void Function()>> SV_EndFrame;
  
  // Работа с кастомными строками на стороне Dart
  external Pointer<NativeFunction<Int32 Function(Pointer<Char>)>> pfnAllocString;
  external Pointer<NativeFunction<Pointer<Char> Function(Int32)>> pfnGetString;
  
  // Кастомный Think игрока
  external Pointer<NativeFunction<Int32 Function(Pointer<EdictS>, Float, Double)>> SV_PlayerThink;
}
