import 'dart:ffi';

// === ФЛАГИ ЗАТЕМНЕНИЯ ЭКРАНА (#define FFADE_...) ===
abstract class FadeFlags {
  static const int ffadeIn       = 0x0000; // Плавное проявление кадра
  static const int ffadeOut      = 0x0001; // Плавное увядание в цвет (экран чернеет)
  static const int ffadeModulate  = 0x0002; // Модуляция цвета (умножение вместо блендинга)
  static const int ffadeStayout   = 0x0004; // Игнорировать таймер, оставаться в цвете до новой команды
  static const int ffadeLongfade  = 0x0008; // Поддержка длинных фейдов > 16 секунд (из Condition Zero)
}

// === СТРУКТУРА ТРЯСКИ ЭКРАНА ScreenShake ===
class ScreenShakeStruct extends Struct {
  @Uint16()
  external int amplitude; // FIXED 4.12: Сила тряски
  
  @Uint16()
  external int duration;  // FIXED 4.12: Длительность эффекта в секундах
  
  @Uint16()
  external int frequency; // FIXED 8.8: Частота шума (низкая — резкие толчки, высокая — дрожь)
}

// === СТРУКТУРА ЗАТЕМНЕНИЯ ЭКРАНА ScreenFade ===
class ScreenFadeStruct extends Struct {
  @Uint16()
  external int duration;  // FIXED 4.12: Длительность ухода в цвет
  
  @Uint16()
  external int holdTime;  // FIXED 4.12: Сколько удерживать экран в финальном цвете
  
  @Int16()
  external int fadeFlags; // Битовые флаги из класса FadeFlags
  
  // Цвет вспышки/затемнения (RGBA)
  @Uint8() external int r;
  @Uint8() external int g;
  @Uint8() external int b;
  @Uint8() external int a; // Максимальная прозрачность эффекта
}

// === РАСПАКОВЩИК ФИКСИРОВАННОЙ ЗАПЯТОЙ ДЛЯ DART ЛОГИКИ ===
extension ScreenShakeUnpacker on ScreenShakeStruct {
  /// Переводит амплитуду из FIXED 4.12 в нормальный double
  double get realAmplitude => amplitude / 4096.0;
  
  /// Переводит длительность из FIXED 4.12 в секунды double
  double get realDuration => duration / 4096.0;
  
  /// Переводит частоту из FIXED 8.8 в герцы double
  double get realFrequency => frequency / 256.0;
}

extension ScreenFadeUnpacker on ScreenFadeStruct {
  double get realDuration => duration / 4096.0;
  double get realHoldTime => holdTime / 4096.0;
}
