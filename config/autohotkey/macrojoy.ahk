;macro joystick shortcuts
SetTimer, POV_label, 33

#If GetKeyState("Joy13") == 1 and GetKeyState("Joy5") == 1
Joy1::
	window_id := WinExist("ahk_exe JoyToKey.exe")
	;MsgBox, "Hello. %window_id%",
	if( window_id ){
		WinClose, ahk_exe JoyToKey.exe,
	} else{
		Run, C:\Users\willa\Apps\JoyToKey_en\JoyToKey.exe "Desktop",
	}
return
Joy2::
	window_id := WinExist("ahk_exe DS4Windows.exe")
	;MsgBox, "Hello. %window_id%",
	if( window_id ){
		WinClose, ahk_exe DS4Windows.exe,
	} else{
		Run, C:\Users\willa\Apps\DS4Win\DS4Windows.exe,
	}
return
Joy11::
	window_id := WinExist("ahk_exe UuuClient.exe")
	;MsgBox, "Hello. %window_id%",
	if( window_id ){
		WinClose, ahk_exe UuuClient.exe,
	} else{
		Run, C:\Users\willa\Apps\UUU3011\UuuClient.exe,
	}
return
Joy12::
	window_id := WinExist("ahk_exe cheatengine-x86_64-SSE4-AVX2.exe")
	;MsgBox, "Hello. %window_id%",
	if( window_id ){
		WinClose, ahk_exe cheatengine-x86_64-SSE4-AVX2.exe,
	} else{
		Run, "C:\Program Files\Cheat Engine 7.4\cheatengine-x86_64-SSE4-AVX2.exe",
	}
return
return ; Applications
#If GetKeyState("Joy13") == 1 and GetKeyState("Joy7") == 1
; # Overlays
Joy1::
	;MsgBox, "Toggle MSI AB"
	SendInput +{Numpad1}
return
Joy2::
	;Start benchmark
	SendInput +{Numpad5}
return
Joy3::
	;End benchmark
	SendInput +{Numpad6}
return
Joy4::
	;Steam overlay
	SendInput +{Tab}
return
Joy6::
	;MsgBox, "Screenshot."
	SendInput {F12}
return
Joy8::
	;MsgBox, "Joy13 and Joy8 pressed."
	SendInput +{Numpad8}
return
return ; Overlays
#If GetKeyState("Joy13") == 1 and WinActive("ahk_exe outcast.exe")
;MsgBox, "OutCast active"
Joy11::
	SendInput {F2}
return
return ;Outcast

/*
;###### For Desolate
Joy1::
	SendInput ``Teleport{Enter}
return
Joy4::
	SendInput ``ToggleDebugCamera{Enter}
return
*/
POV_label:
	if( GetKeyState("Joy13") == 1 ){
		joy_pov := GetKeyState("JoyPOV")
/*
		if( joy_pov != -1 ){
			MsgBox, "JoyPOV: %joy_pov%"
		}
*/
		if( joy_pov == 18000 ){
			gosub POV_Down
		} else if( joy_pov == 0 ){
			gosub POV_Up
		}
	}
return
POV_Down:
	;MsgBox, QuickSave
	WinGetActiveTitle window_title
	;MsgBox, %window_title%
	if( window_title == "Oblivion" ){
		base_filepath := "C:\Users\willa\Documents\my games\Oblivion\Saves\quicksave.ess"
		;base_filepath := "C:\Users\willa\UnsyncedDocuments\filea.txt"
		CycleSaves( base_filepath )
		SendInput {F5}
	} else if( window_title == "Outcast-SecondContact" ){
		SendInput {F1}
	}
return
POV_Up:
	WinGetActiveTitle window_title
	if( window_title == "Outcast-SecondContact" ){
		SendInput {F3}
	}
return
#If
CycleSaves( base_filepath ){
	;MsgBox, %base_filepath%
	SplitPath, base_filepath, base_filename, base_directory, base_extension, base_name
	slot2_filepath := base_directory . "\" . base_name . "2" . "." . base_extension
	;MsgBox, %slot2_filepath%
	slot3_filepath := base_directory . "\" . base_name . "3" . "." . base_extension
	;MsgBox, %slot3_filepath%
	function_return := FileExist( slot2_filepath )
	;MsgBox, %function_return% %ErrorLevel%	%A_LastError%
	if( FileExist( slot2_filepath ) ){
		FileCopy, %slot2_filepath%, %slot3_filepath%, 1
		;MsgBox, 2 -> 3
	}
	FileCopy, %base_filepath%, %slot2_filepath%, 1
	return %ErrorLevel%
}
Joy5::
	joy_pov := GetKeyState("JoyPOV")
	if( joy_pov != -1 ){
		direction := Round(joy_pov/4500)
		direction++
		if( direction == 9 ){
			direction := 1
		}
		SendInput %direction%
		;MsgBox, "direction: %direction%",
	}
return

/*
Joy6::
MsgBox, "Hello."
if( GetKeyState("Joy13") == 1 && GetKeyState("Joy6") == 1 ){
	MsgBox, "Joy13+Joy6"
}
return
*/