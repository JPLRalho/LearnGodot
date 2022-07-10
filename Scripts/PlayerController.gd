extends KinematicBody


export var movementSpeed: float = 50
export var minAngle: float = -90.0
export var maxAngle: float = 90.0
export var cameraRotationSpeed: float = 20.0

var mouseMovement: Vector2 = Vector2()
var cantTrackMouse: bool = false


func _input(event):
	if event is InputEventMouseMotion:
		self.mouseMovement = event.relative


func _physics_process(delta: float) -> void:
	self.movementLogic()
	self.cameraLogic(delta)


func movementLogic() -> void:

	var movementVector: Vector3 = Vector3()
	var movement: Vector3 = Vector3()
	
	#Get input
	if Input.is_action_pressed("move_right"):
		movementVector.x = -1
	elif Input.is_action_pressed("move_left"):
		movementVector.x = 1
		
	if Input.is_action_pressed("move_up"):
		movementVector.z = 1
	elif Input.is_action_pressed("move_down"):
		movementVector.z = -1
		
	if Input.is_action_pressed("fly_up"):
		movementVector.y = 1
	elif Input.is_action_pressed("fly_down"):
		movementVector.y = -1
		
	if Input.is_action_pressed("mouse_right_click"):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		self.cantTrackMouse = true
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		self.cantTrackMouse = false
		
	#if two keys are pressed, normalize the vector to not increase speed
	movementVector = movementVector.normalized()
	
	#get object current vectors
	var forward = global_transform.basis.z
	var right = global_transform.basis.x
	var up = global_transform.basis.y
	var movementDirection = forward * movementVector.z + right * movementVector.x + up * movementVector.y
	
	movement = movementDirection * self.movementSpeed
	movement = self.move_and_slide(movement, Vector3.UP)


func cameraLogic(delta: float) -> void:
	if self.cantTrackMouse:
		self.rotation_degrees.x += self.mouseMovement.y * self.cameraRotationSpeed * delta
		self.rotation_degrees.x = clamp(self.rotation_degrees.x, self.minAngle, self.maxAngle)
		
		self.rotation_degrees.y -= self.mouseMovement.x * self.cameraRotationSpeed * delta
		self.mouseMovement = Vector2()
