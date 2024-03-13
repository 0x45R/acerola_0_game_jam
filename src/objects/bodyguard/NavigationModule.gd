extends BaseModule

@export var walk_speed = 3.5
@export var run_speed = 7
@onready var navigation_agent = $NavigationAgent3D

var started = false

var player
var target

func _ready():
	var scene = get_tree().current_scene
	player = scene.get_node("Player")
	target = scene.get_node("%DoorMarker")
	
func _target_reached():
	entity.queue_free()
	
func start_navigation():
	navigation_agent.target_reached.connect(_target_reached)
	started = true
	
func _physics_process(delta):
	if not started:
		return
	var self_movement_module = get_module_root().get_node("Movement")
	var direction = Vector3(0,0,0)
	entity.remote_input_vector = Vector2(0,0)
	entity.remote_direction	= direction
	navigation_agent.target_position = target.global_position

	var next_position = navigation_agent.get_next_path_position()
	entity.look_at(next_position*Vector3(1,0,1))

	if entity.global_position.distance_to(target.global_position) < 2.0:
		return	

	direction =  next_position - entity.global_position
	direction = direction.normalized()
	direction.y = 0
	var movement_module = player.get_node("Modules").get_node("Movement")
	var speed = walk_speed

	if target == player:
		entity.get_node("Modules/Mesh").rotation_degrees.y = -180
	else:
		entity.get_node("Modules/Mesh").rotation_degrees.y = -180
	if target == player:
		get_module_root().get_node("Movement").state = movement_module.STATE.Walking
	#if movement_module.state == movement_module.STATE.Running and target == player:
	#	speed = run_speed
		
	entity.remote_input_vector = Vector2(0,-1)
	entity.remote_direction	= direction*speed
