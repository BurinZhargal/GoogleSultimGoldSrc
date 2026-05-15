import 'dart:ffi';
import 'package:ffi/ffi.dart';

// Подключаем ранее созданные структуры
import 'edict_structs.dart'; // edict_t
import 'custom_structs.dart'; // cvar_t, etc.

// === СИСТЕМНЫЕ ENUMS И КОНСТАНТЫ ===
abstract class AlertType {
  static const int atNotice    = 0;
  static const int atConsole   = 1;
  static const int atAiConsole = 2;
  static const int atWarning   = 3;
  static const int atError     = 4;
  static const int atLogged    = 5;
}

abstract class PrintType {
  static const int printConsole = 0;
  static const int printCenter  = 1;
  static const int printChat    = 2;
}

// === СТРУКТУРЫ РЕЗУЛЬТАТОВ ГЕОМЕТРИИ ===

// TraceResult -> Идеален для расчетов попадания заклинаний или Physgun в бету HL2
class TraceResult extends Struct {
  @Int32() external int fAllSolid;       // Если true, значит луч полностью внутри стены
  @Int32() external int fStartSolid;     // Исходная точка луча была в стене
  @Int32() external int fInOpen;
  @Int32() external int fInWater;
  @Float() external double flFraction;   // Время полета луча (1.0 = ни обо что не ударился)
  
  // vec3_t vecEndPos -> 12 байт конечной точки удара лазера
  @Float() external double endX;
  @Float() external double endY;
  @Float() external double endZ;
  
  @Float() external double flPlaneDist;
  
  // vec3_t vecPlaneNormal -> Вектор нормали поверхности удара
  @Float() external double normalX;
  @Float() external double normalY;
  @Float() external double normalZ;
  
  external Pointer<EdictS> pHit;         // Указатель на edict_s объекта, в который попали
  @Int32() external int iHitgroup;       // Хитбокс (голова, тело, ноги)
}

// === ТАБЛИЦА ФУНКЦИЙ ЯДРА (Engine Funcs) ===
class EngineFuncs extends Struct {
  // Прекэш ресурсов
  external Pointer<NativeFunction<Int32 Function(Pointer<Char>)>> pfnPrecacheModel;
  external Pointer<NativeFunction<Int32 Function(Pointer<Char>)>> pfnPrecacheSound;
  
  // Управление сущностями
  external Pointer<NativeFunction<Void Function(Pointer<EdictS>, Pointer<Char>)>> pfnSetModel;
  external Pointer<NativeFunction<Int32 Function(Pointer<Char>)>> pfnModelIndex;
  external Pointer<NativeFunction<Void Function(Pointer<EdictS>, Pointer<Float>, Pointer<Float>)>> pfnSetSize;
  
  // Поиск объектов в 3D пространстве
  external Pointer<NativeFunction<Pointer<EdictS> Function(Pointer<EdictS>, Pointer<Char>, Pointer<Char>)>> pfnFindEntityByString;
  external Pointer<NativeFunction<Pointer<EdictS> Function(Pointer<EdictS>, Pointer<Float>, Float)>> pfnFindEntityInSphere;

  // Создание / Уничтожение объектов через ваш mcore пулинг
  external Pointer<NativeFunction<Pointer<EdictS> Function()>> pfnCreateEntity;
  external Pointer<NativeFunction<Void Function(Pointer<EdictS>)>> pfnRemoveEntity;
  external Pointer<NativeFunction<Void Function(Pointer<EdictS>, Pointer<Float>)>> pfnSetOrigin;

  // Звуковой движок
  external Pointer<NativeFunction<Void Function(Pointer<EdictS>, Int32, Pointer<Char>, Float, Float, Int32, Int32)>> pfnEmitSound;

  // --- ТРАССИРОВКА ЛУЧЕЙ И КОЛЛИЗИИ ---
  // Напрямую дергает BSP дерево коллизий карты Half-Life 2 / Поттера
  external Pointer<NativeFunction<Void Function(Pointer<Float>, Pointer<Float>, Int32, Pointer<EdictS>, Pointer<TraceResult>)>> pfnTraceLine;
  external Pointer<NativeFunction<Void Function(Pointer<EdictS>, Pointer<EdictS>, Pointer<TraceResult>)>> pfnTraceToss;

  // Сетевые сообщения и сериализация в Dart байты
  external Pointer<NativeFunction<Void Function(Int32, Int32, Pointer<Float>, Pointer<EdictS>)>> pfnMessageBegin;
  external Pointer<NativeFunction<Void Function()>> pfnMessageEnd;
  external Pointer<NativeFunction<Void Function(Int32)>> pfnWriteByte;
  external Pointer<NativeFunction<Void Function(Float)>> pfnWriteCoord;
  external Pointer<NativeFunction<Void Function(Pointer<Char>)>> pfnWriteString;

  // Работа с Cvars
  external Pointer<NativeFunction<Float Function(Pointer<Char>)>> pfnCVarGetFloat;
  external Pointer<NativeFunction<Pointer<Char> Function(Pointer<Char>)>> pfnCVarGetString;
  external Pointer<NativeFunction<Void Function(Pointer<Char>, Pointer<Char>)>> pfnCVarSetString;

  // Навигация по индексам в памяти mcore
  external Pointer<NativeFunction<Int32 Function(Pointer<EdictS>)>> pfnIndexOfEdict;
  external Pointer<NativeFunction<Pointer<EdictS> Function(Int32)>> pfnPEntityOfEntIndex;
  
  // Скелетная анимация (Хитбоксы и кости моделей из беты HL2)
  external Pointer<NativeFunction<Void Function(Pointer<EdictS>, Int32, Pointer<Float>, Pointer<Float>)>> pfnGetBonePosition;

  // Логирование и консоль
  external Pointer<NativeFunction<Void Function(Pointer<Char>)>> pfnServerPrint;
}
