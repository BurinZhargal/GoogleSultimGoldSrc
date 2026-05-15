import 'dart:ffi';

// Константы и версии API
const int MOBILITY_API_VERSION = 2;
const String MOBILITY_CLIENT_EXPORT = "HUD_MobilityInterface";

// Флаги вибрации (#define VIBRATE_...)
abstract class VibrateFlags {
  static const int normal = 1 << 0; // Обычная вибрация на заданное время
}

// Флаги наэкранных кнопок (#define TOUCH_FL_...)
abstract class TouchFlags {
  static const int hide          = 1 << 0;
  static const int noEdit        = 1 << 1;
  static const int client        = 1 << 2;
  static const int mp            = 1 << 3;
  static const int sp            = 1 << 4;
  static const int defShow       = 1 << 5;
  static const int defHide       = 1 << 6;
  static const int drawAdditive  = 1 << 7;
  static const int stroke        = 1 << 8;
  static const int precision     = 1 << 9;
}

// Флаги безопасного парсинга файлов (COM_ParseFileSafe)
abstract class PFileFlags {
  static const int ignoreBracket = 1 << 0;
  static const int handleColon   = 1 << 1;
  static const int ignoreHashCmt = 1 << 2;
}

// Структура mobile_engfuncs_t
class MobileEngFuncs extends Struct {
  @Int32()
  external int version; // Должна быть равна MOBILITY_API_VERSION

  // --- КОНТРОЛЬ ВИБРАЦИИ (Вызывается из Dart во Flutter/Android) ---
  external Pointer<NativeFunction<Void Function(Float, Char)>> pfnVibrate;

  // --- СИСТЕМНЫЕ ФУНКЦИИ ВВОДА ---
  external Pointer<NativeFunction<Void Function(Int32)>> pfnEnableTextInput;

  // Наэкранные кнопки (Управление текстурами и координатами)
  external Pointer<NativeFunction<Void Function(Pointer<Char>, Pointer<Char>, Pointer<Char>, Float, Float, Float, Float, Pointer<Uint8>, Int32, Float, Int32)>> pfnTouchAddClientButton;
  external Pointer<NativeFunction<Void Function(Pointer<Char>, Pointer<Char>, Pointer<Char>, Float, Float, Float, Float, Pointer<Uint8>, Int32, Float, Int32)>> pfnTouchAddDefaultButton;
  external Pointer<NativeFunction<Void Function(Pointer<Char>, Uint8)>> pfnTouchHideButtons;
  external Pointer<NativeFunction<Void Function(Pointer<Char>)>> pfnTouchRemoveButton;
  external Pointer<NativeFunction<Void Function(Uint8)>> pfnTouchSetClientOnly;
  external Pointer<NativeFunction<Void Function()>> pfnTouchResetDefaultButtons;

  // Рендеринг шрифтов
  @Int32()
  external Pointer<NativeFunction<Int32 Function(Int32, Int32, Int32, Int32, Int32, Int32, Float)>> pfnDrawScaledCharacter;

  // Системные логи и варнинги
  external Pointer<Void> pfnSys_Warn;

  // Работа с нативными объектами ОС (JNI / Objective-C)
  external Pointer<NativeFunction<Pointer<Void> Function(Pointer<Char>)>> pfnGetNativeObject;
  external Pointer<NativeFunction<Void Function(Pointer<Char>)>> pfnSetCustomClientID;

  // Безопасный парсер строк (Замыкается на ваш mcore буфер)
  external Pointer<NativeFunction<Pointer<Char> Function(Pointer<Char>, Pointer<Char>, Int32, Uint32, Pointer<Int32>)>> pfnParseFile;
}
