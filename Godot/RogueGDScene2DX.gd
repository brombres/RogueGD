class_name RogueGDScene2DX
extends Node3D

## Optional Camera3D. If no camera is linked then RogueGD will create a 3D camera at runtime.
@export var camera:Camera3D

## Smaller nominal_z values exaggerate the effects of rotating into or moving along the Z axis
## while larger nominal_z values reduce the apparent depth of the 3D effect.
@export var nominal_z:float = 2000

# The far clipping plane. Note that the near clipping plane is fixed at 1.
var z_far = 4000

func _ready():
	var assets = $Assets
	if assets: assets.visible = false

	if not camera:
		camera = Camera3D.new()
		add_child( camera )

	get_viewport().connect( "size_changed", _on_viewport_size_changed )
	_on_viewport_size_changed()

	RogueGD.on_new_scene_2dx( nominal_z )

func _on_viewport_size_changed():
	var display_size = get_viewport().get_visible_rect().size

	var k = (nominal_z + 1)
	var size = display_size.y / k
	camera.set_frustum( size, Vector2(), 1, z_far )

	set_position( Vector3(-display_size.x/2, display_size.y/2, 0) )
	#set_position( Vector3(-display_size.x/2, display_size.y/2, -nominal_z) )
	#set_position( Vector3(0, 0, -nominal_z) )
