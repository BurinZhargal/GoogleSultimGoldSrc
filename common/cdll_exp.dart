import 'dart:ffi';

// Заглушки для типов данных движка (кастуются как Opaque или Pointer<Void>)
class ClientEngineFunc extends Opaque {}
class ClientData extends Opaque {}
class PlayerMove extends Opaque {}
class UserCmd extends Opaque {}
class RefParams extends Opaque {}
class ClEntity extends Opaque {}
class MStudioEvent extends Opaque {}
class LocalState extends Opaque {}
class EntityState extends Opaque {}
class ClientDataOld extends Opaque {}
class WeaponData extends Opaque {}
class NetAdr extends Opaque {}
class TempEnt extends Opaque {}
class RenderApi extends Opaque {}
class RenderInterface extends Opaque {}
class PhysEnt extends Opaque {}
class PmTrace extends Opaque {}
class SoundApi extends Opaque {}
class SoundInterface extends Opaque {}

// Сигнатуры функций для Dart FFI
typedef InitializeNative = Int32 Function(Pointer<ClientEngineFunc> pEnginefuncs, Int32 iVersion);
typedef InitNative = Void Function();
typedef VidInitNative = Int32 Function();
typedef RedrawNative = Int32 Function(Float flTime, Int32 intermission);
typedef UpdateClientDataNative = Int32 Function(Pointer<ClientData> cdata, Float flTime);
typedef ResetNative = Void Function();
typedef PlayerMoveNative = Void Function(Pointer<PlayerMove> ppmove, Int32 server);
typedef PlayerMoveInitNative = Void Function(Pointer<PlayerMove> ppmove);
typedef CreateMoveNative = Void Function(Float frametime, Pointer<UserCmd> cmd, Int32 active);
typedef IsThirdPersonNative = Int32 Function();
typedef CalcRefdefNative = Void Function(Pointer<RefParams> pparams);
typedef AddEntityNative = Int32 Function(Int32 type, Pointer<ClEntity> ent, Pointer<Char> modelname);
typedef CreateEntitiesNative = Void Function();
typedef StudioEventNative = Void Function(Pointer<MStudioEvent> event, Pointer<ClEntity> entity);
typedef ShutdownNative = Void Function();
typedef FrameNative = Void Function(Double time);
typedef KeyEventNative = Int32 Function(Int32 eventcode, Int32 keynum, Pointer<Char> pszCurrentBinding);

// Xash3D & FWGS Extensions
typedef TouchEventNative = Int32 Function(Int32 type, Int32 fingerID, Float x, Float y, Float dx, Float dy);
typedef MoveEventNative = Void Function(Float forwardmove, Float sidemove);
typedef LookEventNative = Void Function(Float relyaw, Float relpitch);
