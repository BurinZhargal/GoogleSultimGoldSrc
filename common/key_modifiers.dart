// Аналог key_modifier_t из key_modifiers.h
abstract class KeyModifiers {
  static const int none       = 0;
  static const int leftShift  = 1 << 0;  // 1
  static const int rightShift = 1 << 1;  // 2
  static const int leftCtrl   = 1 << 2;  // 4
  static const int rightCtrl  = 1 << 3;  // 8
  static const int leftAlt    = 1 << 4;  // 16
  static const int rightAlt   = 1 << 5;  // 32
  static const int leftSuper  = 1 << 6;  // 64  (Клавиша Win/Cmd)
  static const int rightSuper = 1 << 7;  // 128
  static const int numLock    = 1 << 8;  // 256
  static const int capsLock   = 1 << 9;  // 512
}
