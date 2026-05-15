// === BEAM TYPES (enum из customentity.h) ===
abstract class BeamType {
  static const int beamPoints   = 0; // Луч между двумя фиксированными точками XYZ
  static const int beamEntPoint = 1; // Луч от объекта (например, пушки) к точке XYZ
  static const int beamEnts     = 2; // Луч, связывающий два динамических объекта
  static const int beamHose     = 3; // Поток (шланг) частиц/лучей
}

// === BEAM FLAGS (#define из customentity.h) ===
abstract class BeamFlags {
  static const int beamFSine     = 0x10; // Синусоидальное искажение (луч изгибается/трясется)
  static const int beamFSolid    = 0x20; // Сплошной монолитный луч без прозрачности
  static const int beamFShadeIn  = 0x40; // Плавное появление (альфа-затухание у начала)
  static const int beamFShadeOut = 0x80; // Плавное исчезновение (альфа-затухание у конца)
}

// === BIT-MASK UTILITIES (Аналоги макросов BEAMENT) ===
class BeamEntityDecoder {
  /// Вытаскивает чистый ID объекта (Entity Index) из упакованного 16-битного значения
  static int getEntityIndex(int packedValue) {
    return packedValue & 0xFFF; // Маска 12 бит (0-4095 объектов)
  }

  /// Вытаскивает индекс точки крепления луча (Attachment ID, например, дуло пушки)
  static int getAttachmentIndex(int packedValue) {
    return (packedValue >> 12) & 0xF; // Сдвиг на 12 бит и маска 4 бита (0-15 точек)
  }

  /// Упаковывает ID объекта и точку крепления в единое число для отправки в рендерер GoldSrc
  static int packBeamEntity(int entityIndex, int attachmentIndex) {
    return (entityIndex & 0xFFF) | ((attachmentIndex & 0xF) << 12);
  }
}
