; Bioshock 2 Remastered cycle quicksaves.
; joy13::
F5::
WinGetActiveTitle window_title
; MsgBox, "window_title: %window_title%"
if( window_title == "BioShock 2" ){
	base_directory := "C:\Users\willa\Documents\BioshockHD\BioShock2\SaveGames\"
	base_path := base_directory . "DLCQuicksave.bsb"
	function_return := FileExist( base_path )
	; MsgBox, "base_path: %base_path%`nfunction_return: %function_return%`n%ErrorLevel% (%A_LastError%)"
	qs2_path := base_path . ".2"
	qs3_path := base_path . ".3"
	function_return := FileExist( qs2_path )
	; MsgBox, "qs2_path: %qs2_path%`nfunction_return: %function_return%`n%ErrorLevel% (%A_LastError%)"
	if( function_return ){
		FileCopy, %qs2_path%, %qs3_path%, 1
		; MsgBox, "Copying qs2 to qs3 returned: %function_return%`n%ErrorLevel% (%A_LastError%)"
	}
	FileCopy, %base_path%, %qs2_path%, 1
	SendInput {F11}
	; MsgBox, "Copying qs1 to qs2 returned: %function_return%`n%ErrorLevel% (%A_LastError%)"
}

; base_directory := "C:\Users\willa\Documents\BioshockHD\BioShock2\SaveGames\"
; base_path := base_directory . "Quicksave.bsb"
; MsgBox, "directory: %base_directory% `n path: %base_path%"
/*
function_return := FileExist( "C:\Users\willa\UnsyncedDocuments\filea.txt" )
MsgBox, "function_return: %function_return% ErrorLevel: %ErrorLevel% A_WorkingDir: %A_WorkingDir% A_IsAdmin: %A_IsAdmin%"
FileRead, file_contents, C:\Users\willa\UnsyncedDocuments\filea.txt
MsgBox, "file_contents: %file_contents%`nErrorLevel: %ErrorLevel% A_LastError: %A_LastError%"
try{
	FileCopy, C:\Users\willa\UnsyncedDocuments\filea.txt, C:\Users\willa\UnsyncedDocuments\fileb.txt, 0
	MsgBox, "return: %function_return%`n%ErrorLevel% (%A_LastError%)"
	ExitApp
} catch error {
	MsgBox, "error: %error%"
}
*/
return
