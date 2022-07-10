extends DirectionalLight


var rotationSpeed: float = 0.5


func _process(delta):
	self.rotate_x(delta * self.rotationSpeed)
