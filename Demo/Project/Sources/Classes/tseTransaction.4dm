Class constructor($vl_id : Integer; $vt_clientID : Text)
	This:C1470.id:=$vl_id
	This:C1470.clientID:=$vt_clientID
	This:C1470.logTime:=0
	This:C1470.startLogTime:=0
	This:C1470.signatureCounter:=0
	This:C1470.serialNumber:=Null:C1517
	This:C1470.signatureValue:=Null:C1517
	
Function getdate()->$vd_date : Date
	var $vl_seconds : Integer
	
	If (This:C1470.logTime=0)
		
		$vd_date:=!00-00-00!
		
	Else 
		
		$vl_seconds:=This:C1470.logTime%86400
		
		$vd_date:=!1970-01-01!+((This:C1470.logTime-$vl_seconds)/86400)
		
	End if 
	
Function getstartDate()->$vd_date : Date
	var $vl_seconds : Integer
	
	If (This:C1470.startLogTime=0)
		
		$vd_date:=!00-00-00!
		
	Else 
		
		$vl_seconds:=This:C1470.startLogTime%86400
		
		$vd_date:=!1970-01-01!+((This:C1470.startLogTime-$vl_seconds)/86400)
		
	End if 
	
Function gettime() : Integer
	$0:=(This:C1470.logTime%86400)
	
Function getstartTime() : Integer
	$0:=(This:C1470.startLogTime%86400)
	
Function getsignatureBase64()->$vt_base64 : Text
	var $vx_blob : Blob
	
	If (This:C1470.signatureValue#Null:C1517)
		
		$vx_blob:=This:C1470.signatureValue
		
		BASE64 ENCODE:C895($vx_blob; $vt_base64)
		
	Else 
		
		$vt_base64:=""
		
	End if 
	
Function getserialNumberBase64()->$vt_base64 : Text
	var $vx_blob : Blob
	
	If (This:C1470.serialNumber#Null:C1517)
		
		$vx_blob:=This:C1470.serialNumber
		
		BASE64 ENCODE:C895($vx_blob; $vt_base64)
		
	Else 
		
		$vt_base64:=""
		
	End if 
	
Function getserialNumberHEX()->$vt_hex : Text
	var $vx_blob : Blob
	var $i : Integer
	
	$vx_blob:=This:C1470.serialNumber
	$vt_hex:=""
	
	For ($i; 1; BLOB size:C605($vx_blob))
		
		$vt_hex:=$vt_hex+Substring:C12(String:C10($vx_blob{$i-1}; "&x"); 5; 2)
		
	End for 
	