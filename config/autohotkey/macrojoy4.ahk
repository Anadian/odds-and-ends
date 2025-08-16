;macro joystick shortcuts

; # Turbo key settings.
SetTimer(Tick30Hz, 33)
repeating := 0
turbo_key := "{Enter}"
controller_modifier := "Joy13" ; PS button/Xbox home

; # Utility

EmergencyStop(){ ;Emergency stop
	global
	MsgBox( Format( "repeating: {:i} turbokey: {:s}.", repeating, turbo_key ) )
	repeating := 0
	ExitApp( 2 )
}	
ToggleRepeat(){ ;Start repeat
	global
	;MsgBox("Starting repeat?")
	if( repeating == 0 ){
		repeating := 1
	} else{
		repeating := 0
	}
}
Tick30Hz(){
	;Pause()
	TickPOV()
	if( repeating == 1 ){
		Send( turbo_key )
	}
} ;Tick30Hz
TickPOV(){
	global
	if( GetKeyState( controller_modifier ) == 1 ){
		joy_pov := GetKeyState("JoyPOV")
		if( joy_pov == 27000 ){
			POV_Left()
		} else if( joy_pov == 18000 ){
			POV_Down()
		} else if( joy_pov == 9000 ){
			POV_Right()
		} else if( joy_pov == 0 ){
			POV_Up()
		}
	}
}
POV_Left(){
	window_title := WinGetTitle("A") ; WinGetActiveTitle window_title
	;MsgBox(window_title)
	if( window_title == "Skyrim Special Edition" ){
		Loop Files, "C:\Users\willa\Documents\my games\Skyrim Special Edition\Saves\Quicksave0_42A7B4A5_0_44656369736961*.ess"{
			SplitPath( A_LoopFileFullPath, &filename, &dir, &ext, &name )
		}
		slot1_basepath := dir . "\" . name
		;MsgBox(base_filepath)
		slot2_basepath := dir . "\" . "Quicksave2_42A7B4A5_0_44656369736961"
		;MsgBox(slot2_filepath)
		slot3_basepath := dir . "\" . "Quicksave3_42A7B4A5_0_44656369736961"
		CycleFiles( (slot1_basepath . ".ess"), (slot2_basepath . ".ess"), ("slot3_basepath" . ".ess") )
		CycleFiles( (slot1_basepath . ".skse"), (slot2_basepath . ".skse"), ("slot3_basepath" . ".skse") ) 
		SendInput("{F5}")
	}
}
POV_Down(){
	;MsgBox, QuickSave
	window_title := WinGetTitle("A") ; WinGetActiveTitle window_title
	;MsgBox(window_title)
	if( window_title == "Oblivion" ){
		base_filepath := "C:\Users\willa\Documents\my games\Oblivion\Saves\quicksave.ess"
		;base_filepath := "C:\Users\willa\UnsyncedDocuments\filea.txt"
		CycleSaves( base_filepath )
		SendInput("{F5}")
	} else if( window_title == "Outcast-SecondContact" ){
		SendInput("{F1}")
	} else{
		SendInput("{F5}")
	}
}
POV_Right(){
	Loop Files, "C:\Users\willa\Documents\my games\Skyrim Special Edition\Saves\*.skse"{
		SplitPath( A_LoopFileFullPath, &filename, &dir, &ext, &name )
		check_path := dir . "\" . name . ".ess"
		if( !FileExist(check_path) ){
			FileDelete( A_LoopFileFullPath )
		}
	}
}
POV_Up(){
	window_title := WinGetTitle("A") ; WinGetActiveTitle window_title
	if( window_title == "Outcast-SecondContact" ){
		SendInput("{F3}")
	}
}
GetJoyInfo(){
	joy_name := GetKeyState("JoyName")
	joy_buttons := GetKeyState("JoyButtons")
	joy_axes := GetKeyState("JoyAxes")
	joy_info := GetKeyState("JoyInfo")
	MsgBox( Format( "name: {:s} buttons: {:i} axes: {:i} info: {:s}", joy_name, joy_buttons, joy_axes, joy_info ) )
	return
}
CycleFiles( slot1, slot2, slot3 ){
	if( FileExist( slot2 ) ){
		FileCopy( slot2, slot3, 1 )
		;MsgBox, 2 -> 3
	}
	FileCopy( slot1, slot2, 1 )
}
CycleSaves( base_filepath ){
	;MsgBox, %base_filepath%
	SplitPath( base_filepath, &base_filename, &base_directory, &base_extension, &base_name )
	slot2_filepath := base_directory . "\" . base_name . "2" . "." . base_extension
	;MsgBox, %slot2_filepath%
	slot3_filepath := base_directory . "\" . base_name . "3" . "." . base_extension
	CycleFiles( base_filepath, slot2_filepath, slot3_filepath )
}

; # OpenApps
ToggleEXE( path, arguments := "" ){
	SplitPath( path, &filename, &dir, &ext, &name, &drive )
	lookup_string := "ahk_exe" . " " . filename
	;MsgBox( lookup_string )
	window_id := WinExist( lookup_string )
	if( window_id ){
		WinClose( lookup_string )
	} else{
		Run( path . " " . arguments )
	}
	return
}
OpenJoyToKey(){
	ToggleEXE( "C:\ProgramData\chocolatey\lib\joytokey\tools\JoyToKey.exe", "`"Desktop`"" )
}
OpenDS4Windows(){
	ToggleEXE( "C:\ProgramData\chocolatey\lib\ds4windows\tools\DS4Windows\DS4Windows.exe" )
}
OpenMSIAfterburner(){
	ToggleEXE( "C:\Program Files (x86)\MSI Afterburner\MSIAfterburner.exe" )
}
OpenU3Client(){
	ToggleEXE( "C:\Users\willa\apps\UUU3021\UuuClient.exe" )
}
OpenCheatEngine(){
	ToggleEXE( "C:\Program Files\Cheat Engine 7.5\cheatengine-x86_64-SSE4-AVX2.exe" )
}
OpenTaskScheduler(){
	ToggleEXE( "C:\Windows\System32\taskschd.msc", "/s" )
}

; # Keyboard shortcuts
+Backspace::EmergencyStop()
+Enter::ToggleRepeat()
^!c::OpenCheatEngine()
^!d::OpenDS4Windows()
^!j::GetJoyInfo()
^!k::OpenJoyToKey()
^!m::OpenMSIAfterburner()
^!r::OpenTaskScheduler()
^!u::OpenU3Client()

#HotIf GetKeyState("Joy13") == 1 and GetKeyState("Joy8") == 1
Joy1::{ ;PS+R2+Square
	OpenJoyToKey()
}
Joy2::{ ;PS+R2+Cross
	OpenDS4Windows()
}
Joy3::{ ;PS+R2+Circle
	OpenMSIAfterburner()
}
Joy11::{ ;PS+R2+L3
	OpenU3Client()
}
Joy12::{ ;PS+R2+R3
	OpenCheatEngine()
}
;return ; Applications
#HotIf GetKeyState("Joy13") == 1 and GetKeyState("Joy7") == 1
; # Overlays
Joy1::{ ;PS+L2+Square
	;MsgBox, "Toggle MSI AB"
	SendInput("+{Numpad1}")
}
Joy2::{ ;PS+L2+Cross
	;Start benchmark
	SendInput("+{Numpad5}")
}
Joy3::{ ;PS+L2+Circle
	;End benchmark
	SendInput("+{Numpad6}")
}
Joy4::{ ;PS+L2+Triangle
	;Steam overlay
	SendInput("+{Tab}")
}
Joy5::{ ;PS+L2+L1
	;MsgBox, "Joy13 and Joy8 pressed. Toggle Recording"
	SendInput("+{Numpad8}")
}
Joy6::{ ;PS+L2+R1
	;MsgBox, "Screenshot."
	SendInput("{F12}")
}
;return ; Overlays
#HotIf GetKeyState("Joy13") == 1 and WinActive("ahk_exe TOEM.exe")
Joy1::{
	Loop( 500 ){
		SendInput "{d down}"
		sleep( 5000 )
		SendInput "{d up}"
		SendInput "{a down}"
		sleep( 5000 )
		SendInput "{a up}"
	}
}	
#HotIf WinActive("ahk_exe Fallout76.exe")
NumpadEnter::{
	;MsgBox("NumpadEnter pressed.")
	SendMode("Event")
	SetKeyDelay( 0, 20, )
	Loop( 500 ){
		Send("e")
		Sleep(3000)
		Send("{tab}")
		Sleep(5000)
		Send("r")
		Sleep(4000)
		Send("{space}")
		Sleep(3000)
		Send("{tab}")
		Sleep(5000)
	}
}
#HotIf WinActive("ahk_exe GWT.exe")
Enter::{
	;MsgBox("NumpadEnter pressed.")
	SendMode("Event")
	SetKeyDelay( 0, 20, )
	Loop( 500 ){
		Send("Enter")
		Sleep(1000)
	}
}

#HotIf GetKeyState("Joy13") == 1 and WinActive("ahk_exe outcast.exe")
;MsgBox, "OutCast active"
Joy11::{
	SendInput("{F2}")
}
;return ;Outcast


;###### For UE4
#HotIf GetKeyState("Joy13") == 2 and WinActive("ahk_exe CodeVein-Win64-Shipping.exe")
Joy1::{
	SendInput("``Teleport{Enter}")
}
Joy4::{
	SendInput("``ToggleDebugCamera{Enter}")
}

#HotIf

Joy5::{ ;PS+L1
	joy_pov := GetKeyState("JoyPOV")
	if( joy_pov != -1 ){
		direction := Round(joy_pov/4500)
		direction++
		if( direction == 9 ){
			direction := 1
		}
		SendInput("%direction%")
		;MsgBox, "direction: %direction%",
	}
}

/*
Joy6::{
MsgBox, "Hello."
if( GetKeyState("Joy13") == 1 && GetKeyState("Joy6") == 1 ){
	MsgBox, "Joy13+Joy6"
}
}
*/
