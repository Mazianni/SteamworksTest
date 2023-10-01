extends Node

var url_data : String


# Called when the node enters the scene tree for the first time.
func _ready():
	Steam.steamInit()
	Steam.htmlInit()
	await get_tree().create_timer(2).timeout
	Steam.createBrowser("","")
	Steam.html_start_request.connect(Callable(self, "allow"))
	Steam.html_needs_paint.connect(Callable(self, "paint"))
	Steam.html_new_window.connect(Callable(self, "newwindow"))
	await get_tree().create_timer(2).timeout
	Steam.setSize(50, 50)
	Steam.loadURL("google.com", "")
	
func newwindow(one, two):
	print(one, two)
	
func paint(one, two):
	print(two)
	var thing : PackedByteArray = var_to_bytes(two["bgra"])
	var img : Image = Image.new()
	var img_txt : ImageTexture = ImageTexture.new()
	img = img.create_from_data(two["scroll_x"], two["scroll_y"], false, Image.FORMAT_RGBA8, thing)
	img_txt = img_txt.create_from_image(img)
	$ColorRect.texture = img_txt
	
func allow(one, two, three, four, five):
	Steam.allowStartRequest(true)

func _process(delta):

	Steam.run_callbacks()

	
