@tool
extends Control

@onready var file_tree: Tree = %FileList
@onready var commit_message: TextEdit = %CommitMessage
@onready var status_log: RichTextLabel = %Status

var git_executable = "git"
var repo_path = ""

func _ready():
	repo_path = ProjectSettings.globalize_path("res://")
	refresh_status()
	
	# Connect buttons
	%FetchChanges.pressed.connect(refresh_status)
	%Commit.pressed.connect(_on_commit_pressed)
	%Pull.pressed.connect(_on_pull_pressed)
	%Push.pressed.connect(_on_push_pressed)

func execute_git_command(args: Array) -> Dictionary:
	var output = []
	var exit_code = OS.execute(git_executable, args, output, true, false)
	
	return {
		"exit_code": exit_code,
		"output": "\n".join(output)
	}

func refresh_status():
	var result = execute_git_command(["status", "--porcelain"])
	
	if result.exit_code != 0:
		status_log.text = "Error: Not a git repository or git not found"
		return
	
	# Parse and display changes
	file_tree.clear()
	var root = file_tree.create_item()
	
	for line in result.output.split("\n"):
		if line.strip_edges() == "":
			continue
		
		var status = line.substr(0, 2)
		var file = line.substr(3)
		
		var item = file_tree.create_item(root)
		item.set_text(0, get_status_icon(status) + " " + file)
		item.set_metadata(0, {"file": file, "status": status})
	
	# Update status log
	var branch_result = execute_git_command(["branch", "--show-current"])
	status_log.text = "Branch: " + branch_result.output.strip_edges()

func get_status_icon(status: String) -> String:
	match status.strip_edges():
		"M", " M": return "[M]"
		"A", " A": return "[A]"
		"D", " D": return "[D]"
		"??": return "[?]"
		_: return "[*]"

func _on_commit_pressed():
	var message = commit_message.text.strip_edges()
	if message == "":
		status_log.text = "Error: Commit message cannot be empty"
		return
	
	# Stage all changes
	var stage_result = execute_git_command(["add", "-A"])
	if stage_result.exit_code != 0:
		status_log.text = "Error staging files:\n" + stage_result.output
		return
	
	# Commit
	var commit_result = execute_git_command(["commit", "-m", message])
	status_log.text = commit_result.output
	
	if commit_result.exit_code == 0:
		commit_message.text = ""
		refresh_status()

func _on_pull_pressed():
	status_log.text = "Pulling..."
	var result = execute_git_command(["pull"])
	status_log.text = result.output
	refresh_status()

func _on_push_pressed():
	status_log.text = "Pushing..."
	var result = execute_git_command(["push"])
	status_log.text = result.output
