#!/usr/local/bin/powershell

Function Set-ProcessPriority( $name, $priority = 2 ){
	$process_object = Get-Process -Name $name;
	$real_priority = [System.Diagnostic.ProcessPriorityClass]::Normal;
	switch( $priority ){
		0 { $real_priority = [System.Diagnostic.ProcessPriorityClass]::Idle; break; }
		1 { $real_priority = [System.Diagnostic.ProcessPriorityClass]::BelowNormal; break; }
		2 { $real_priority = [System.Diagnostic.ProcessPriorityClass]::Normal; break; }
		3 { $real_priority = [System.Diagnostic.ProcessPriorityClass]::AboveNormal; break; }
		4 { $real_priority = [System.Diagnostic.ProcessPriorityClass]::High; break; }
		5 { $real_priority = [System.Diagnostic.ProcessPriorityClass]::RealTime; break; }
	}
	$process_object.PriorityClass = $real_priority;
}
