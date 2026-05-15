import 'dart:ffi';
import 'progdefs_structs.dart'; // Предполагаем наличие транслированного progdefs.h

// Константы лимитов листьев BSP-дерева для коллизий
const int MAX_ENT_LEAFS_32 = 24;
const int MAX_ENT_LEAFS_16 = 48;

// Вспомогательная структура для связывания узлов (link_t из const.h)
class LinkS extends Struct {
  external Pointer<LinkS> prev;
  external Pointer<LinkS> next;
}

// Объединение (union) листьев BSP-дерева в Dart реализуется через наложение полей
class LeafNumsUnion extends Struct {
  // Вариант 1: leafnums32 [24 * 4 байта = 96 байт]
  @Array(MAX_ENT_LEAFS_32)
  external Array<Int32> leafnums32;

  // Вариант 2: leafnums16 [48 * 2 байта = 96 байт]
  // В Dart FFI для наложения полей мы просто читаем ту же память с другим типом через расширения
}

// Основная структура edict_t
class EdictS extends Struct {
  @Int32()
  external int free;               // qboolean (int): свободен ли слот сущности

  @Int32()
  external int serialnumber;       // Порядковый номер для валидации указателей

  external LinkS area;             // Привязка к ноде деления мира (BSP leaf)

  @Int32()
  external int headnode;           // Индекс головной ноды коллизий

  @Int32()
  external int numLeafs;           // Количество листьев, которые пересекает объект

  // Вложенное объединение (размер строго 96 байт)
  external LeafNumsUnion leafs;

  @Float()
  external double freetime;        // Время удаления сущности из игрового мира

  external Pointer<Void> pvPrivateData; // Указатель на приватную C++ память логики

  // Переменные сущности (entvars_t из progdefs.h) — физика, углы, модель
  external EntVarsS v; 
}
