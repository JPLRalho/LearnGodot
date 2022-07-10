extends MeshInstance


export var gridWidth: int = 1
export var gridHeight: int = 2
export var noiseScale: float = 0
export var heightScale: float = 1
export var offsetX: float = 0
export var offsetZ: float = 0

export var noise: OpenSimplexNoise


func _ready() -> void:
	self.noiseInit()
	
	
func _process(_delta) -> void:
	var vertices = PoolVector3Array()
	var normals = PoolVector3Array()
	var indices = PoolIntArray()
	var uvs = PoolVector2Array()

	var arrayMesh = ArrayMesh.new()
	var arrays = []
	
	#vertices
	for z in self.gridHeight+1:
		for x in self.gridWidth+1:
			var vert = Vector3(x, self.generateNoiseImage(x, z) * self.heightScale, z)
			vertices.append(vert)
			normals.append(vert.normalized())
			uvs.append(Vector2(x,z))

			
	#triangles
	for z in self.gridHeight:
		for x in self.gridWidth:
			indices.append((self.gridWidth + 1) * z + x + (self.gridWidth + 2))
			indices.append((self.gridWidth + 1) * z + x + (self.gridWidth + 1))
			indices.append((self.gridWidth + 1) * z + x)
			indices.append((self.gridWidth + 1) * z + x + 1)
			indices.append((self.gridWidth + 1) * z + x + (self.gridWidth + 2))
			indices.append((self.gridWidth + 1) * z + x)
			
			

	#print('indices ', indices)
	#print('vertices ', vertices)
	
	arrays.resize(ArrayMesh.ARRAY_MAX)
	arrays[ArrayMesh.ARRAY_VERTEX] = vertices
	arrays[ArrayMesh.ARRAY_INDEX] = indices
	arrays[ArrayMesh.ARRAY_NORMAL] = normals
	arrays[ArrayMesh.ARRAY_TEX_UV] = uvs
	
	# Create the Mesh.
	arrayMesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)
	mesh = arrayMesh
	
	#self.playAnimation()


func noiseInit() -> void:
	self.noise = OpenSimplexNoise.new()
	self.noise.seed = randi()
	
	# Configure
	self.noise.octaves = 3
	self.noise.period = 16
	self.noise.persistence = 0.5
	self.noise.lacunarity = 2

func generateNoiseImage(x: int, z: int) -> float:
	
	var scaledX = float(x) / float(self.gridWidth+1) * self.noiseScale + self.offsetX
	var scaledZ = float(z) / float(self.gridHeight+1) * self.noiseScale + self.offsetZ
	
	var finalValue = (self.noise.get_noise_2d(scaledX, scaledZ)+1.0)/2.0
	
	return finalValue


func playAnimation() -> void:
	self.offsetX += 0.5


#handling signals
func onGridWithValueChange(newValue: int) -> void:
	self.gridWidth = newValue

func onGridHeigthValueChange(newValue: int) -> void:
	self.gridHeight = newValue

func onScaleValueChange(newValue: float) -> void:
	self.noiseScale = newValue

func onHeigthScaleValueChange(newValue: float) -> void:
	self.heightScale = newValue
	
func onOffsetXValueChange(newValue: float) -> void:
	self.offsetX = newValue
	
func onOffsetZValueChange(newValue: float) -> void:
	self.offsetZ = newValue


