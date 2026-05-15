import 'dart:ffi';

// Generic Vertex под текстурированные квады интерфейса
class VPoint extends Struct {
  @Float() external double pointX; // vec2_t point
  @Float() external double pointY;
  @Float() external double coordS; // vec2_t coord (Текстурные UV)
  @Float() external double coordT;
}

// === КЛИКИ МЫШИ (VGUI_MouseCode) ===
abstract class VGuiMouseCode {
  static const int mouseLeft   = 0;
  static const int mouseRight  = 1;
  static const int mouseMiddle = 2;
  static const int mouseLast   = 3;
}

// === ДЕЙСТВИЯ (VGUI_KeyAction & VGUI_MouseAction) ===
abstract class VGuiKeyAction {
  static const int kaTyped    = 0;
  static const int kaPressed  = 1;
  static const int kaReleased = 2;
}

abstract class VGuiMouseAction {
  static const int maPressed  = 0;
  static const int maReleased = 1;
  static const int maDouble   = 2;
  static const int maWheel    = 3;
}

// === ПОЛНАЯ КАРТА КЛАВИШ VGUI (VGUI_KeyCode) ===
abstract class VGuiKeyCode {
  // Цифры и буквы
  static const int key0 = 0; static const int key1 = 1; static const int key2 = 2;
  static const int key3 = 3; static const int key4 = 4; static const int key5 = 5;
  static const int key6 = 6; static const int key7 = 7; static const int key8 = 8;
  static const int key9 = 9;
  static const int keyA = 10; static const int keyB = 11; static const int keyC = 12;
  static const int keyD = 13; static const int keyE = 14; static const int keyF = 15;
  static const int keyG = 16; static const int keyH = 17; static const int keyI = 18;
  static const int keyJ = 19; static const int keyK = 20; static const int keyL = 21;
  static const int keyM = 22; static const int keyN = 23; static const int keyO = 24;
  static const int keyP = 25; static const int keyQ = 26; static const int keyR = 27;
  static const int keyS = 28; static const int keyT = 29; static const int keyU = 30;
  static const int keyV = 31; static const int keyW = 32; static const int keyX = 33;
  static const int keyY = 34; static const int keyZ = 35;

  // Цифровой блок (Numpad)
  static const int keyPad0 = 36; static const int keyPad1 = 37; static const int keyPad2 = 38;
  static const int keyPad3 = 39; static const int keyPad4 = 40; static const int keyPad5 = 41;
  static const int keyPad6 = 42; static const int keyPad7 = 43; static const int keyPad8 = 44;
  static const int keyPad9 = 45;
  static const int keyPadDivide   = 46;
  static const int keyPadMultiply = 47;
  static const int keyPadMinus    = 48;
  static const int keyPadPlus     = 49;
  static const int keyPadEnter    = 50;
  static const int keyPadDecimal  = 51;

  // Знаки препинания и символы
  static const int keyLBracket   = 52;
  static const int keyRBracket   = 53;
  static const int keySemicolon  = 54;
  static const int keyApostrophe = 55;
  static const int keyBackquote  = 56;
  static const int keyComma      = 57;
  static const int keyPeriod     = 58;
  static const int keySlash      = 59;
  static const int keyBackslash  = 60;
  static const int keyMinus      = 61;
  static const int keyEqual      = 62;

  // Управляющие клавиши
  static const int keyEnter      = 63;
  static const int keySpace      = 64;
  static const int keyBackspace  = 65;
  static const int keyTab        = 66;
  static const int keyCapslock   = 67;
  static const int keyNumlock    = 68;
  static const int keyEscape     = 69;
  static const int keyScrolllock = 70;
  static const int keyInsert     = 71;
  static const int keyDelete     = 72;
  static const int keyHome       = 73;
  static const int keyEnd        = 74;
  static const int keyPageUp     = 75;
  static const int keyPageDown   = 76;
  static const int keyBreak      = 77;

  // Модификаторы и системные кнопки
  static const int keyLShift    = 78;
  static const int keyRShift    = 79;
  static const int keyLAlt      = 80;
  static const int keyRAlt      = 81;
  static const int keyLControl  = 82;
  static const int keyRControl  = 83;
  static const int keyLWin      = 84;
  static const int keyRWin      = 85;
  static const int keyApp       = 86;

  // Стрелки навигации
  static const int keyUp    = 87;
  static const int keyLeft  = 88;
  static const int keyDown  = 89;
  static const int keyRight = 90;

  // Функциональный ряд F1-F12
  static const int keyF1 = 91;  static const int keyF2 = 92;  static const int keyF3 = 93;
  static const int keyF4 = 94;  static const int keyF5 = 95;  static const int keyF6 = 96;
  static const int keyF7 = 97;  static const int keyF8 = 98;  static const int keyF9 = 99;
  static const int keyF10 = 100; static const int keyF11 = 101; static const int keyF12 = 102;
  
  static const int keyLast = 103;
}

// Основной интерфейс VGUI API
class VGuiApi extends Struct {
  @Int32() external int initialized;

  // Коллбеки от vgui_support (Подменяются пустыми заглушками Dart)
  external Pointer<NativeFunction<Void Function()>> DrawInit;
  external Pointer<NativeFunction<Void Function()>> DrawShutdown;
  external Pointer<Void> SetupDrawingText;
  external Pointer<Void> SetupDrawingRect;
  external Pointer<Void> SetupDrawingImage;
  external Pointer<NativeFunction<Void Function(Int32)>> BindTexture;
  external Pointer<NativeFunction<Void Function(Int32)>> EnableTexture;
  external Pointer<Void> Reserved0;
  external Pointer<NativeFunction<Void Function(Int32, Pointer<Char>, Int32, Int32)>> UploadTexture;
  external Pointer<Void> Reserved1;
  external Pointer<NativeFunction<Void Function(Pointer<VPoint>, Pointer<VPoint>)>> DrawQuad;
  external Pointer<Void> GetTextureSizes;
  external Pointer<NativeFunction<Int32 Function()>> GenerateTexture;
  
  // Системная интеграция кучи через mcore
  external Pointer<NativeFunction<Pointer<Void> Function(Size)>> EngineMalloc;
  external Pointer<NativeFunction<Void Function(Int32)>> CursorSelect;
  external Pointer<Void> GetColor;
  external Pointer<NativeFunction<Int32 Function()>> IsInGame;
  external Pointer<NativeFunction<Void Function(Int32, Int32)>> EnableTextInput;
  external Pointer<NativeFunction<Void Function(Pointer<Int32>, Pointer<Int32>)>> GetCursorPos;
  external Pointer<Void> ProcessUtfChar;
  
  // Буфер обмена (Замыкается напрямую на ОС через Flutter)
  external Pointer<NativeFunction<Int32 Function(Pointer<Char>, Size)>> GetClipboardText;
  external Pointer<NativeFunction<Void Function(Pointer<Char>)>> SetClipboardText;
  external Pointer<NativeFunction<Int32 Function()>> GetKeyModifiers;

  // Сигналы от движка (Слушаются на стороне Dart)
  external Pointer<NativeFunction<Void Function(Int32, Int32)>> Startup;
  external Pointer<NativeFunction<Void Function()>> Shutdown;
  external Pointer<NativeFunction<Pointer<Void> Function()>> GetPanel;
  external Pointer<NativeFunction<Void Function()>> Paint;
  external Pointer<NativeFunction<Void Function(Int32, Int32)>> Mouse;
  external Pointer<NativeFunction<Void Function(Int32, Int32)>> Key;
  external Pointer<NativeFunction<Void Function(Int32, Int32)>> MouseMove;
  external Pointer<NativeFunction<Void Function(Pointer<Char>)>> TextInput;
}
