@tool
extends  EditorImportPlugin

func _get_importer_name():
	return "anm"
	
func _get_visible_name():
	return "BFBB"
	
func _get_recognized_extensions():
	return ["anm"]
	
func _get_priority():
	return 1.0
	
func _get_import_order():
	return 0
	
func _get_save_extension():
	return "anim"
	
func _get_resource_type():
	return "Animation"

func _get_preset_count():
	return 1
	
func _get_preset_name(i):
	return "Default"
		
	

func _get_import_options(path: String, preset_index:int):
	return []
	
var boneid = -1

func _import(source_file, save_path, options, platform_variants, gen_files):
	var file = FileAccess.open(source_file, FileAccess.READ)
	var SKB := file.get_32()
	var flags := file.get_32()
	var boneCount := file.get_16()
	var frameCount := file.get_16()
	var keyframeCount := file.get_32()
	var ScaleX := file.get_float()
	var ScaleY := file.get_float()
	var ScaleZ := file.get_float()
	var Scales := Vector3(ScaleX,ScaleY,ScaleZ)
	for i in range(keyframeCount):
		var TimeIndex := file.get_16()
		var rotx := file.get_16() / 32767.0
		var roty := file.get_16() / 32767.0
		var rotz := file.get_16() / 32767.0
		var rotw := file.get_16() / 32767.0
		var posx := file.get_16() * ScaleX
		var posy := file.get_16() * ScaleY
		var posz := file.get_16() * ScaleZ
		if TimeIndex == 0:
			boneid += 1
	for fr in range(frameCount):
		var framerate := file.get_float()
	for off in range(keyframeCount):
		var offset := file.get_16()
	file.close()
	var root_node := Node3D.new()
	
	var packed_scene := Animation.new()
	#packed_scene.add_track(0)
	packed_scene.add_track(1)
	packed_scene.add_track(2)
	packed_scene.track_set_enabled(0, false)
	packed_scene.track_set_enabled(0, true)
	packed_scene.INTERPOLATION_LINEAR
	packed_scene.loop_mode = Animation.LOOP_LINEAR
	packed_scene.resource_name = source_file.get_file().get_basename()
	packed_scene.length = float(frameCount)
	#packed_scene.animation_track_insert_key(0, float(keyframes[0]), "test")
	#packed_scene.add_track(Animation.TYPE_POSITION_3D)
	#packed_scene.add_track(Animation.TYPE_ROTATION_3D)
	return ResourceSaver.save(packed_scene, "%s.%s" % [save_path, _get_save_extension()])
			
