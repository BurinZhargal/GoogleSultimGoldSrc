import 'dart:ffi';

// Константы и версия API
const int REF_API_VERSION = 17;
const int SKYBOX_MAX_SIDES = 6;

// Перечисления оконных режимов (WINDOW_MODE_...)
abstract class WindowMode {
  static const int windowed   = 0;
  static const int fullscreen = 1;
  static const int borderless = 2;
  static const int count      = 3;
}

// Типы нативных оконных объектов (REF_WINDOW_TYPE_...)
abstract class RefWindowType {
  static const int nullType = 0;
  static const int win32    = 1; // HWND
  static const int x11      = 2; // Display*
  static const int wayland  = 3; // wl_display*
  static const int macOS    = 4; // NSWindow*
  static const int sdl2     = 5; // SDL_Window*
  static const int sdl3     = 6; // SDL_Window*
}

// Состояния подключения (connstate_t)
abstract class ConnState {
  static const int disconnected = 0;
  static const int connecting   = 1;
  static const int connected    = 2;
  static const int validate     = 3;
  static const int active       = 4;
  static const int cinematic    = 5;
}

// Заглушки для тяжелых C-структур геометрии
class MSurfaceT extends Opaque {}
class ModelT extends Opaque {}

// Базовая геометрия (vec3_t)
class Vec3 extends Struct {
  @Float() external double x;
  @Float() external double y;
  @Float() external double z;
}

// Структура сортировки полупрозрачных граней
class SortedFace extends Struct {
  external Pointer<MSurfaceT> surf;
  @Int32() external int cull;
}

// Глобальные параметры рендерера (ref_globals_t)
class RefGlobals extends Struct {
  @Int32() external int developer; // qboolean (int)

  @Int32() external int width;     // Физический размер окна в пикселях
  @Int32() external int height;

  @Int32() external int windowMode; // Из лимитов WindowMode
  @Int32() external int wideScreen;

  external Vec3 vieworg;           // Позиция камеры XYZ
  external Vec3 viewangles;        // Углы поворота камеры

  external Pointer<SortedFace> drawSurfaces; // Сортировка для прозрачности
  @Int32() external int maxSurfaces;
  @Size() external int visbytes;

  @Int32() external int desktopBitsPixel;

  @Float() external double scaleX; // Коэффициенты масштабирования окна
  @Float() external double scaleY;
}

// Данные графического клиента (ref_client_t)
class RefClient extends Struct {
  @Double() external double time;
  @Double() external double oldtime;
  @Int32()  external int viewentity;
  @Int32()  external int playernum;
  @Int32()  external int maxclients;
  @Int32()  external int nummodels;
  
  // Массив указателей на модели (в оригинале MAX_MODELS + 1)
  @Array(513) // Для GoldSrc лимит по умолчанию 512 + 1
  external Array<Pointer<ModelT>> models;

  @Int32()  external int paused;
  external Vec3 simorg;
}

// Данные хоста (ref_host_t)
class RefHost extends Struct {
  @Double() external double realtime;
  @Double() external double frametime;
  @Int32()  external int features;
}
