extends KinematicBody2D

# *** ---- Constants ------------------------------------------------------------------------ *** //
const acceleration: int = 30;
const maxSpeed: int = 80;
const friction: int = 80;
const walkSpeed: int = 50;
const runningSpeed: int = 80;

# *** ---- Variables ------------------------------------------------------------------------ *** //
var isRunning: bool = false;
var speed: int = walkSpeed;
var motion: Vector2 = Vector2();


# *** ---- Fisics --------------------------------------------------------------------------- *** //
func _physics_process(delta) -> void:
  var direction: Vector2;

  run();
  direction = getDirection();
  movePlayer(direction, delta);
  animate();

  move_and_collide(motion);
  
  return;
  
# *** ---- Functions ------------------------------------------------------------------------ *** //
func getDirection() -> Vector2:
  var direction: Vector2 = Vector2();

  # Pega a intensidade em que o input é precionado (Controller stick)
  direction.x = Input.get_action_strength('ui_right') - Input.get_action_strength('ui_left');
  direction.y = Input.get_action_strength('ui_down') - Input.get_action_strength('ui_up');
  direction = direction.normalized();
  
  return direction;

# ------------------------------------------------------------------------------------------------ #
func run():
  if Input.is_action_just_pressed('run'):
    isRunning = true;
    speed = runningSpeed;
  
  if Input.is_action_just_released('run'):
    isRunning = false;
    speed = walkSpeed;
  
  return;

# ------------------------------------------------------------------------------------------------ #
func movePlayer(direction: Vector2, delta: float) -> void:
  if direction != Vector2.ZERO:

    motion += direction * acceleration * delta;
    print(motion);
    motion = motion.limit_length(speed * delta);
    # motion = motion.clamped(speed * delta); # Deprecated

    return;
  
  slide(delta);

  return ;
    
# ------------------------------------------------------------------------------------------------ #

func slide(delta: float) -> void:
  $AnimatedSprite.play("idle");
  motion = motion.move_toward(Vector2.ZERO, friction * delta);
  
  return 

# ------------------------------------------------------------------------------------------------ #
func animate() -> void:
  if isRunning:
    $AnimatedSprite.play("running");
  else:
    $AnimatedSprite.play("walking");

  if motion.x > 0:
    $AnimatedSprite.flip_h = false
    return;
  
  if motion.x < 0:
    $AnimatedSprite.flip_h = true
    return;
  
  return;

