
extends BaseModule

# I should probably name my blender objects
@onready var diode = $Sphere
@onready var screen = $Cube_001

@export var screen_enabled_texture: CompressedTexture2D
@export var screen_excel_texture: CompressedTexture2D
@export var screen_naughty_texture: CompressedTexture2D
@export var screen_disabled_texture: CompressedTexture2D

@export var enabled: bool: set = _set_enabled

func _ready():
	await get_tree().process_frame
	enabled = module.state != module.STATE.Sleeping

func _update_visuals():
	var diode_material = diode.get_surface_override_material(0)
	diode_material["emission"] = Color(0,1,0) if enabled else Color(1,0,0)
	diode_material["albedo_color"] = Color(0,1,0) if enabled else Color(1,0,0)
	var screen_material = screen.get_surface_override_material(0)
	if enabled:
		
		if module.state == module.STATE.Lazy:
			screen_material["albedo_texture"] = screen_enabled_texture
			screen_material["emission_texture"] = screen_enabled_texture

		if module.state == module.STATE.Naughty:
			screen_material["albedo_texture"] = screen_naughty_texture
			screen_material["emission_texture"] = screen_naughty_texture
		if module.state == module.STATE.Excel:
			screen_material["albedo_texture"] = screen_excel_texture
			screen_material["emission_texture"] = screen_excel_texture
		
	else:
		screen_material["albedo_texture"] = screen_disabled_texture
	
	screen_material["emission_enabled"] = enabled
	screen.set_surface_override_material(0, screen_material)
	diode.set_surface_override_material(0, diode_material)
	
func _set_enabled(value):
	enabled = value
	_update_visuals()
