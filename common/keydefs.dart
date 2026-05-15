// === ИНТЕРФЕЙС КОДОВ КЛАВИШ (Аналог #define из keydefs.h) ===
abstract class KeyDefs {
  // Стандартные управляющие клавиши ASCII
  static const int kTab         = 9;
  static const int kEnter       = 13;
  static const int kEscape      = 27;
  static const int kSpace       = 32;
  static const int kScrollLock  = 70;
  static const int kBackspace   = 127;

  // Стрелки и системные модификаторы
  static const int kUpArrow     = 128;
  static const int kDownArrow   = 129;
  static const int kLeftArrow   = 130;
  static const int kRightArrow  = 131;
  static const int kAlt         = 132;
  static const int kCtrl        = 133;
  static const int kShift       = 134;

  // Функциональные клавиши
  static const int kF1          = 135;
  static const int kF2          = 136;
  static const int kF3          = 137;
  static const int kF4          = 138;
  static const int kF5          = 139;
  static const int kF6          = 140;
  static const int kF7          = 141;
  static const int kF8          = 142;
  static const int kF9          = 143;
  static const int kF10         = 144;
  static const int kF11         = 145;
  static const int kF12         = 146;

  // Навигация по блокам
  static const int kIns         = 147;
  static const int kDel         = 148;
  static const int kPgDn        = 149;
  static const int kPgUp        = 150;
  static const int kHome        = 151;
  static const int kEnd         = 152;

  // Цифровая клавиатура (Numpad)
  static const int kKpHome      = 160;
  static const int kKpUpArrow   = 161;
  static const int kKpPgUp      = 162;
  static const int kKpLeftArrow = 163;
  static const int kKp5         = 164;
  static const int kKpRightArrow = 165;
  static const int kKpEnd       = 166;
  static const int kKpDownArrow = 167;
  static const int kKpPgDn      = 168;
  static const int kKpEnter     = 169;
  static const int kKpIns       = 170;
  static const int kKpDel       = 171;
  static const int kKpSlash     = 172;
  static const int kKpMinus     = 173;
  static const int kKpPlus      = 174;
  static const int kCapsLock    = 175;
  static const int kKpMul       = 176;
  static const int kWin         = 177;
  static const int kKpNumLock   = 178;

  // Кнопки мыши (Виртуальные коды)
  static const int kMWheelDown  = 239;
  static const int kMWheelUp    = 240;
  static const int kMouse1      = 241;
  static const int kMouse2      = 242;
  static const int kMouse3      = 243;
  static const int kMouse4      = 244;
  static const int kMouse5      = 245;

  static const int kPause       = 255;
  static const int kInternational = 256;

  // Геймпады / Джойстики (Группы AUX)
  static const int kJoy1        = 203;
  static const int kJoy2        = 204;
  static const int kJoy3        = 205;
  static const int kJoy4        = 206;

  static const int kLTrigger    = kJoy1;
  static const int kRTrigger    = kJoy2;

  // Аналоги для Game Pad раскладки
  static const int kAButton     = 207; // K_AUX1
  static const int kBButton     = 208; // K_AUX2
  static const int kXButton     = 209; // K_AUX3
  static const int kYButton     = 210; // K_AUX4
  static const int kL1Button    = 211; // K_AUX5
  static const int kR1Button    = 212; // K_AUX6
  static const int kBackButton  = 213; // K_AUX7
  static const int kModeButton  = 214; // K_AUX8
  static const int kStartButton = 215; // K_AUX9
  static const int kLStick      = 216; // K_AUX10
  static const int kRStick      = 217; // K_AUX11
  static const int kL2Button    = 218; // K_AUX12
  static const int kR2Button    = 219; // K_AUX13
  static const int kCButton     = 220; // K_AUX14
  static const int kZButton     = 221; // K_AUX15
  static const int kDpadUp      = 222; // K_AUX16
  static const int kDpadDown    = 223; // K_AUX17
  static const int kDpadLeft    = 224; // K_AUX18
  static const int kDpadRight   = 225; // K_AUX19
  static const int kMiscButton  = 226; // K_AUX20
  static const int kPaddle1Button = 227; // K_AUX21
  static const int kPaddle2Button = 228; // K_AUX22
  static const int kPaddle3Button = 229; // K_AUX23
  static const int kPaddle4Button = 230; // K_AUX24
  static const int kTouchpad    = 231; // K_AUX25
}
