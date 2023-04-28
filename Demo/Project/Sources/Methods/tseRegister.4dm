//%attributes = {}
var $vt_name : Text

$vt_name:="NeueKasse"

CONFIRM:C162("TSE \""+$vt_name+"\" anmelden?")

If (OK=1)
	
	tseRegisterClient($vt_name)
	
End if 
