extends Skeleton3D

@onready var left_ik = $LeftIK
@onready var right_ik = $RightIK

func _ready():
	left_ik.start()
	right_ik.start()
