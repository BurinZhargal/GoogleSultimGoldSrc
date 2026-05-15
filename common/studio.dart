import 'dart:ffi';

// Сигнатуры и версии формата
const int STUDIO_VERSION = 10;
const int IDSTUDIOHEADER = 0x54534449; // "IDST" в Little-Endian
const int IDSEQGRPHEADER = 0x51534449; // "IDSQ" в Little-Endian

// Хардкверные и спецификационные лимиты студийных моделей
abstract class StudioLimits {
  static const int maxStudioVerts       = 16384; // Макс вершин на сабмодель
  static const int maxStudioSequences   = 256;   // Макс анимационных треков
  static const int maxStudioSkins       = 256;   // Макс текстур внутри MDL
  static const int maxStudioBones       = 128;   // Макс костей скелета
  static const int maxStudioModels      = 32;    // Подмодели (обвес, бодигруппы)
  static const int maxStudioAttachments = 64;    // Точки крепления (дуло пушки, руки)
  static const int maxStudioBoneWeights = 4;     // Аппаратный лимит весов на вершину
}

// Рендер-флаги материалов текстур (STUDIO_NF_...)
abstract class StudioTextureFlags {
  static const int flatShade  = 0x0001;
  static const int chrome     = 0x0002; // Эффект зеркального отражения (легендарный хром)
  static const int fullBright = 0x0004; // Игнорировать освещение карты (свечение)
  static const int additive   = 0x0020; // Смешивание цветов (для магии и лазеров)
  static const int masked     = 0x0040; // Альфа-тест (решетки, листва, прозрачность)
  static const int normalMap  = 0x0080;
  static const int luma       = 0x0400; // Самовечение карт высот (Luma-текстуры)
}

// Флаги анимационных треков (STUDIO_LOOPING...)
abstract class StudioSequenceFlags {
  static const int looping   = 0x0001; // Зацикленная анимация (бег, покой)
  static const int snap      = 0x0002; // Мгновенное переключение без интерполяции костей
  static const int delta     = 0x0004; // Аддитивная анимация (наложение поверх базовой)
  static const int realTime  = 0x0100; // Синхронизация времени по системным часам
}

// Базовый тип трехмерного вектора (vec3_t)
class Vec3 extends Struct {
  @Float() external double x;
  @Float() external double y;
  @Float() external double z;
}

// Главный заголовок файла модели -> studiohdr_t
class StudioHdr extends Struct {
  @Int32() external int ident;              // Сигнатура IDSTUDIOHEADER ("IDST")
  @Int32() external int version;            // Версия формата (10)
  
  @Array(64) external Array<Char> name;     // Внутреннее имя модели (.mdl)
  @Int32() external int length;            // Полный размер файла в байтах
  
  external Vec3 eyeposition;                // Координаты глаз (для ИИ взгляда и камеры)
  
  external Vec3 min;                        // Габариты физической коробки (Hull Box)
  external Vec3 max;
  
  external Vec3 bbmin;                      // Габариты коробки видимости (Bounding Box)
  external Vec3 bbmax;
  
  @Int32() external int flags;             // Глобальные флаги модели
  
  // Кости скелета
  @Int32() external int numBones;
  @Int32() external int boneIndex;          // Смещение (offset) до массива StudioBone структур
  
  // Контроллеры костей (повороты головы, кости рта)
  @Int32() external int numBoneControllers;
  @Int32() external int boneControllerIndex;
  
  // Хитбоксы (Коробки попадания пуль/заклинаний)
  @Int32() external int numHitboxes;
  @Int32() external int hitboxindex;
  
  // Анимации (Sequences)
  @Int32() external int numSeq;
  @Int32() external int seqIndex;           // Смещение до массива описаний анимаций
  
  // Группы анимаций (внешние файлы типа пистолета/моделей Барни)
  @Int32() external int numSeqGroups;
  @Int32() external int seqGroupIndex;
  
  // Текстуры, вшитые в модель
  @Int32() external int numTextures;
  @Int32() external int textureIndex;       // Смещение до заголовков текстур
  @Int32() external int textureDataIndex;   // Смещение до сырых пикселей текстур
  
  // Скины (Семьи сменных текстур, например, лица или грязь)
  @Int32() external int numSkinRef;
  @Int32() external int numSkinFamilies;
}
