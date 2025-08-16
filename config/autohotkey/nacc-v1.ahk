:c:Tcs::{
    SendText( "The caller stated" )
}
:c:tcs::{
    SendText( "the caller stated" )
}
::ts::{
    SendText( "the suspect" )
}
::tss::{
    SendText( "the suspects" )
}
::tdi::{ ; Time date ISO
    SendText( FormatTime(,"yyyy-MM-dd") )
}
::tti::{
    SendText( FormatTime(,"HH:mm") )
}
::tdt::{ ; Text
    SendText( FormatTime(,"LongDate") )
}
::ttt::{
    SendText( FormatTime(,"h:mm tt") )
}
::aa::{
    SendText( "at approximately" )
}
::tdti::{
	SendText( FormatTime(,"yyyy-MM-ddTHH:mm:ss") )
}