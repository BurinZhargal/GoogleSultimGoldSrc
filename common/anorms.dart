// Вместо старого trivertex_t с 1 байтом под нормаль
class ModernVertex {
  double x;
  double y;
  double z;
  Vec3 normal; // Считаем нормальный честный вектор направления света
}
