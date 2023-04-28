//%attributes = {"preemptive":"capable"}
#DECLARE($vo_tse : cs:C1710.tse; $vt_clientID : Text)->$vf_started : Boolean

//Debug_ToFile("try re-connect")

Storage:C1525.tse.connected:=$vo_tse.connect()
Storage:C1525.tse.opened:=False:C215

$vf_started:=False:C215

If (Storage:C1525.tse.connected)
	
	Storage:C1525.tse.opened:=$vo_tse.openDevice()
	
	If (Storage:C1525.tse.opened)
		
		//Debug_ToFile("re-opened")
		
		If ($vo_tse.authenticateUser($vt_clientID; "12345"; "EPSONKEY"))
			
			$vo_tse.updateDateTime($vt_clientID; True:C214)
			Storage:C1525.tse.currentUser:=$vt_clientID
			//Debug_ToFile("clientID registered: "+$vt_clientID)
			
			//start again...
			$vf_started:=$vo_tse.startTransaction($vt_clientID; ""; "")
			
		End if 
		
	Else 
		//Debug_ToFile("re-open failed")
	End if 
	
Else 
	//Debug_ToFile("re-connect failed")
End if 
