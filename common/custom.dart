import 'dart:ffi';

// resourcetype_t (enum в C++ занимает 4 байта)
abstract class ResourceType {
  static const int tSound       = 0;
  static const int tSkin        = 1;
  static const int tModel       = 2;
  static const int tDecal       = 3;
  static const int tGeneric     = 4;
  static const int tEventScript = 5;
  static const int tWorld       = 6;
}

// Флаги ресурсов (#define RES_...)
const int RES_FATALIFMISSING = 1 << 0;
const int RES_WASMISSING     = 1 << 1;
const int RES_CUSTOM         = 1 << 2;
const int RES_REQUESTED      = 1 << 3;
const int RES_PRECACHED      = 1 << 4;
const int RES_ALWAYS         = 1 << 5;
const int RES_CHECKFILE      = 1 << 7;

// _resourceinfo_t и resourceinfo_t
class ResourceInfoElement extends Struct {
  @Int32()
  external int size;
}

class ResourceInfo extends Struct {
  @Array(8)
  external Array<ResourceInfoElement> info;
}

// resource_t -> Сверяем STATIC_CHECK_SIZEOF: 136 байт (32-bit) / 144 байта (64-bit)
class Resource extends Struct {
  @Array(64)
  external Array<Char> szFileName; // Имя файла для precache

  @Int32()
  external int type;               // Из перечисления ResourceType

  @Int32()
  external int nIndex;

  @Int32()
  external int nDownloadSize;

  @Uint8()
  external int ucFlags;

  @Array(16)
  external Array<Uint8> rgucMD5Hash; // Хэш для сверки на стороне Dart

  @Uint8()
  external int playerNum;

  @Array(32)
  external Array<Uint8> rgucReserved;

  @Uint16()
  external int ucExtraFlags;       // FWGS расширение

  external Pointer<Resource> pNext; // Указатель на следующий ресурс в цепочке
  external Pointer<Resource> pPrev; // Указатель на предыдущий ресурс
}

// customization_t -> Сверяем STATIC_CHECK_SIZEOF: 164 байта (32-bit) / 192 байта (64-bit)
class Customization extends Struct {
  @Int32()
  external int bInUse;             // В C++ qboolean — это int3

  external Resource resource;      // Вложенная структура resource_t

  @Int32()
  external int bTranslated;

  @Int32()
  external int nUserData1;

  @Int32()
  external int nUserData2;

  external Pointer<Void> pInfo;    // Сырые указатели под кэш
  external Pointer<Void> pBuffer;  // Указатель на буфер с данными в mcore

  external Pointer<Customization> pNext;
}
