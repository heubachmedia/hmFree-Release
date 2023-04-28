//%attributes = {"preemptive":"capable"}
#DECLARE($vt_clientID : Text; $vc_summen : Collection; $vf_bar : Boolean)->$vo_lastTransaction : cs:C1710.tseTransaction

var $vo_tse : cs:C1710.tse
var $vo_beleg : cs:C1710.tseKassenbeleg
var $vf_started; $vf_authUser; $tse_connected; $tse_opened : Boolean
var $tse_currentUser : Text

$vo_beleg:=cs:C1710.tseKassenbeleg.new()
$vo_beleg.addUmsatz($vc_summen[0]; 1)
$vo_beleg.addUmsatz($vc_summen[1]; 2)
$vo_beleg.addUmsatz($vc_summen[2]; 5)
$vo_beleg.addZahlung(Round:C94($vc_summen.sum(); 2); $vf_bar)

//Pro Arbeitsstation -> gehört evtl. in Storage rein!
$tse_connected:=False:C215
$tse_opened:=False:C215
$tse_currentUser:=""

$vo_tse:=cs:C1710.tse.new(2; "127.0.0.1"; "local_TSE")

//======

If ($tse_connected)
	
	//Debug_ToFile("Already connected")
	
Else 
	
	$tse_connected:=$vo_tse.connect()
	//Debug_ToFile("Connect")
	
End if 

If ($tse_connected)
	
	If ($tse_opened)
		
		//Debug_ToFile("Device is open!")
		
	Else 
		
		//Debug_ToFile("Open Device")
		
		$tse_opened:=$vo_tse.openDevice()
		
		If (Not:C34($tse_opened))
			If ($vo_tse.needToRunSelfTest($vt_clientID))
				$tse_opened:=$vo_tse.openDevice()
			End if 
		End if 
		
		If ($tse_opened)
			//Debug_ToFile("Device open")
		Else 
			//Debug_ToFile("Device NOT opened")
		End if 
		
	End if 
	
	If ($tse_opened)
		
		If ($tse_currentUser=$vt_clientID)
			
			//Debug_ToFile("User is already authenticated: "+$vt_clientID)
			
		Else 
			
			//Debug_ToFile("Authenticate User: "+$vt_clientID)
			
			$vf_authUser:=$vo_tse.authenticateUser($vt_clientID; "12345"; "EPSONKEY")
			
			If (Not:C34($vf_authUser))
				If ($vo_tse.needToRunSelfTest($vt_clientID))
					$vf_authUser:=$vo_tse.authenticateUser($vt_clientID; "12345"; "EPSONKEY")
				End if 
			End if 
			
			If ($vf_authUser)
				$vo_tse.updateDateTime($vt_clientID; True:C214)
				$tse_currentUser:=$vt_clientID
				//Debug_ToFile("clientID registered: "+$vt_clientID)
			End if 
			
		End if 
		
		If ($tse_currentUser=$vt_clientID)
			
			//Debug_ToFile("Try to start transaction")
			
			$vf_started:=$vo_tse.startTransaction($vt_clientID; ""; "")
			
			If ($vf_started)
				//Debug_ToFile("Started!")
			Else 
				//Debug_ToFile("Not started!")
			End if 
			
			If (Not:C34($vf_started))
				
				If ($vo_tse.needToRunSelfTest($vt_clientID))  //If (Not($vf_started)) && ($vo_tse.lastError=-9002)
					$vf_started:=$vo_tse.startTransaction($vt_clientID; ""; "")
				End if 
				
			End if 
			
			If (Not:C34($vf_started))
				If ($vo_tse.lastError=-9002)  //Connection failed? -> Dann reconnect
					//$vf_started:=tseReconnect($vo_tse; $vt_clientID)
				End if 
			End if 
			
			If ($vf_started)
				
				//Debug_ToFile("transaction started: "+$vt_clientID+" - id: "+String($vo_tse.statusInternal.transaction.transactionNumber))
				
				$vo_tse.finishTransaction($vt_clientID; $vo_tse.statusInternal.transaction.transactionNumber; $vo_beleg.getProcessData(); $vo_beleg.getProcessType())
				$vo_lastTransaction:=$vo_tse.getLastTransaction($vt_clientID)
				
				If ($vo_lastTransaction#Null:C1517)
					//Debug_ToFile("transaction finished")
				Else 
					//Debug_ToFile("transaction failed")
				End if 
				
			End if 
			
		End if 
		
	End if 
	
End if 

If ($vo_tse#Null:C1517)
	
	If ($vo_tse.statusInternal#Null:C1517)
		If ($vo_tse.statusInternal.transaction#Null:C1517)
			OB REMOVE:C1226($vo_tse.statusInternal; "transaction")  //entfernen, da evtl. Blobs drin sind
		End if 
	End if 
	
End if 
