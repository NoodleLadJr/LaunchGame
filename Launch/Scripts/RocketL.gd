extends Sprite


# Declare member variables here. Examples:
var RocketPos = Vector2(0,0)
onready var LaunchRoot = get_parent();
export var Radius = 300
var HasLaunched = false
signal Launched


# Called when the node enters the scene tree for the first time.
func _ready():
	LaunchRoot.set("position",Vector2(0,get_viewport_rect().size.y))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !HasLaunched:
		RocketPos = get_global_mouse_position();
		RocketPos = RocketPos - LaunchRoot.get("position")
		set("position",FindPosition(RocketPos))
		if Input.is_action_pressed("Launch"):
			HasLaunched = false;
			emit_signal("Launched")
	return


func FindPosition(RocketPos):
	var NewCoords = null;
	NewCoords = cartesian2polar(RocketPos.x,RocketPos.y)
	print(NewCoords)
	NewCoords.x = clamp(NewCoords.x,75,Radius)
	NewCoords.y = clamp(NewCoords.y,-1.5,-.2)
	NewCoords = polar2cartesian(NewCoords.x,NewCoords.y)
	#theta can be used to calculate the forward vector for the motion
	#R can be used for x for the spring force.
	return NewCoords;