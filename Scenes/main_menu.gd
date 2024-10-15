extends Control
class_name MainMenu

#Instancio los botones para poder usarlos
@onready var btn_play = $HBoxContainer/VBoxContainer2/BtnPlay as Button
@onready var btn_options = $HBoxContainer/VBoxContainer2/BtnOptions
@onready var btn_exit = $HBoxContainer/VBoxContainer2/BtnExit as Button
@onready var options_menu = $Options as OptionsMenu
@onready var HboxContent = $HBoxContainer as HBoxContainer

@onready var start = preload("res://Scenes/World/world.tscn")


#Cargo las funciones principales en mi menu
func _ready():
	handle_connecting_signals()

#Funcion para el boton play
func on_play_pressed() -> void:
	get_tree().change_scene_to_packed(start)

func on_options_pressed() -> void:
	HboxContent.visible = false
	options_menu.set_process(true)
	options_menu.visible = true	

#Funcion para el boton exit
func on_exit_pressed() -> void:
	get_tree().quit()
	
func on_exit_options_menu() -> void:
	HboxContent.visible = true
#	options_menu.visible = false

func handle_connecting_signals() -> void:
	btn_play.button_down.connect(on_play_pressed)
	btn_options.button_down.connect(on_options_pressed)
	btn_exit.button_down.connect(on_exit_pressed)
