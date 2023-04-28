//%attributes = {}
#DECLARE($vt_clientID : Text)

var $vo_tse : cs:C1710.tse
var $vf_ok : Boolean
var $vt_errorText : Text
var $vc_clients : Collection

$vo_tse:=cs:C1710.tse.new(2; "127.0.0.1"; "local_TSE")
$vt_errorText:=""

If ($vo_tse.connect())
	
	If ($vo_tse.openDevice())
		
		If ($vo_tse.authenticateUser("Administrator"; "12345"; "EPSONKEY"))
			
			$vc_clients:=$vo_tse.getRegisteredClients()
			
			If ($vc_clients.indexOf($vt_clientID)=-1)
				
				$vf_ok:=$vo_tse.registerClient($vt_clientID)
				
				If (Not:C34($vf_ok))
					$vt_errorText:=$vo_tse.lastErrorText
				End if 
				
			Else 
				$vt_errorText:="Client bereits angemeldet!"
				$vf_ok:=False:C215
			End if 
			
		End if 
		
		$vo_tse.closeDevice()
		
	End if 
	
	$vo_tse.disconnect()
	
End if 

If ($vf_ok)
	ALERT:C41("Erfolgreich angemeldet!")
Else 
	ALERT:C41($vt_errorText)
End if 
