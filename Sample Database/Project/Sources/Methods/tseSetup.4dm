//%attributes = {}
var $vo_tse : cs:C1710.tse
var $vf_ok : Boolean
var $vt_errorText : Text

$vo_tse:=cs:C1710.tse.new(2; "127.0.0.1"; "local_TSE")
$vt_errorText:=""

If ($vo_tse.connect())
	
	If ($vo_tse.openDevice())
		
		$vf_ok:=$vo_tse.setup("12345"; "12345"; "123456")
		If (Not:C34($vf_ok))
			$vt_errorText:=$vo_tse.lastErrorText
		End if 
		
		$vo_tse.closeDevice()
		
	End if 
	
	$vo_tse.disconnect()
	
End if 

If ($vf_ok)
	ALERT:C41("TSE erfolgreich eingerichtet!")
Else 
	ALERT:C41($vt_errorText)
End if 
