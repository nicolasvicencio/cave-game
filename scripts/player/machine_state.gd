class_name StateMachine extends Node

@export var initial_state : State = null

@onready var state : State = (func get_initial_state() -> State: return initial_state if initial_state != null else get_child(0)).call()

func _ready() -> void:
	for state_node in find_children("*", "State"):
		state_node.finished.connect(_transition_to_next_state)
		
	await owner.ready
	state.enter("")

func _unhandled_input(event: InputEvent) -> void:
	state.handle_input(event)

func _process(delta: float) -> void:
	state.update(delta)

func _physics_process(delta: float) -> void:
	print(state)
	state.physics_update(delta)
	
func _transition_to_next_state(target_state_path: String, data: Dictionary = {}) -> void:
	if !has_node(target_state_path):
		printt(target_state_path + 'doesnt exists')
	var previous_state = state.name
	state.exit()
	state = get_node(target_state_path)
	state.enter(previous_state, data)
	
	
