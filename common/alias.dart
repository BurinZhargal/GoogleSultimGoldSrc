// Инициализация чистого homebrew окна через SDL2 в Dart
final sdl = SDL2(libPath: 'sdl2.dll');
sdl.init(SDL_INIT_VIDEO | SDL_INIT_AUDIO);

final window = sdl.createWindow("HP Homebrew: Edition X", 800, 600);
final renderer = sdl.createRenderer(window);
