@tool
extends MeshInstance3D

@onready var viewport = $SubViewport

func update_display():
	var image = viewport.get_texture().get_image()
	var texture = ImageTexture.create_from_image(image)
	var material = get_surface_override_material(0)
	material.albedo_texture = texture
	set_surface_override_material(0, material)
	
#func _process(delta):
	#update_display()
