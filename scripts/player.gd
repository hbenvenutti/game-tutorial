extends KinematicBody2D

# *** ---- Constants ------------------------------------------------------------------------ *** //
const acceleration: int = 30;
const maxSpeed: int = 80;
const friction: int = 80;
const walkSpeed: int = 50;
const runningSpeed: int = 80;

# *** ---- Variables ------------------------------------------------------------------------ *** //
var isRunning: bool = false;
var isIdle: bool = true;
var speed: int = walkSpeed;
var motion: Vector2 = Vector2();

# *** ---- Physics -------------------------------------------------------------------------- *** //
func _physics_process(delta) -> void:
  var direction: Vector2;
  animate();

  run();
  direction = getDirection();
  movePlayer(direction, delta);

  var _ok = move_and_collide(motion);
  
  return;
  
# *** ---- Functions ------------------------------------------------------------------------ *** //
func getDirection() -> Vector2:
  var direction: Vector2 = Vector2();

  # ? ---- Pega a intensidade em que o input é precionado (Controller stick)
  direction.x = Input.get_action_strength('ui_right') - Input.get_action_strength('ui_left');
  direction.y = Input.get_action_strength('ui_down') - Input.get_action_strength('ui_up');
  direction = direction.normalized();
  
  return direction;

# ------------------------------------------------------------------------------------------------ #
func run():
  # ? ---- Ativa a corrida --------------------------------------------------------------------- ? #
  if Input.is_action_just_pressed('run'):
    isRunning = true;
    speed = runningSpeed;
  
  if Input.is_action_just_released('run'):
    isRunning = false;
    speed = walkSpeed;
  
  return;

# ------------------------------------------------------------------------------------------------ #
func movePlayer(direction: Vector2, delta: float) -> void:
  # ? ---- Movendo ----------------------------------------------------------------------------- ? #
  if direction != Vector2.ZERO:
    isIdle = false;
    motion += direction * acceleration * delta;
    motion = motion.limit_length(speed * delta);
    # // motion = motion.clamped(speed * delta);  Deprecated

    return;

  # ? ---- Parou de mover ---------------------------------------------------------------------- ? #
  slideAndStop(delta);

  return ;
    
# ------------------------------------------------------------------------------------------------ #

func slideAndStop(delta: float) -> void:
  # ? ---- Desliza o personagem ao parar de mover ---------------------------------------------- ? #
  motion = motion.move_toward(Vector2.ZERO, friction * delta);

  # ? ---- Indica que o personagem está parado ------------------------------------------------- ? #
  isIdle = true;
  
  return 

# ------------------------------------------------------------------------------------------------ #
func animate() -> void:
  # ? ---- Parado ------------------------------------------------------------------------------ ? #
  if isIdle:
    $AnimatedSprite.play("idle");
    
    return;

  # ? ---- Correndo ou Caminhando -------------------------------------------------------------- ? #
  if isRunning:
    $AnimatedSprite.play("running");
  else:
    $AnimatedSprite.play("walking");
  
  # ? ---- Direção ----------------------------------------------------------------------------- ? #
  if motion.x > 0:
    $AnimatedSprite.flip_h = false
    return;
  
  if motion.x < 0:
    $AnimatedSprite.flip_h = true
    return;
  
  return;

