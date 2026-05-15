import 'dart:ffi';

// Вспомогательные базовые структуры (vec3_t и edict_t)
class Vec3 extends Struct {
  @Float() external double x;
  @Float() external double y;
  @Float() external double z;
}

// Заглушка для edict_t, чтобы избежать циклической зависимости при компиляции
class EdictS extends Opaque {}

// === ГЛОБАЛЬНЫЕ ПЕРЕМЕННЫЕ КАДРА globalvars_t ===
class GlobalVars extends Struct {
  @Float() external double time;
  @Float() external double frametime;
  @Float() external double forceRetouch;
  
  @Int32() external int mapname;     // В GoldSrc string_t — это int (индекс в string table)
  @Int32() external int startspot;
  
  @Float() external double deathmatch;
  @Float() external double coop;
  @Float() external double teamplay;
  @Float() external double serverflags;
  @Float() external double foundSecrets;
  
  external Vec3 vForward;
  external Vec3 vUp;
  external Vec3 vRight;
  
  // Результаты встроенной трассировки лучей
  @Float() external double traceAllSolid;
  @Float() external double traceStartSolid;
  @Float() external double traceFraction;
  external Vec3 traceEndPos;
  external Vec3 tracePlaneNormal;
  @Float() external double tracePlaneDist;
  external Pointer<EdictS> traceEnt;
  @Float() external double traceInOpen;
  @Float() external double traceInWater;
  @Int32() external int traceHitgroup;
  @Int32() external int traceFlags;
  
  @Int32() external int changelevel;
  @Int32() external int cdAudioTrack;
  @Int32() external int maxClients;
  @Int32() external int maxEntities;
  
  external Pointer<Char> pStringBase;
  external Pointer<Void> pSaveData;
  external Vec3 vecLandmarkOffset;
}

// === КЛЮЧЕВЫЕ ПЕРЕМЕННЫЕ СУЩНОСТИ entvars_t ===
class EntVarsS extends Struct {
  @Int32() external int classname;   // string_t
  @Int32() external int globalname;

  // Физика перемещения (Подойдет для Physgun)
  external Vec3 origin;
  external Vec3 oldorigin;
  external Vec3 velocity;
  external Vec3 basevelocity;
  external Vec3 clbasevelocity;
  external Vec3 movedir;

  // Углы и вращение
  external Vec3 angles;
  external Vec3 avelocity;
  external Vec3 punchangle;
  external Vec3 vAngle;

  // Параметрические интерполяции
  external Vec3 endpos;
  external Vec3 startpos;
  @Float() external double impacttime;
  @Float() external double starttime;

  @Int32() external int fixangle;
  @Float() external double idealpitch;
  @Float() external double pitchSpeed;
  @Float() external double idealYaw;
  @Float() external double yawSpeed;

  @Int32() external int modelindex;
  @Int32() external int model;       // string_t
  @Int32() external int viewmodel;
  @Int32() external int weaponmodel;

  // Хитбоксы / Ограничивающие рамки (AABB Bounding Boxes)
  external Vec3 absmin;
  external Vec3 absmax;
  external Vec3 mins;
  external Vec3 maxs;
  external Vec3 size;

  @Float() external double ltime;
  @Float() external double nextthink;

  @Int32() external int movetype;
  @Int32() external int solid;

  @Int32() external int skin;
  @Int32() external int body;
  @Int32() external int effects;
  @Float() external double gravity;
  @Float() external double friction;

  @Int32() external int lightLevel;

  // Анимационный конвейер студийных моделей беты HL2
  @Int32() external int sequence;
  @Int32() external int gaitsequence;
  @Float() external double frame;
  @Float() external double animtime;
  @Float() external double framerate;
  @Array(4) external Array<Uint8> controller;
  @Array(2) external Array<Uint8> blending;

  // Рендеринг и прозрачность
  @Float() external double scale;
  @Int32() external int rendermode;
  @Float() external double renderamt;
  external Vec3 rendercolor;
  @Int32() external int renderfx;

  // Геймплейные атрибуты (Здоровье, урон)
  @Float() external double health;
  @Float() external double frags;
  @Int32() external int weapons;
  @Float() external double takedamage;

  @Int32() external int deadflag;
  external Vec3 viewOfs;

  @Int32() external int button;
  @Int32() external int impulse;

  // Связи сущностей (Цепочки графа сцены)
  external Pointer<EdictS> chain;
  external Pointer<EdictS> dmgInflictor;
  external Pointer<EdictS> enemy;
  external Pointer<EdictS> aiment;
  external Pointer<EdictS> owner;
  external Pointer<EdictS> groundentity;

  @Int32() external int spawnflags;
  @Int32() external int flags;

  @Int32() external int colormap;
  @Int32() external int team;

  @Float() external double maxHealth;
  @Float() external double teleportTime;
  @Float() external double armortype;
  @Float() external double armorvalue;
  @Int32() external int waterlevel;
  @Int32() external int watertype;

  @Int32() external int target;       // string_t
  @Int32() external int targetname;
  @Int32() external int netname;
  @Int32() external int message;

  @Float() external double dmgTake;
  @Float() external double dmgSave;
  @Float() external double dmg;
  @Float() external double dmgtime;

  @Int32() external int noise;        // string_t
  @Int32() external int noise1;
  @Int32() external int noise2;
  @Int32() external int noise3;

  @Float() external double speed;
  @Float() external double airFinished;
  @Float() external double painFinished;
  @Float() external double radsuitFinished;

  external Pointer<EdictS> pContainingEntity;

  @Int32() external int playerclass;
  @Float() external double maxspeed;

  @Float() external double fov;
  @Int32() external int weaponanim;

  @Int32() external int pushmsec;

  // Переменные передвижения игрока (Физика перемещения / Передаются во Flutter)
  @Int32() external int bInDuck;
  @Int32() external int flTimeStepSound;
  @Int32() external int flSwimTime;
  @Int32() external int flDuckTime;
  @Int32() external int iStepLeft;
  @Float() external double flFallVelocity;

  @Int32() external int gamestate;
  @Int32() external int oldbuttons;
  @Int32() external int groupinfo;

  // Кастомные переменные для ваших модов / Логика "Гарри Поттера"
  @Int32() external int iuser1;
  @Int32() external int iuser2;
  @Int32() external int iuser3;
  @Int32() external int iuser4;
  @Float() external double fuser1;
  @Float() external double fuser2;
  @Float() external double fuser3;
  @Float() external double fuser4;
  external Vec3 vuser1;
  external Vec3 vuser2;
  external Vec3 vuser3;
  external Vec3 vuser4;
  external Pointer<EdictS> euser1;
  external Pointer<EdictS> euser2;
  external Pointer<EdictS> euser3;
  external Pointer<EdictS> euser4;
}
